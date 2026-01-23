import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/ui/booking_management/booking_controller.dart';
import 'package:food_delivery_app/ui/booking_management/status_chip_widget.dart';

class BookingManagementScreen extends GetView<BookingController> {
  const BookingManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý đặt bàn'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Chờ xử lý'),
              Tab(text: 'Đã xác nhận'),
              Tab(text: 'Đã hủy'),
              Tab(text: 'Hoàn tất'),
              Tab(text: 'Tất cả'),
              Tab(text: 'Trạng thái bàn'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.refreshAll(),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => controller.showCreateTableDialog(),
              tooltip: 'Tạo bàn',
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            _PendingBookingsTab(),
            _ConfirmedBookingsTab(),
            _CanceledBookingsTab(),
            _CompletedBookingsTab(),
            _AllBookingsTab(),
            _TablesStatusTab(),
          ],
        ),
      ),
    );
  }
}

class _PendingBookingsTab extends GetView<BookingController> {
  const _PendingBookingsTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingPending.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (controller.pendingBookings.isEmpty) {
        return const Center(child: Text('Không có yêu cầu chờ xử lý'));
      }
      return RefreshIndicator(
        onRefresh: () => controller.loadPendingBookings(),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.pendingBookings.length,
          itemBuilder: (context, index) {
            final booking = controller.pendingBookings[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking.customerName ??
                              booking.userName ??
                              'Khách lẻ',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        StatusChip(status: booking.status ?? 'pending'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Mã đặt: #${booking.reservationId}'),
                    Text('Thời gian: ${booking.reservationTime?.toLocal()}'),
                    Text('Số khách: ${booking.partySize ?? 0}'),
                    if (booking.tableNumber != null)
                      Text('Bàn: ${booking.tableNumber}'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => controller
                              .showBookingDetail(booking.reservationId ?? 0),
                          child: const Text('Chi tiết'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () => controller.showCancelConfirmation(
                              booking.reservationId ?? 0),
                          child: const Text('Hủy'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => controller
                              .showConfirmDialog(booking.reservationId ?? 0),
                          child: const Text('Xác nhận'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class _ConfirmedBookingsTab extends GetView<BookingController> {
  const _ConfirmedBookingsTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingConfirmed.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (controller.confirmedBookings.isEmpty) {
        return const Center(child: Text('Không có yêu cầu đã xác nhận'));
      }
      return RefreshIndicator(
        onRefresh: () => controller.loadConfirmedBookings(),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.confirmedBookings.length,
          itemBuilder: (context, index) {
            final booking = controller.confirmedBookings[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking.customerName ?? booking.userName ?? 'Khách',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        StatusChip(status: booking.status ?? 'confirmed'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Mã đặt: #${booking.reservationId}'),
                    Text('Thời gian: ${booking.reservationTime?.toLocal()}'),
                    Text('Số khách: ${booking.partySize ?? 0}'),
                    if (booking.tableNumber != null)
                      Text('Bàn: ${booking.tableNumber}'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => controller
                              .showBookingDetail(booking.reservationId ?? 0),
                          child: const Text('Chi tiết'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () => controller.showCancelConfirmation(
                              booking.reservationId ?? 0),
                          child: const Text('Hủy'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class _CanceledBookingsTab extends GetView<BookingController> {
  const _CanceledBookingsTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingCanceled.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (controller.canceledBookings.isEmpty) {
        return const Center(child: Text('Không có yêu cầu đã hủy'));
      }
      return RefreshIndicator(
        onRefresh: () => controller.loadCanceledBookings(),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.canceledBookings.length,
          itemBuilder: (context, index) {
            final booking = controller.canceledBookings[index];
            return ListTile(
              title: Text(booking.customerName ?? booking.userName ?? 'Khách'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mã đặt: #${booking.reservationId}'),
                  Text('Thời gian: ${booking.reservationTime?.toLocal()}'),
                ],
              ),
              trailing: StatusChip(status: booking.status ?? 'canceled'),
            );
          },
        ),
      );
    });
  }
}

class _CompletedBookingsTab extends GetView<BookingController> {
  const _CompletedBookingsTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingCompleted.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (controller.completedBookings.isEmpty) {
        return const Center(child: Text('Không có yêu cầu đã hoàn tất'));
      }
      return RefreshIndicator(
        onRefresh: () => controller.loadCompletedBookings(),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.completedBookings.length,
          itemBuilder: (context, index) {
            final booking = controller.completedBookings[index];
            return ListTile(
              title: Text(booking.customerName ?? booking.userName ?? 'Khách'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mã đặt: #${booking.reservationId}'),
                  Text('Thời gian: ${booking.reservationTime?.toLocal()}'),
                ],
              ),
              trailing: StatusChip(status: booking.status ?? 'completed'),
            );
          },
        ),
      );
    });
  }
}

class _AllBookingsTab extends GetView<BookingController> {
  const _AllBookingsTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingHistory.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (controller.bookingHistory.isEmpty) {
        return const Center(child: Text('Chưa có lịch sử đặt bàn'));
      }
      return RefreshIndicator(
        onRefresh: () => controller.loadBookingHistory(),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.bookingHistory.length,
          itemBuilder: (context, index) {
            final booking = controller.bookingHistory[index];
            return ListTile(
              title: Text(booking.customerName ?? booking.userName ?? 'Khách'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mã đặt: #${booking.reservationId}'),
                  Text('Trạng thái: ${booking.status}'),
                ],
              ),
              trailing: StatusChip(status: booking.status ?? 'unknown'),
            );
          },
        ),
      );
    });
  }
}

class _TablesStatusTab extends GetView<BookingController> {
  const _TablesStatusTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingTables.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.tablesStatus.isEmpty) {
        return const Center(child: Text('Không có dữ liệu bàn'));
      }
      return RefreshIndicator(
        onRefresh: () => controller.loadTablesStatus(),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.tablesStatus.length,
          itemBuilder: (context, index) {
            final t = controller.tablesStatus[index];
            final occupied = t.isOccupied ||
                t.status == 'occupied' ||
                t.status == 'reserved';
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text('Bàn ${t.tableNumber} · ${t.capacity} chỗ'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Trạng thái: ${t.status}${occupied ? ' (đang có khách)' : ''}'),
                    if (t.customerName != null)
                      Text('Khách: ${t.customerName}'),
                    if (t.currentOrderId != null)
                      Text('Mã đơn: #${t.currentOrderId}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: controller.isProcessing.value
                          ? null
                          : () =>
                              controller.setTableStatus(t.tableId, 'available'),
                      child: const Text('Đặt trống'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: controller.isProcessing.value
                          ? null
                          : () =>
                              controller.setTableStatus(t.tableId, 'occupied'),
                      child: const Text('Đánh dấu bận'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: controller.isProcessing.value
                          ? null
                          : () =>
                              controller.setTableStatus(t.tableId, 'completed'),
                      child: const Text('Hoàn tất'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
