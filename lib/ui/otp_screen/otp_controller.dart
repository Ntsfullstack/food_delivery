import 'dart:async';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyEmailController extends BaseController {
  final verificationCode = ''.obs;
  final email = ''.obs;
  final token = ''.obs; // Store the token
  final countdown = 60.obs; // Countdown 60 seconds
  late Timer _timer;
  final canResend = false.obs;
  final expectedCode = ''.obs; // Store the expected verification code

  @override
  void onInit() {
    super.onInit();

    // Get email and token from arguments or SharedPreferences
    if (Get.arguments != null) {
      if (Get.arguments['email'] != null) {
        email.value = Get.arguments['email'];
      }
      if (Get.arguments['token'] != null) {
        token.value = Get.arguments['token'];
      }
      if (Get.arguments['codes'] != null) {
        expectedCode.value = Get.arguments['codes'].toString();
      }
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

      // Load saved token
      final savedToken = prefs.getString('registerToken');
      if (savedToken != null && savedToken.isNotEmpty) {
        token.value = savedToken;
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

      // Check if the entered verification code matches the expected code
      if (expectedCode.isNotEmpty && verificationCode.value != expectedCode.value) {
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
          token: token.value,
        );

        // Hide loading
        hideLoading();

        // Show success message
        showSuccess(message: 'Xác thực email thành công. Vui lòng đăng nhập.');

        // Navigate to login screen
        Get.offAllNamed(RouterName.login);
      } catch (apiError) {
        hideLoading();
        showError(message: 'Lỗi xác thực: $apiError');
      }
    } catch (e) {
      hideLoading();
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }

  Future<void> resendVerificationCode() async {
    if (!canResend.value) return;

    try {
      showLoading(message: 'Đang gửi lại mã...');

      // Call API to resend verification code
      await authRepositories.resendEmailVerification(email: email.value);

      hideLoading();
      showSuccess(message: 'Đã gửi lại mã xác thực');

      // Reset countdown
      startCountdown();
    } catch (e) {
      hideLoading();
      showError(message: 'Không thể gửi lại mã: $e');
    }
  }

  void backToLogin() {
    Get.offAllNamed(RouterName.login);
  }
}