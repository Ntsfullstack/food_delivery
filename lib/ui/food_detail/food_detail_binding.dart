import 'package:get/get.dart';
import 'food_detail_controller.dart';

class FoodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodDetailController>(() => FoodDetailController());
  }
}
