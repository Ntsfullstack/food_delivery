
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminDashboardController(), permanent: true);
  }
}