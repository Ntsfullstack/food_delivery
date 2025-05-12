import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../models/order/booking_table.dart';
import '../../routes/router_name.dart';

class BookingStatusScreen extends StatelessWidget {
  final TableBooking? bookingData;

  const BookingStatusScreen({Key? key, this.bookingData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // Animation thành công
            Center(
              child: Lottie.asset(
                'assets/animations/booking_success.json',
                width: 200.w,
                height: 200.h,
                repeat: false,
              ),
            ),
            SizedBox(height: 24.h),
            // Tiêu đề
            Text(
              'Đặt bàn thành công!',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF303030),
              ),
            ),
            SizedBox(height: 16.h),
            // Thông báo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Cảm ơn bạn đã đặt bàn tại nhà hàng của chúng tôi. Chúng tôi sẽ liên hệ với bạn để xác nhận đơn đặt bàn.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            // Thông tin đặt bàn
            if (bookingData != null) _buildBookingInfo(),
            const Spacer(),
            // Nút quay về trang chủ
            Padding(
              padding: EdgeInsets.all(24.r),
              child: _buildHomeButton(),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            icon: Icons.person_outline,
            title: 'Mã đặt bàn',
            value: bookingData?.reservationId.toString() ?? 'N/A',
          ),
          Divider(height: 24.h, color: Colors.grey[200]),
          _buildInfoRow(
            icon: Icons.phone_outlined,
            title: 'Mã bàn',
            value: bookingData?.tableId ?? 'N/A',
          ),
          Divider(height: 24.h, color: Colors.grey[200]),
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            title: 'Ngày giờ',
            value: _formatDateTime(bookingData?.reservationTime),
          ),
          Divider(height: 24.h, color: Colors.grey[200]),
          _buildInfoRow(
            icon: Icons.people_outline,
            title: 'Số người',
            value: '${bookingData?.partySize ?? 0} người',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: const Color(0xFFFF7043),
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
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF303030),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7043), Color(0xFFFF5722)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7043).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () => Get.offAllNamed(RouterName.bottomNavigation),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          'Quay về trang chủ',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    
    // Format: Thứ 2, 01/01/2023 - 19:30
    final dayNames = ['Chủ nhật', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
    final dayName = dayNames[dateTime.weekday % 7];
    
    return '$dayName, ${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}