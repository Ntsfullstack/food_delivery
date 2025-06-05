import 'package:get/get.dart';
import 'pending_tables_controller.dart';

class PendingTablesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PendingTablesController());
  }
} 