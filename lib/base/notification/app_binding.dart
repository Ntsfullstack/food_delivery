import 'package:get/get.dart';
import '../../ui/login_screen/login_controller.dart';
import '../base_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Register BaseController
    Get.lazyPut<BaseController>(() => BaseController());
    
    // Register AuthController
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
