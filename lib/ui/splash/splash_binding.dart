import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/ui/splash/splash_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
