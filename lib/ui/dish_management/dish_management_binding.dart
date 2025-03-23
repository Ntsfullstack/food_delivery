import 'package:get/get.dart';
import 'dish_management_controller.dart';

class DishManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DishManagementController());
  }
}