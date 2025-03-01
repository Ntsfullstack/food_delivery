import 'dart:async';

import 'package:dio/dio.dart';


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

    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response options, ResponseInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
