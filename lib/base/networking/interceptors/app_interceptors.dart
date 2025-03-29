import 'dart:async';


import 'package:dio/dio.dart';
import 'package:food_delivery_app/base/base_controller.dart' as base;
import 'package:get/get_core/src/get_main.dart';


import 'package:shared_preferences/shared_preferences.dart';


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
