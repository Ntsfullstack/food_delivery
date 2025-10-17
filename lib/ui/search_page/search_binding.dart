import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/ui/search_page/search_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
Get.lazyPut(() => SearchScreenController());
  }

}