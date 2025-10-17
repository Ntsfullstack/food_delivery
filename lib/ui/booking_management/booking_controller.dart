// booking_controller.dart
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/base/networking/api_response.dart';
import 'package:food_delivery_app/models/order/booking_table.dart';

import '../../repository/booking_table_repository/booking_history_repository.dart';

class BookingController extends BaseController {

  // Observable variables
  var bookingHistory = <TableBooking>[].obs;
  var pendingBookings = <TableBooking>[].obs;
  var selectedBooking = Rxn<TableBooking>();

  var isLoadingHistory = false.obs;
  var isLoadingPending = false.obs;
  var isLoadingDetail = false.obs;
  var isProcessing = false.obs;

  var errorMessage = ''.obs;
  var historyEmpty = false.obs;
  var pendingEmpty = false.obs;

  @override
  void onInit() {
    super.onInit();
    refreshAll();
  }

  // Load booking history
  Future<void> loadBookingHistory() async {
    try {
      isLoadingHistory.value = true;
      errorMessage.value = '';
      historyEmpty.value = false;

      final response = await bookingHistoryRepositories.getBookingHistory();

      if (response.data != null) {
        bookingHistory.value = response.data!;
        historyEmpty.value = bookingHistory.isEmpty;
      } else {
        errorMessage.value = response.message ?? 'Failed to load booking history';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoadingHistory.value = false;
    }
  }

  // Load pending bookings
  Future<void> loadPendingBookings() async {
    try {
      isLoadingPending.value = true;
      errorMessage.value = '';
      pendingEmpty.value = false;

      final response = await bookingHistoryRepositories.getPendingBookings();

      if (response.data != null) {
        pendingBookings.value = response.data!;
        pendingEmpty.value = pendingBookings.isEmpty;
      } else {
        errorMessage.value = response.message ?? 'Failed to load pending bookings';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoadingPending.value = false;
    }
  }

  // Get booking detail
  Future<void> getBookingDetail(int bookingId) async {
    try {
      isLoadingDetail.value = true;
      errorMessage.value = '';

      final response = await bookingHistoryRepositories.getBookingDetail(bookingId);

      if (response.data != null) {
        selectedBooking.value = response.data;
      } else {
        errorMessage.value = response.message ?? 'Failed to load booking detail';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoadingDetail.value = false;
    }
  }

  // Cancel booking
  Future<bool> cancelBooking(int bookingId) async {
    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final response = await bookingHistoryRepositories.cancelBooking(bookingId);

      if (response.success != null) {
        // Update local state
        _updateBookingStatus(bookingId, 'cancelled');
        Get.snackbar(
          'Success',
          'Booking cancelled successfully',
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
        return true;
      } else {
        errorMessage.value = response.message ?? 'Failed to cancel booking';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  // Confirm booking
  Future<bool> confirmBooking(int bookingId, int tableId) async {
    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final response = await bookingHistoryRepositories.confirmBooking(bookingId, tableId);

      if (response.success != null) {
        // Update local state
        _updateBookingStatus(bookingId, 'confirmed');
        Get.snackbar(
          'Success',
          'Booking confirmed successfully',
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );
        return true;
      } else {
        errorMessage.value = response.message ?? 'Failed to confirm booking';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      return false;
    } finally {
      isProcessing.value = false;
    }
  }

  // Helper method to update booking status locally
  void _updateBookingStatus(int bookingId, String newStatus) {
    // Update in pending bookings
    if (newStatus == 'cancelled') {
      pendingBookings.removeWhere((booking) => booking.orderId == bookingId);
    } else {
      final pendingIndex = pendingBookings.indexWhere((booking) => booking.orderId == bookingId);
      if (pendingIndex != -1) {
        // Remove from pending if confirmed
        pendingBookings.removeAt(pendingIndex);
      }
    }

    // Update selected booking if it matches
    if (selectedBooking.value?.orderId == bookingId) {
      if (selectedBooking.value != null) {
        // Update status - you might need to implement copyWith method in TableBooking model
        // selectedBooking.value = selectedBooking.value!.copyWith(status: newStatus);
      }
    }

    // Refresh pending bookings count
    pendingEmpty.value = pendingBookings.isEmpty;
  }

  // Refresh all data
  Future<void> refreshAll() async {
    await Future.wait([
      loadBookingHistory(),
      loadPendingBookings(),
    ]);
  }

  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  // Clear selected booking
  void clearSelectedBooking() {
    selectedBooking.value = null;
  }

  // Show confirmation dialog for cancellation
  Future<void> showCancelConfirmation(int bookingId) async {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              cancelBooking(bookingId);
            },
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  // Show confirmation dialog for booking confirmation
  Future<void> showConfirmDialog(int bookingId) async {
    final RxInt selectedTableId = 0.obs;
    final List<int> availableTables = [1, 2, 3, 4, 5, 6, 7, 8];

    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select a table for this booking:'),
            const SizedBox(height: 16),
            Obx(() => DropdownButtonFormField<int>(
              value: selectedTableId.value == 0 ? null : selectedTableId.value,
              decoration: const InputDecoration(
                labelText: 'Table Number',
                border: OutlineInputBorder(),
              ),
              items: availableTables.map((tableId) {
                return DropdownMenuItem(
                  value: tableId,
                  child: Text('Table $tableId'),
                );
              }).toList(),
              onChanged: (value) {
                selectedTableId.value = value ?? 0;
              },
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          Obx(() => ElevatedButton(
            onPressed: selectedTableId.value > 0 && !isProcessing.value
                ? () {
              Get.back();
              confirmBooking(bookingId, selectedTableId.value);
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Get.theme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: isProcessing.value
                ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : const Text('Confirm'),
          )),
        ],
      ),
    );
  }
}