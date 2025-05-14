import 'package:food_delivery_app/base/base_controller.dart';

import 'list_menu_controller.dart';

class ListMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut <ListMenuController>(
      () => ListMenuController(),
    );
  }
}