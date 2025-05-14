import 'package:food_delivery_app/ui/setting_screen/setting_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/ui/cart_screen/cart_controller.dart';

import '../home_screen/home_controller.dart';
import '../profile_screen/profile_controller.dart';

class BottomNavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    if (index == 0) {
      try {
        final homeController = Get.find<HomeController>();
        homeController.categoryDishes();
        homeController.menuDishes();
      } catch (e) {
        print('Lỗi khi cập nhật trang chủ: $e');
      }
    } else if (index == 3) {
      try {
        final settingController = Get.find<SettingsController>();
        final profileController = Get.find<ProfileController>();
        settingController.profile();
        profileController.loadProfile();
      } catch (e) {
        print('Lỗi khi cập nhật đơn hàng: $e');
      }
    } else
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