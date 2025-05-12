import 'package:get/get.dart';
import 'package:food_delivery_app/ui/booking_history/booking_history_controller.dart';

class BookingHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingHistoryController());
  }
}