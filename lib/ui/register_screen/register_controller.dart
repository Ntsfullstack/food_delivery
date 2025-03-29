import 'package:food_delivery_app/base/base_controller.dart';

import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  final fullName = ''.obs;
  final username = ''.obs;
  final email = ''.obs;
  final mobileNumber = ''.obs;
  final password = ''.obs;
  final referralCode = ''.obs; // Thêm biến cho mã giới thiệu
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signUp() async {
    try {
      // Validate required inputs
      if (fullName.isEmpty ||
          username.isEmpty ||
          email.isEmpty ||
          mobileNumber.isEmpty ||
          password.isEmpty) {
        showError(message: 'Vui lòng điền đầy đủ thông tin');
        return;
      }

      // Email validation
      if (!GetUtils.isEmail(email.value)) {
        showError(message: 'Email không hợp lệ');
        return;
      }

      // Password validation (at least 6 characters)
      if (password.value.length < 6) {
        showError(message: 'Mật khẩu phải có ít nhất 6 ký tự');
        return;
      }

      // Show loading
      showLoading(message: 'Đang đăng ký...');

      try {
        // Thêm tham số referralCode vào API call
        final registerResponse = await authRepositories.register(
          username: username.value,
          email: email.value,
          password: password.value,
          fullName: fullName.value,
          phoneNumber: mobileNumber.value,
          referralCode: referralCode.value, // Truyền mã giới thiệu (nếu có)
        );

        // Hide loading
        hideLoading();

        // Show success message
        showSuccess(message: registerResponse.message);

        // Navigate to OTP screen with the necessary data
        Get.toNamed(
          RouterName.verifyOTP,
          arguments: {
            'email': registerResponse.email,
          },
        );
      } catch (apiError) {
        hideLoading();
        showError(message: 'Lỗi đăng ký: $apiError');
      }
    } catch (e) {
      hideLoading();
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }

  // Google sign-up method
  Future<void> signUpWithGoogle() async {
    try {
      showLoading(message: 'Đang đăng nhập với Google...');

      // TODO: Implement Google Sign-In with Firebase or your auth provider
      await Future.delayed(const Duration(seconds: 2));

      hideLoading();
      Get.offAllNamed(RouterName.bottomNavigation);
    } catch (e) {
      hideLoading();
      showError(message: 'Đăng nhập Google thất bại: $e');
    }
  }

  // Microsoft sign-up method
  Future<void> signUpWithMicrosoft() async {
    try {
      showLoading(message: 'Đang đăng nhập với Microsoft...');

      // TODO: Implement Microsoft Sign-In with your auth provider
      await Future.delayed(const Duration(seconds: 2));

      hideLoading();
      Get.offAllNamed(RouterName.bottomNavigation);
    } catch (e) {
      hideLoading();
      showError(message: 'Đăng nhập Microsoft thất bại: $e');
    }
  }
}
