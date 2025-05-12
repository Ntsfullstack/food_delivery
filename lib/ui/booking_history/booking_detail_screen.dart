// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:food_delivery_app/models/order/booking_table.dart';
// import 'package:food_delivery_app/ui/booking_history/booking_history_controller.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class BookingDetailScreen extends GetView<BookingHistoryController> {
//   final TableBooking booking;
//
//   const BookingDetailScreen({
//     Key? key,
//     required this.booking,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'Chi tiết đặt bàn',
//           style: GoogleFonts.poppins(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//             color: const Color(0xFF303030),
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20.sp),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildStatusCard(),
//             SizedBox(height: 16.h),
//             _buildBookingDetailsCard(),
//             SizedBox(height: 16.h),
//             if (booking. != null && booking.dishes!.isNotEmpty)
//               _buildDishesCard(),
//             SizedBox(height: 16.h),
//             if (booking.status?.toLowerCase() == 'pending' ||
//                 booking.status?.toLowerCase() == 'confirmed')
//               _buildCancelButton(),
//             SizedBox(height: 24.h),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStatusCard() {
//     final statusColor = controller.statusColors[booking.status?.toLowerCase()] ?? Colors.grey;
//
//     return Container(
//       margin: EdgeInsets.all(16.r),
//       padding: EdgeInsets.all(16.r),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Trạng thái đặt bàn',
//                 style: GoogleFonts.poppins(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey[800],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 12.w,
//                   vertical: 6.h,
//                 ),
//                 decoration: BoxDecoration(
//                   color: statusColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Text(
//                   controller.statusNames[booking.status?.toLowerCase()] ?? booking.status ?? 'N/A',
//                   style: GoogleFonts.poppins(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: statusColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             children: [
//               Icon(
//                 Icons.confirmation_number_outlined,
//                 size: 20.sp,
//                 color: const Color(0xFFFF7043),
//               ),
//               SizedBox(width: 8.w),
//               Text(
//                 'Mã đặt bàn: #${booking.reservationId}',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBookingDetailsCard() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.r),
//       padding: EdgeInsets.all(16.r),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Thông tin đặt bàn',
//             style: GoogleFonts.poppins(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[800],
//             ),
//           ),
//           SizedBox(height: 16.h),
//           _buildInfoRow(
//             icon: Icons.person_outline,
//             title: 'Tên khách hàng',
//             value: booking.customerName ?? 'N/A',
//           ),
//           SizedBox(height: 12.h),
//           _buildInfoRow(
//             icon: Icons.phone_outlined,
//             title: 'Số điện thoại',
//             value: booking.phoneNumber ?? 'N/A',
//           ),
//           SizedBox(height: 12.h),
//           _buildInfoRow(
//             icon: Icons.event,
//             title: 'Ngày giờ đặt bàn',
//             value: controller.formatDateTime(booking.reservationTime),
//           ),
//           SizedBox(height: 12.h),
//           _buildInfoRow(
//             icon: Icons.people,
//             title: 'Số người',
//             value: '${booking.partySize} người',
//           ),
//           SizedBox(height: 12.h),
//           _buildInfoRow(
//             icon: Icons.table_restaurant,
//             title: 'Bàn số',
//             value: booking.tableId ?? 'Chưa xác định',
//           ),
//           if (booking.specialRequests != null && booking.specialRequests!.isNotEmpty) ...[
//             SizedBox(height: 12.h),
//             _buildInfoRow(
//               icon: Icons.note,
//               title: 'Yêu cầu đặc biệt',
//               value: booking.specialRequests!,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDishesCard() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.r),
//       padding: EdgeInsets.all(16.r),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Món ăn đã đặt trước',
//             style: GoogleFonts.poppins(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[800],
//             ),
//           ),
//           SizedBox(height: 16.h),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: booking.dishes?.length ?? 0,
//             itemBuilder: (context, index) {
//               final dish = booking.dishes![index];
//               return Container(
//                 margin: EdgeInsets.only(bottom: 12.h),
//                 padding: EdgeInsets.all(12.r),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 child: Row(