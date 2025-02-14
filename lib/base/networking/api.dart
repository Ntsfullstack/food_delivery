import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart' as GET;

import '../../x_res/my_config.dart';
import '../../x_utils/connection_util.dart';
import '../../x_utils/failure.dart';

import 'constants/endpoint.dart';
import 'interceptors/app_interceptors.dart';

class ApiService {
  factory ApiService() => ApiService._internal();

  late Dio _dio;

  ApiService._internal() {
    BaseOptions options = BaseOptions(
      // baseUrl: MyConfig.BASE_URL ??  'http://8.9.31.66:3000',
      connectTimeout: const Duration(milliseconds: MyConfig.CONNECTION_TIMEOUT),
      receiveTimeout: const Duration(milliseconds: MyConfig.RECEIVE_TIMEOUT),
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    _dio = Dio(options);
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.interceptors.add(AppInterceptors(_dio));
    _dio.interceptors.add(queuedInterceptorsWrapper());
  }

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
      String uri, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    bool isConnected = await ConnectionUtil.checkConnection();
    if (!isConnected) throw NetworkException();
    try {
      print(uri);
      final response = await _dio.get(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    bool isConnected = await ConnectionUtil.checkConnection();
    if (!isConnected) throw NetworkException();
    try {
      print(uri);
      print(data);
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    bool isConnected = await ConnectionUtil.checkConnection();
    if (!isConnected) throw NetworkException();
    try {
      print(uri);
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    bool isConnected = await ConnectionUtil.checkConnection();
    if (!isConnected) throw NetworkException();
    try {
      print(uri);
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Download:------------------------------------------------------------------
  Future<dynamic> download(
      String uri,
      savePath, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool deleteOnError = true,
        String lengthHeader = Headers.contentLengthHeader,
      }) async {
    try {
      bool isConnected = await ConnectionUtil.checkConnection();
      if (!isConnected) throw NetworkException();
      final response = await _dio.download(uri, savePath,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          deleteOnError: deleteOnError,
          lengthHeader: lengthHeader);
      return response.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  QueuedInterceptorsWrapper queuedInterceptorsWrapper() {
    return QueuedInterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        if (options.headers.containsKey("base_url")) {
          options.baseUrl = options.headers["base_url"];
          options.headers.remove("base_url");
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioError err, handler) {
        handler.next(err);
      },
    );
  }
}
