import 'package:get/get.dart';
import '../home_screen/home_controller.dart';
import 'bottom_navigation_controller.dart';

class BottomNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<LocationController>(() => LocationController());
  }
}