import 'package:get/get.dart';

import 'package:food_delivery_app/base/networking/api.dart';

import '../../repository/booking_table_repository/booking_history_repository.dart';
import 'booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    // Register ApiService if not already registered
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    // Register Repository
    Get.lazyPut<BookingHistoryRepository>(
          () => BookingHistoryRepository(apiService: Get.find<ApiService>()),
      fenix: true,
    );

    // Register Controller
    Get.lazyPut<BookingController>(
          () => BookingController(
          ),
      fenix: true,
    );
  }
}
