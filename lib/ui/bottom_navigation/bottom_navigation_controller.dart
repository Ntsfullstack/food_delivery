import 'package:get/get.dart';
import 'package:food_delivery_app/ui/cart_screen/cart_controller.dart';

class BottomNavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    // Nếu chuyển đến tab giỏ hàng (index 1), cập nhật dữ liệu giỏ hàng
    if (index == 1) {
      try {
        final cartController = Get.find<CartController>();
        cartController.fetchCartItems();
      } catch (e) {
        print('Lỗi khi cập nhật giỏ hàng: $e');
      }
    }
    
    currentIndex.value = index;
  }
}