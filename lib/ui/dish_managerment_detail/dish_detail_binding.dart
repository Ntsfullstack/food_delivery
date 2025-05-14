import 'package:get/get.dart';
import 'dish_detail_controller.dart';

class DishDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DishDetailController());
  }
}
