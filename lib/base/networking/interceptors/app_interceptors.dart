import 'dart:async';


import 'package:dio/dio.dart';
import 'package:food_delivery_app/base/base_controller.dart' as base;
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get_core/src/get_main.dart';


import 'package:shared_preferences/shared_preferences.dart';

// Custom error class to hold API response data
class CustomApiError {
  final String message;
  final int? statusCode;
  final dynamic data;

  CustomApiError({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => message;
}

// Error interceptor to transform API errors
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Transform error to make response data accessible
    if (err.response?.data != null) {
      final responseData = err.response!.data;
      String errorMessage = 'Lỗi không xác định';
      
      // Extract error message from response
      if (responseData is Map<String, dynamic>) {
        errorMessage = responseData['message'] ?? 
                      responseData['error'] ?? 
                      responseData['msg'] ?? 
                      'Lỗi từ server: ${err.response?.statusCode}';
      } else if (responseData is String) {
        errorMessage = responseData;
      }
      
      // Create custom error with response data
      final customError = CustomApiError(
        message: errorMessage,
        statusCode: err.response?.statusCode,
        data: responseData,
      );
      
      // Reject with transformed error
      return handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: customError,
        response: err.response,
        type: err.type,
        message: customError.message,
      ));
    }
    
    // If no response data, pass the original error
    return handler.next(err);
  }
}

class AppInterceptors extends QueuedInterceptorsWrapper {
  final Dio _dio;

  AppInterceptors(this._dio);

  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("base_url")) {
      options.baseUrl = options.headers["base_url"];
      options.headers.remove("base_url");
    }

    if (options.headers.containsKey("requiresToken") &&
        options.headers["requiresToken"] == false) {
      // If the request doesn't need a token, continue to the next interceptor
      options.headers.remove("requiresToken");
      return handler.next(options);
    }

    // Get token from SharedPreferences
    final prefs = Get.find<SharedPreferences>();
    final token = prefs.getString('accessToken');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid
      _handleTokenError();
    }
    return handler.next(err);
  }

  void _handleTokenError() async {
    final prefs = Get.find<SharedPreferences>();
    final refreshToken = prefs.getString('refreshToken');

    if (refreshToken != null) {
      try {
        // Try to refresh token
        final response = await _dio.post(
          '/api/users/refresh-token',
          data: {'refreshToken': refreshToken},
          options: Options(headers: {'requiresToken': false}),
        );

        if (response.statusCode == 200 && response.data != null) {
          // Save new tokens
          await prefs.setString('accessToken', response.data['accessToken']);
          await prefs.setString('refreshToken', response.data['refreshToken']);
          return;
        }
        if (response.statusCode == 401) {
          await prefs.remove('accessToken');
          await prefs.remove('refreshToken');
          await prefs.remove('user');
          Get.offAllNamed(RouterName.login);
        } else {
          print('Failed to refresh token: ${response.statusCode}');

        }
      } catch (e) {
        print('Error refreshing token: $e');
      }
    }
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.remove('user');
    Get.offAllNamed('/login');
  }
}
