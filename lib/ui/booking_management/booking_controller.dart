// booking_controller.dart
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/base/networking/api_response.dart';
import 'package:food_delivery_app/models/order/booking_table.dart';
import 'package:food_delivery_app/models/table/admin_table.dart';
import 'package:food_delivery_app/models/table/admin_table_status.dart';

import '../../repository/booking_table_repository/booking_history_repository.dart';

class BookingController extends BaseController {
  // Observable variables
  var bookingHistory = <TableBooking>[].obs;
  var pendingBookings = <TableBooking>[].obs;
  var confirmedBookings = <TableBooking>[].obs;
  var canceledBookings = <TableBooking>[].obs;
  var completedBookings = <TableBooking>[].obs;
  var selectedBooking = Rxn<TableBooking>();

  var isLoadingHistory = false.obs;
  var isLoadingPending = false.obs;
  var isLoadingConfirmed = false.obs;
  var isLoadingCanceled = false.obs;
  var isLoadingCompleted = false.obs;
  var isLoadingDetail = false.obs;
  var isProcessing = false.obs;
  var isLoadingTables = false.obs;

  var errorMessage = ''.obs;
  var historyEmpty = false.obs;
  var pendingEmpty = false.obs;
  var confirmedEmpty = false.obs;
  var canceledEmpty = false.obs;
  var completedEmpty = false.obs;
  var availableAdminTables = <AdminTable>[].obs;
  var tablesStatus = <AdminTableStatus>[].obs;

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
        errorMessage.value =
            response.message ?? 'Failed to load booking history';
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
        errorMessage.value =
            response.message ?? 'Failed to load pending bookings';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoadingPending.value = false;
    }
  }

  Future<void> loadConfirmedBookings() async {
    try {
      isLoadingConfirmed.value = true;
      errorMessage.value = '';
      confirmedEmpty.value = false;

      final response =
          await bookingHistoryRepositories.getBookingsByStatus('confirmed');
      if (response.data != null) {
        confirmedBookings.value = response.data!;
        confirmedEmpty.value = confirmedBookings.isEmpty;
      } else {
        errorMessage.value =
            response.message ?? 'Failed to load confirmed bookings';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoadingConfirmed.value = false;
    }
  }

  Future<void> loadCanceledBookings() async {
    try {
      isLoadingCanceled.value = true;
      errorMessage.value = '';
      canceledEmpty.value = false;

      final response =
          await bookingHistoryRepositories.getBookingsByStatus('canceled');
      if (response.data != null) {
        canceledBookings.value = response.data!;
        canceledEmpty.value = canceledBookings.isEmpty;
      } else {
        errorMessage.value =
            response.message ?? 'Failed to load canceled bookings';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoadingCanceled.value = false;
    }
  }

  Future<void> loadCompletedBookings() async {
    try {
      isLoadingCompleted.value = true;
      errorMessage.value = '';
      completedEmpty.value = false;

      final response =
          await bookingHistoryRepositories.getBookingsByStatus('completed');
      if (response.data != null) {
        completedBookings.value = response.data!;
        completedEmpty.value = completedBookings.isEmpty;
      } else {
        errorMessage.value =
            response.message ?? 'Failed to load completed bookings';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoadingCompleted.value = false;
    }
  }

  // Get booking detail
  Future<void> getBookingDetail(int bookingId) async {
    try {
      isLoadingDetail.value = true;
      errorMessage.value = '';

      final response =
          await bookingHistoryRepositories.getBookingDetail(bookingId);

      if (response.data != null) {
        selectedBooking.value = response.data;
      } else {
        errorMessage.value =
            response.message ?? 'Failed to load booking detail';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoadingDetail.value = false;
    }
  }

  Future<void> showBookingDetail(int bookingId) async {
    await getBookingDetail(bookingId);
    final b = selectedBooking.value;
    if (b == null) {
      showError(message: 'Không tìm thấy chi tiết đặt bàn');
      return;
    }
    Get.dialog(AlertDialog(
      title: const Text('Chi tiết đặt bàn'),
      content: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Mã đặt: #${b.reservationId ?? ''}'),
          if (b.tableNumber != null) Text('Bàn: ${b.tableNumber}'),
          if (b.partySize != null) Text('Số khách: ${b.partySize}'),
          if (b.reservationTime != null)
            Text('Thời gian: ${b.reservationTime}'),
          Text('Trạng thái: ${b.status ?? ''}'),
          const SizedBox(height: 12),
          const Text('Món đã đặt:'),
          const SizedBox(height: 4),
          if ((b.orderedItems ?? []).isEmpty) const Text('Chưa có món'),
          ...((b.orderedItems ?? []).map((it) => Text(
              '- ${it['itemName'] ?? it['name'] ?? ''} x${it['quantity'] ?? it['qty'] ?? ''}'))),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Đóng')),
      ],
    ));
  }

  // Cancel booking
  Future<bool> cancelBooking(int bookingId) async {
    try {
      isProcessing.value = true;
      errorMessage.value = '';

      final response =
          await bookingHistoryRepositories.cancelBooking(bookingId);

      if (response.success != null) {
        // Update local state
        _updateBookingStatus(bookingId, 'cancelled');
        await Future.wait([
          loadCanceledBookings(),
          loadPendingBookings(),
        ]);
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

      final response =
          await bookingHistoryRepositories.confirmBooking(bookingId, tableId);

      if (response.success != null) {
        // Update local state
        _updateBookingStatus(bookingId, 'confirmed');
        await Future.wait([
          loadConfirmedBookings(),
          loadPendingBookings(),
        ]);
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
    if (newStatus == 'cancelled' || newStatus == 'canceled') {
      pendingBookings
          .removeWhere((booking) => booking.reservationId == bookingId);
    } else {
      final pendingIndex = pendingBookings
          .indexWhere((booking) => booking.reservationId == bookingId);
      if (pendingIndex != -1) {
        // Remove from pending if confirmed
        pendingBookings.removeAt(pendingIndex);
      }
    }

    if (newStatus == 'canceled') {
      confirmedBookings.removeWhere((b) => b.reservationId == bookingId);
    }

    // Update selected booking if it matches
    if (selectedBooking.value?.reservationId == bookingId) {
      if (selectedBooking.value != null) {
        // Update status - you might need to implement copyWith method in TableBooking model
        selectedBooking.value =
            selectedBooking.value!.copyWith(status: newStatus);
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
      loadConfirmedBookings(),
      loadCanceledBookings(),
      loadCompletedBookings(),
      loadTablesStatus(),
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
    try {
      isLoadingTables.value = true;
      final res = await tablesRepositories.getAvailableTables();
      availableAdminTables.value = res.data ?? [];
    } catch (e) {
      showError(message: 'Không thể tải danh sách bàn khả dụng');
    } finally {
      isLoadingTables.value = false;
    }

    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select a table for this booking:'),
            const SizedBox(height: 16),
            Obx(() {
              if (isLoadingTables.value) {
                return const SizedBox(
                  height: 48,
                  child:
                      Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              }
              if (availableAdminTables.isEmpty) {
                return const Text('Không có bàn khả dụng');
              }
              return DropdownButtonFormField<int>(
                isExpanded: true,
                value:
                    selectedTableId.value == 0 ? null : selectedTableId.value,
                decoration: const InputDecoration(
                  labelText: 'Chọn bàn',
                  border: OutlineInputBorder(),
                ),
                items: availableAdminTables.map<DropdownMenuItem<int>>((t) {
                  return DropdownMenuItem(
                    value: t.tableId,
                    child: Text(
                        'Bàn ${t.tableNumber} (ID ${t.tableId}, ${t.capacity} chỗ)'),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedTableId.value = value ?? 0;
                },
              );
            }),
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

  Future<void> showCreateTableDialog() async {
    final numberCtrl = TextEditingController();
    final capacityCtrl = TextEditingController();
    final RxString status = 'available'.obs;

    Get.dialog(
      AlertDialog(
        title: const Text('Tạo bàn mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: numberCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Số bàn',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: capacityCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sức chứa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Obx(() => DropdownButtonFormField<String>(
                  value: status.value,
                  items: const [
                    DropdownMenuItem(
                        value: 'available', child: Text('available')),
                    DropdownMenuItem(
                        value: 'occupied', child: Text('occupied')),
                  ],
                  onChanged: (v) => status.value = v ?? 'available',
                  decoration: const InputDecoration(
                    labelText: 'Trạng thái',
                    border: OutlineInputBorder(),
                  ),
                )),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Đóng')),
          Obx(() => ElevatedButton(
                onPressed: isProcessing.value
                    ? null
                    : () async {
                        final tableNumber =
                            int.tryParse(numberCtrl.text.trim());
                        final capacity = int.tryParse(capacityCtrl.text.trim());
                        if (tableNumber == null || capacity == null) {
                          showError(
                              message:
                                  'Vui lòng nhập số bàn và sức chứa hợp lệ');
                          return;
                        }
                        try {
                          isProcessing.value = true;
                          await tablesRepositories.createTable(
                            tableNumber: tableNumber,
                            capacity: capacity,
                            status: status.value,
                          );
                          showSuccess(message: 'Tạo bàn thành công');
                          await refreshAll();
                          Get.back();
                        } catch (e) {
                          showError(message: 'Lỗi khi tạo bàn');
                        } finally {
                          isProcessing.value = false;
                        }
                      },
                child: isProcessing.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Tạo bàn'),
              )),
        ],
      ),
    );
  }

  Future<void> loadTablesStatus() async {
    try {
      isLoadingTables.value = true;
      final res = await tablesRepositories.getTablesWithStatus();
      tablesStatus.value = res.data ?? [];
    } catch (e) {
      showError(message: 'Không thể tải trạng thái bàn');
    } finally {
      isLoadingTables.value = false;
    }
  }

  Future<void> setTableStatus(int tableId, String status) async {
    try {
      isProcessing.value = true;
      await tablesRepositories.updateTableStatus(
          tableId: tableId, status: status);
      await loadTablesStatus();
      showSuccess(message: 'Cập nhật trạng thái bàn thành công');
    } catch (e) {
      showError(message: 'Cập nhật trạng thái bàn thất bại');
    } finally {
      isProcessing.value = false;
    }
  }
}
