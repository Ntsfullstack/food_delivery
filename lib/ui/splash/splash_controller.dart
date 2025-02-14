import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(RouterName.login); // Navigate to home after 3 seconds
    });
  }
}
