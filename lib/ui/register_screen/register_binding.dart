import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/ui/register_screen/register_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
