import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'failure.dart';

class HttpErrorUtil {
  // general methods:-----------------------------------------------------------
  static String handleError(dynamic error) {
    String errorDescription = "";
    if (error is DioException) {
      if (error.response != null && error.response?.data != null) {
        try {
          // var errorRs = ErrorGeneral.fromJson(error.response?.data as Map) ;
          var errorRs = error.response?.data['message'];
          return errorRs ?? '';
        } catch (e) {}
      }
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = 'Kết nối bị huỷ'.tr;
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = 'Thời gian kết nối hết hạn'.tr;
          break;
        case DioExceptionType.unknown:
          errorDescription = 'Lỗi không xác định'.tr;
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = 'Thời gian nhận hết hạn'.tr;
          break;
        case DioExceptionType.badResponse:
          errorDescription = 'Lỗi kết quả trả về'.tr;
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = 'Thời gian yêu cầu hết hạn'.tr;
          break;
        case DioExceptionType.badCertificate:
          // TODO: Handle this case.
          break;
        case DioExceptionType.connectionError:
          // TODO: Handle this case.
          break;
      }
    } else if (error is NetworkException) {
      errorDescription = 'Lỗi kết nối'.tr;
    } else {
      errorDescription = 'Lỗi không xác định'.tr;
    }
    return errorDescription;
  }
}
