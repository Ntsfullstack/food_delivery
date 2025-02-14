// lib/bindings/auth_binding.dart
import 'package:get/get.dart';

import 'login_controller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
