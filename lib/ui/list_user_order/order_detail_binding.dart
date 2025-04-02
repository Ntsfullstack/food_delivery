import 'package:get/get.dart';
import 'package:food_delivery_app/ui/list_user_order/order_detail_controller.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailController>(() => OrderDetailController());
  }
}