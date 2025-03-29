import 'package:get/get.dart';
import 'order_management_controller.dart';

class OrderManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderManagementController());
  }
}