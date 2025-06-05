import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';


import '../../../models/order/booking_table.dart';

class PendingTablesController extends BaseController {
  final RxList<TableBooking> pendingBookings = <TableBooking>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingBookings();
  }

  Future<void> fetchPendingBookings() async {
    try {
      _isLoading.value = true;
      errorMessage.value = '';

      final response = await bookingHistoryRepositories.getPendingBookings();
      
      if (response.success == 200 && response.data != null) {
        pendingBookings.assignAll(response.data!);
      } else {
        errorMessage.value = response.message ?? 'Không thể tải danh sách đặt bàn';
      }
    } catch (e) {
      errorMessage.value = 'Lỗi: ${e.toString()}';
      print('Error fetching pending bookings: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> approveBooking(int bookingId, int tableId) async {
    try {
      showLoading(message: 'Đang xử lý...');

      final response = await bookingHistoryRepositories.confirmBooking(bookingId, tableId);

      if (response.success == 200) {
        // Remove the approved booking from the list
        pendingBookings.removeWhere((booking) => booking.orderId == bookingId);
        showSuccess(message: 'Đã chấp nhận đặt bàn');
      } else {
        showError(message: response.message ?? 'Không thể chấp nhận đặt bàn');
      }
    } catch (e) {
      showError(message: 'Lỗi: ${e.toString()}');
    } finally {
      hideLoading();
    }
  }

  // Future<void> rejectBooking(String bookingId, String reason) async {
  //   try {
  //     showLoading(message: 'Đang xử lý...');
  //
  //     final response = await bookingRepository.rejectBooking(bookingId, reason);
  //
  //     if (response.success == 200) {
  //       // Remove the rejected booking from the list
  //       pendingBookings.removeWhere((booking) => booking.id == bookingId);
  //       showSuccess(message: 'Đã từ chối đặt bàn');
  //     } else {
  //       showError(message: response.message ?? 'Không thể từ chối đặt bàn');
  //     }
  //   } catch (e) {
  //     showError(message: 'Lỗi: ${e.toString()}');
  //   } finally {
  //     hideLoading();
  //   }
  // }

  void refreshBookings() {
    fetchPendingBookings();
  }
} 