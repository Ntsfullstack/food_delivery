// home_binding.dart
import 'package:get/get.dart';
import 'package:food_delivery_app/ui/home_screen/home_controller.dart';
import 'package:food_delivery_app/ui/cart_screen/cart_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Khởi tạo HomeController trước
    Get.put(HomeController(), permanent: true);
    
    // Sau đó khởi tạo CartController
    Get.put(CartController(), permanent: true);
  }
}
