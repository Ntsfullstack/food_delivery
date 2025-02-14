
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_controller.dart';
class AppBinding extends Bindings {
  @override
  void dependencies() async {
    // Cần thêm .then hoặc await khi khởi tạo SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.put(sharedPreferences);
    Get.lazyPut<BaseController>(() => BaseController());

  }
}
