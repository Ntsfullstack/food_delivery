import 'package:food_delivery_app/ui/list_customer/customer_controller.dart';

import 'package:get/get.dart';


class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());
  }
}