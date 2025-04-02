import 'package:food_delivery_app/ui/booking_screen/booking_controller.dart';
import 'package:food_delivery_app/ui/cart_screen/cart_controller.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_controller.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_controller.dart';
import 'package:food_delivery_app/models/profile/profile.dart';
import 'package:get/get.dart';
import '../home_screen/home_controller.dart';
import '../list_user_order/list_user_order_controller.dart';


class CartBinding extends Bindings {
  @override
  void dependencies() {
    // Make sure ProfileController is available
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController());
    }

    // Then create CartController
    Get.put(CartController());
  }
}