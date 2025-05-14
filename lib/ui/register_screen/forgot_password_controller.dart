import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/routes/router_name.dart';

enum ResetPasswordState {
  enterEmail,
  verifyOtp,
  resetPassword,
}

class ForgotPasswordController extends BaseController {
  // Observable properties
  final email = ''.obs;
  final resetState = ResetPasswordState.enterEmail.obs;

  // OTP related
  final otpDigits =
      ['', '', '', '', '', ''].obs; // Chuyển từ 4 phần tử lên 6 phần tử
  final timeLeft = 60.obs;
  Timer? _timer;

  // Password related
  final newPassword = ''.obs;
  final confirmPassword = ''.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final passwordStrength = 0.obs;
  final passwordError = ''.obs;

  // Add new observable for password
  final password = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Setup listeners for password strength
    debounce(
      newPassword,
      (_) => checkPasswordStrength(),
      time: const Duration(milliseconds: 300),
    );

    // Thêm listener cho password
    debounce(
      password,
      (_) => checkPasswordForEnterScreen(),
      time: const Duration(milliseconds: 300),
    );

    debounce(
      confirmPassword,
      (_) => validatePasswordMatch(),
      time: const Duration(milliseconds: 300),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void forgotPassword() async {
    final response = await authRepositories.forgotPassword(
      email: email.value,
    );
  }

  // Update OTP digit
  void updateOtpDigit(int index, String value) {
    if (index >= 0 && index < otpDigits.length) {
      final tempList = [...otpDigits];
      tempList[index] = value;
      otpDigits.value = tempList;
    }
  }

  // Send reset code
  Future<void> sendResetCode() async {
    try {
      // Validate email
      if (email.isEmpty) {
        showError(message: 'Vui lòng nhập email của bạn');
        return;
      }

      if (!GetUtils.isEmail(email.value)) {
        showError(message: 'Email không hợp lệ');
        return;
      }

      // Show loading
      showLoading(message: 'Đang gửi mã xác thực...');

      forgotPassword();
      // Simulate API call

      // Hide loading
      hideLoading();

      // Change state and start timer
      resetState.value = ResetPasswordState.verifyOtp;
      startTimer();

      // Show success message
      showSuccess(message: 'Mã xác thực đã được gửi vào email của bạn');
    } catch (e) {
      hideLoading();
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }

  // Start countdown timer
  void startTimer() {
    timeLeft.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
      }
    });
  }

  // Resend OTP code
  Future<void> resendCode() async {
    try {
      showLoading(message: 'Đang gửi lại mã...');

      // Simulate API call

      hideLoading();
      startTimer();

      showSuccess(message: 'Mã xác thực mới đã được gửi vào email của bạn');
    } catch (e) {
      hideLoading();
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }

  // Verify OTP
  Future<void> verifyOtp() async {
    try {
      // Kiểm tra xem đã điền đủ OTP chưa
      if (otpDigits.any((digit) => digit.isEmpty)) {
        showError(message: 'Vui lòng nhập đủ 6 số');
        return;
      }

      final fullOtp = otpDigits.join();
      print('Full OTP: $fullOtp');

      // Show loading
      showLoading(message: 'Đang xác thực mã...');

      // Simulate API call
      // TODO: Add actual API verification call here
      await Future.delayed(const Duration(seconds: 1));

      // Hide loading
      hideLoading();

      // Move directly to reset password step instead of enter password
      resetState.value = ResetPasswordState.resetPassword;
    } catch (e) {
      hideLoading();
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }

  // Check password strength
  void checkPasswordStrength() {
    final password = newPassword.value;
    passwordError.value = '';

    if (password.isEmpty) {
      passwordStrength.value = 0;
      return;
    }

    // Calculate strength
    int strength = 0;

    if (password.length >= 8) {
      strength++;
    } else {
      passwordError.value = 'Mật khẩu phải có ít nhất 8 ký tự';
    }

    if (password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]'))) {
      strength++;
    }

    if (password.contains(RegExp(r'[0-9]')) ||
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      strength++;
    }

    passwordStrength.value = strength;
  }

  // Thêm phương thức mới để kiểm tra mật khẩu ở màn hình nhập
  void checkPasswordForEnterScreen() {
    final pwd = password.value;

    if (pwd.isEmpty) {
      passwordStrength.value = 0;
      return;
    }

    int strength = 0;

    if (pwd.length >= 8) {
      strength++;
    }

    if (pwd.contains(RegExp(r'[A-Z]')) && pwd.contains(RegExp(r'[a-z]'))) {
      strength++;
    }

    if (pwd.contains(RegExp(r'[0-9]')) ||
        pwd.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      strength++;
    }

    passwordStrength.value = strength;
  }

  // Validate password match
  void validatePasswordMatch() {
    if (confirmPassword.isNotEmpty &&
        confirmPassword.value != newPassword.value) {
      passwordError.value = 'Mật khẩu xác nhận không khớp';
    } else {
      passwordError.value = '';
    }
  }

  // Add new method to validate password and continue
  Future<void> validateAndContinue() async {
    try {
      if (password.isEmpty) {
        showError(message: 'Vui lòng nhập mật khẩu');
        return;
      }

      if (password.value.length < 8) {
        showError(message: 'Mật khẩu phải có ít nhất 8 ký tự');
        return;
      }

      // Kiểm tra độ mạnh trực tiếp thay vì dựa vào passwordStrength
      int strength = 0;

      if (password.value.length >= 8) {
        strength++;
      }

      if (password.value.contains(RegExp(r'[A-Z]')) &&
          password.value.contains(RegExp(r'[a-z]'))) {
        strength++;
      }

      if (password.value.contains(RegExp(r'[0-9]')) ||
          password.value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        strength++;
      }

      if (strength < 2) {
        showError(
            message:
                'Mật khẩu không đủ mạnh, cần có cả chữ hoa, chữ thường và số hoặc ký tự đặc biệt');
        return;
      }

      // Move to confirm password step
      newPassword.value = password.value;
      resetState.value = ResetPasswordState.resetPassword;
    } catch (e) {
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }

  // Reset password
  Future<void> resetPassword() async {
    try {
      // Validate passwords
      if (newPassword.isEmpty || confirmPassword.isEmpty) {
        showError(message: 'Vui lòng nhập đầy đủ thông tin');
        return;
      }

      if (newPassword.value != confirmPassword.value) {
        showError(message: 'Mật khẩu xác nhận không khớp');
        return;
      }

      if (newPassword.value.length < 8) {
        showError(message: 'Mật khẩu phải có ít nhất 8 ký tự');
        return;
      }

      if (passwordStrength.value < 2) {
        showError(message: 'Mật khẩu không đủ mạnh');
        return;
      }

      // Show loading
      showLoading(message: 'Đang đặt lại mật khẩu...');

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1)); // Thêm delay giả lập

      // Gọi API thực tế
      final response = await authRepositories.resetPassword(
        email: email.value,
        newPassword: newPassword.value,
        verificationCode: otpDigits.join(),
      );

      // Hide loading
      hideLoading();

      // Show success dialog
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Thành công'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4CAF50),
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Mật khẩu của bạn đã được đặt lại thành công',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(RouterName.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7043),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Đăng nhập'),
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      hideLoading();
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }
}
