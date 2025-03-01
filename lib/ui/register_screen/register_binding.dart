import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/ui/register_screen/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
