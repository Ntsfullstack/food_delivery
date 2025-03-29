// binding.dart
import 'package:food_delivery_app/ui/setting_screen/setting_controller.dart';
import 'package:get/get.dart';


class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}