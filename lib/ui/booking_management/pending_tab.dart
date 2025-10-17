// // pending_bookings_tab.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// import 'booking_controller.dart';
// import 'booking_management_screen.dart';
//
// class PendingBookingsTab extends StatelessWidget {
//   const PendingBookingsTab({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final BookingController controller = Get.find<BookingController>();
//
//     return Obx(() {
//       if (controller.isLoadingPending.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//
//       if (controller.errorMessage.isNotEmpty) {
//         return Center(child: Text(controller.errorMessage.value));
//       }
//
//       if (controller.pendingBookings.isEmpty) {
//         return const Center(child: Text('No pending bookings'));
//       }
//
//       return RefreshIndicator(
//         onRefresh: () => controller.loadPendingBookings(),
//         child: ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: controller.pendingBookings.length,
//           itemBuilder: (context, index) {
//             final booking = controller.pendingBookings[index];
//             return PendingBookingCard(booking: booking);
//           },
//         ),
//       );
//     });
//   }
// }