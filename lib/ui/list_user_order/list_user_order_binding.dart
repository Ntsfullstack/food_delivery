import 'package:get/get.dart';
import 'package:food_delivery_app/ui/list_user_order/list_user_order_controller.dart';

class ListUserOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListUserOrderController>(() => ListUserOrderController());
  }
}