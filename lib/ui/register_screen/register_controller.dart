import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  final fullName = ''.obs;
  final email = ''.obs;
  final mobileNumber = ''.obs;
  final password = ''.obs;
  final dateOfBirth = ''.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signUp() async {
    try {
      // Validate inputs
      if (fullName.isEmpty ||
          email.isEmpty ||
          mobileNumber.isEmpty ||
          password.isEmpty ||
          dateOfBirth.isEmpty) {
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

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Hide loading
      hideLoading();

      // Show success and navigate to login
      Get.snackbar(
        'Đăng ký thành công',
        'Vui lòng đăng nhập để tiếp tục',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate to login screen
      Get.offNamed(RouterName.login);
    } catch (e) {
      hideLoading();
      showError(message: 'Đã xảy ra lỗi: $e');
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      showLoading(message: 'Đang đăng nhập với Google...');

      // Simulate Google Sign-In
      await Future.delayed(const Duration(seconds: 2));

      hideLoading();
      Get.offAllNamed(RouterName.bottomNavigation);
    } catch (e) {
      hideLoading();
      showError(message: 'Đăng nhập Google thất bại: $e');
    }
  }

  Future<void> signUpWithMicrosoft() async {
    try {
      showLoading(message: 'Đang đăng nhập với Microsoft...');

      // Simulate Microsoft Sign-In
      await Future.delayed(const Duration(seconds: 2));

      hideLoading();
      Get.offAllNamed(RouterName.bottomNavigation);
    } catch (e) {
      hideLoading();
      showError(message: 'Đăng nhập Microsoft thất bại: $e');
    }
  }
}
