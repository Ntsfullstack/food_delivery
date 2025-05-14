import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/order/booking_table.dart';

class BookingHistoryController extends BaseController {


  final RxList<TableBooking> bookings = <TableBooking>[].obs;

  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  // Lọc theo trạng thái
  final RxString selectedStatus = 'all'.obs;
  final List<String> statusFilters = ['all', 'pending', 'confirmed', 'completed', 'cancelled'];

  // Map để hiển thị tên trạng thái tiếng Việt
  final Map<String, String> statusNames = {
    'all': 'Tất cả',
    'pending': 'Chờ xác nhận',
    'confirmed': 'Đã xác nhận',
    'completed': 'Hoàn thành',
    'cancelled': 'Đã hủy',
  };

  // Map để hiển thị màu sắc cho từng trạng thái
  final Map<String, Color> statusColors = {
    'pending': Colors.orange,
    'confirmed': Colors.blue,
    'completed': Colors.green,
    'cancelled': Colors.red,
  };

  @override
  void onInit() {
    super.onInit();
    fetchBookingHistory();
  }

  Future<void> fetchBookingHistory() async {
    try {
      hasError.value = false;

      final response = await bookingHistoryRepositories.getBookingHistory();

      if (response.success == 200) {
        bookings.value = response.data ?? [];
      } else {
        hasError.value = true;
        errorMessage.value = response.message ?? 'Không thể tải lịch sử đặt bàn';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Đã xảy ra lỗi: ${e.toString()}';
    }
  }

  List<TableBooking> get filteredBookings {
    if (selectedStatus.value == 'all') {
      return bookings;
    }
    return bookings.where((booking) =>
      booking.status?.toLowerCase() == selectedStatus.value.toLowerCase()
    ).toList();
  }

  void changeStatusFilter(String status) {
    selectedStatus.value = status;
  }

  Future<void> refreshBookings() async {
    await fetchBookingHistory();
  }

  Future<void> cancelBooking(int bookingId) async {
    try {
      showLoading(message: 'Đang hủy đặt bàn...');

      final response = await bookingHistoryRepositories.cancelBooking(bookingId);

      if (response.success == 200) {
        final index = bookings.indexWhere((booking) => booking.reservationId == bookingId);
        if (index != -1) {
          final updatedBooking = bookings[index].copyWith(status: 'cancelled');
          bookings[index] = updatedBooking;
        }

        Get.snackbar(
          'Thành công',
          'Đã hủy đặt bàn thành công',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Lỗi',
          response.message ?? 'Không thể hủy đặt bàn',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã xảy ra lỗi: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      hideLoading();
    }
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';

    final dayNames = ['Chủ nhật', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
    final dayName = dayNames[dateTime.weekday % 7];

    return '$dayName, ${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}