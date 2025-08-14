import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/base/networking/interceptors/app_interceptors.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmailController extends BaseController {
  final verificationCode = ''.obs;
  final email = ''.obs;
  final username = ''.obs;
  final fullName = ''.obs;
  final mobileNumber = ''.obs;
  final password = ''.obs;
  final referralCode = ''.obs; // Thêm biến cho mã giới thiệu
  final countdown = 60.obs; // Countdown 60 seconds
  late Timer _timer;
  final canResend = false.obs;
  final expectedCode = ''.obs; // Store the expected verification code

  @override
  @override
  void onInit() {
    super.onInit();

    // Get data from arguments
    if (Get.arguments != null) {
      email.value = Get.arguments['email'] ?? '';
      expectedCode.value = Get.arguments['verificationCode'] ?? '';
      username.value = Get.arguments['username'] ?? '';
      fullName.value = Get.arguments['fullName'] ?? '';
      mobileNumber.value = Get.arguments['mobileNumber'] ?? '';
      password.value = Get.arguments['password'] ?? '';
      referralCode.value = Get.arguments['referralCode'] ?? '';
    } else {
      _loadDataFromStorage();
    }

    // Start countdown
    startCountdown();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void _loadDataFromStorage() async {
    try {
      final prefs = Get.find<SharedPreferences>();

      // Load saved email
      final savedEmail = prefs.getString('pendingVerificationEmail');
      if (savedEmail != null && savedEmail.isNotEmpty) {
        email.value = savedEmail;
      }

      // Load saved verification code (if applicable)
      final savedCode = prefs.getString('pendingVerificationCode');
      if (savedCode != null && savedCode.isNotEmpty) {
        expectedCode.value = savedCode;
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void startCountdown() {
    canResend.value = false;
    countdown.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> verifyEmail() async {
    try {
      // Validate verification code
      if (verificationCode.isEmpty) {
        showError(message: 'Vui lòng nhập mã xác thực');
        return;
      }

      if (verificationCode.value.length < 6) {
        showError(message: 'Mã xác thực phải có ít nhất 6 ký tự');
        return;
      }

      // Debug: In ra giá trị để kiểm tra
      print('Debug - expectedCode: "${expectedCode.value}" (length: ${expectedCode.value.length})');
      print('Debug - verificationCode: "${verificationCode.value}" (length: ${verificationCode.value.length})');
      print('Debug - expectedCode.isEmpty: ${expectedCode.isEmpty}');
      print('Debug - expectedCode.isNotEmpty: ${expectedCode.isNotEmpty}');
      print('Debug - verificationCode.value != expectedCode.value: ${verificationCode.value != expectedCode.value}');

      // Check if the entered verification code matches the expected code
      if (expectedCode.isNotEmpty &&
          verificationCode.value != expectedCode.value) {
        showError(message: 'Mã xác thực không đúng. Vui lòng kiểm tra lại.');
        return;
      }

      // Show loading
      showLoading(message: 'Đang xác thực...');

      try {
        // Call API to verify email
        final response = await authRepositories.verifyEmail(
          email: email.value,
          verificationCode: verificationCode.value,
        );

        // Hide loading
        hideLoading();

        // Show success message
        showSuccess(message: 'Xác thức thành công');

        // Navigate to login screen
        Get.offAllNamed(RouterName.login);
      } catch (apiError) {
        hideLoading();

        // Now the error is already transformed by ErrorInterceptor
        if (apiError is DioException && apiError.error is CustomApiError) {
          final customError = apiError.error as CustomApiError;
          showError(message: customError.message);
        } else {
          // Fallback error handling
          String errorMessage = 'Lỗi xác thực không xác định';

          if (apiError is DioException) {
            errorMessage = 'Lỗi kết nối: ${apiError.message}';
          } else if (apiError is HttpException) {
            errorMessage = apiError.message;
          } else {
            errorMessage = apiError.toString();
          }

          showError(message: errorMessage);
        }
      }
    } catch (e) {
      hideLoading();
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }

  Future<void> resendVerificationCode() async {
    if (!canResend.value) return;

    try {
      await authRepositories.register(
        email: email.value,
        username: username.value,
        password: password.value,
        fullName: fullName.value,
        phoneNumber: mobileNumber.value,
      );
      showSuccess(message: 'Đã gửi lại mã xác thực');
      startCountdown();
    } catch (e) {
      String errorMessage = 'Không thể gửi lại mã';

      // Now the error is already transformed by ErrorInterceptor
      if (e is DioException && e.error is CustomApiError) {
        final customError = e.error as CustomApiError;
        errorMessage = customError.message;
      } else if (e is DioException) {
        errorMessage = 'Lỗi kết nối: ${e.message}';
      } else {
        errorMessage = e.toString();
      }

      showError(message: errorMessage);
    }
  }

  void backToLogin() {
    Get.offAllNamed(RouterName.login);
  }
}