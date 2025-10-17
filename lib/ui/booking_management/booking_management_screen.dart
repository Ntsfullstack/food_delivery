// // booking_history_tab.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:food_delivery_app/controllers/booking_controller.dart';
// import 'package:food_delivery_app/widgets/booking/booking_history_card.dart';
//
// class BookingHistoryTab extends StatelessWidget {
//   const BookingHistoryTab({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final BookingController controller = Get.find<BookingController>();
//
//     return Obx(() {
//       if (controller.isLoadingHistory.value) {
//         return const Center(child: CircularProgressIndicator());
//       }
//
//       if (controller.errorMessage.isNotEmpty) {
//         return Center(child: Text(controller.errorMessage.value));
//       }
//
//       if (controller.bookingHistory.isEmpty) {
//         return const Center(child: Text('No booking history'));
//       }
//
//       return RefreshIndicator(
//         onRefresh: () => controller.loadBookingHistory(),
//         child: ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: controller.bookingHistory.length,
//           itemBuilder: (context, index) {
//             final booking = controller.bookingHistory[index];
//             return BookingHistoryCard(booking: booking);
//           },
//         ),
//       );
//     });
//   }
// }