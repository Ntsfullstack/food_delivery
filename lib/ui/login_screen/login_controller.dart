// lib/controllers/auth_controller.dart
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';

import '../../routes/router_name.dart';

class AuthController extends BaseController {
  var email = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    Get.offNamed(RouterName.bottomNavigation);
    print('Login with: ${email.value} and ${password.value}');
  }

  void loginWithGoogle() {
    // Implement Google login
    print('Login with Google');
  }

  void loginWithFacebook() {
    // Implement Facebook login
    print('Login with Facebook');
  }

  void loginWithFingerprint() {
    // Implement Fingerprint login
    print('Login with Fingerprint');
  }
}
