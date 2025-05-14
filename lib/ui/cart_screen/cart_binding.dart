import 'package:food_delivery_app/ui/cart_screen/cart_controller.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_controller.dart';
import 'package:get/get.dart';


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