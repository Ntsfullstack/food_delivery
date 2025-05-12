import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'list_menu_controller.dart';

class ListMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut <ListMenuController>(
      () => ListMenuController(),
    );
  }
}