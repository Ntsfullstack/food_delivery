import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/booking_history/booking_history_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/order/booking_table.dart';

class BookingHistoryScreen extends GetView<BookingHistoryController> {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Lịch sử đặt bàn',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20.sp),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          _buildStatusFilter(),
          Expanded(
            child: Obx(() {


              if (controller.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
                      SizedBox(height: 16.h),
                      Text(
                        controller.errorMessage.value,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: controller.refreshBookings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7043),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                        ),
                        child: Text(
                          'Thử lại',
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (controller.filteredBookings.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy,
                        size: 80.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Không có lịch sử đặt bàn',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Bạn chưa đặt bàn nào',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.refreshBookings,
                color: const Color(0xFFFF7043),
                child: ListView.builder(
                  padding: EdgeInsets.all(16.r),
                  itemCount: controller.filteredBookings.length,
                  itemBuilder: (context, index) {
                    final booking = controller.filteredBookings[index];
                    return _buildBookingCard(booking);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      height: 50.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.statusFilters.length,
          itemBuilder: (context, index) {
            final status = controller.statusFilters[index];
            final isSelected = controller.selectedStatus.value == status;

            return GestureDetector(
              onTap: () => controller.changeStatusFilter(status),
              child: Container(
                margin: EdgeInsets.only(right: 12.w, top: 8.h, bottom: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFF7043)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.statusNames[status] ?? status,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
            );
          },
        ),
    );
  }

  Widget _buildBookingCard(TableBooking booking) {
    final statusColor = controller.statusColors[booking.status?.toLowerCase()] ?? Colors.grey;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.restaurant,
                      size: 20.sp,
                      color: const Color(0xFFFF7043),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Mã đặt bàn: #${booking.reservationId}',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    controller.statusNames[booking.status?.toLowerCase()] ?? booking.status ?? 'N/A',
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Booking details
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  icon: Icons.event,
                  title: 'Ngày giờ đặt bàn',
                  value: controller.formatDateTime(booking.reservationTime),
                ),
                SizedBox(height: 12.h),
                _buildInfoRow(
                  icon: Icons.people,
                  title: 'Số người',
                  value: '${booking.partySize} người',
                ),
                SizedBox(height: 12.h),
                _buildInfoRow(
                  icon: Icons.table_restaurant,
                  title: 'Bàn số',
                  value: booking.tableId ?? 'Chưa xác định',
                ),
                if (booking.specialRequests != null && booking.specialRequests!.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  _buildInfoRow(
                    icon: Icons.note,
                    title: 'Yêu cầu đặc biệt',
                    value: booking.specialRequests!,
                  ),
                ],
              ],
            ),
          ),

          // Actions
          if (booking.status?.toLowerCase() == 'pending' || booking.status?.toLowerCase() == 'confirmed') ...[
            Divider(height: 1, color: Colors.grey[200]),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => _showCancelConfirmation(booking.reservationId!),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                    ),
                    child: Text(
                      'Hủy đặt bàn',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18.sp,
          color: Colors.grey[600],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCancelConfirmation(int bookingId) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Xác nhận hủy đặt bàn',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Bạn có chắc chắn muốn hủy đặt bàn này không?',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Không',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.cancelBooking(bookingId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Hủy đặt bàn',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}