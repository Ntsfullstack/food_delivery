import 'package:food_delivery_app/ui/booking_screen/booking_controller.dart';
import 'package:food_delivery_app/ui/cart_screen/cart_controller.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_controller.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_controller.dart';
import 'package:get/get.dart';
import '../home_screen/home_controller.dart';
import 'bottom_navigation_controller.dart';

class BottomNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<ProfileController>(()=> ProfileController());
    Get.lazyPut<CartController>(()=> CartController());
    Get.lazyPut<TableBookingController>(()=> TableBookingController());
    // Get.lazyPut<LocationController>(() => LocationController());
  }
}