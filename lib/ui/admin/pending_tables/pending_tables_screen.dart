import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'pending_tables_controller.dart';

class PendingTablesScreen extends GetView<PendingTablesController> {
  const PendingTablesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Danh sách đặt bàn chờ duyệt',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.grey[700]),
            onPressed: controller.refreshBookings,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(color: Colors.red[400]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.refreshBookings,
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        if (controller.pendingBookings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_available,
                  size: 64.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Không có đặt bàn nào đang chờ duyệt',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refreshBookings(),
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.pendingBookings.length,
            itemBuilder: (context, index) {
              final booking = controller.pendingBookings[index];
              return Card(
                margin: EdgeInsets.only(bottom: 16.h),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            child: Text(
                              booking.customerName?[0] ?? 'U',
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking.customerName ?? 'Khách hàng',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  booking.phoneNumber ?? 'Chưa có SĐT',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              '${booking.partySize ?? 0} người',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildInfoRow(
                        Icons.event,
                        'Ngày đặt:',
                        DateFormat('dd/MM/yyyy').format(booking.createdAt ?? DateTime.now()),
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        Icons.access_time,
                        'Giờ đặt:',
                        DateFormat('HH:mm').format(booking.reservationTime ?? DateTime.now()),
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        Icons.note,
                        'Ghi chú:',
                        booking.specialRequests ?? 'Không có ghi chú',
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _showRejectDialog(context, booking.orderId ?? ''),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[50],
                                foregroundColor: Colors.red,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                'Từ chối',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _showApproveDialog(context, booking.orderId ?? ''),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[600],
                                elevation: 0,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                'Chấp nhận',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                              ),
                            ),
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
      }),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey[600]),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showRejectDialog(BuildContext context, String bookingId) async {
    final reasonController = TextEditingController();
    
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Từ chối đặt bàn',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Vui lòng nhập lý do từ chối:',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: reasonController,
              decoration: InputDecoration(
                hintText: 'Nhập lý do...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (reasonController.text.trim().isEmpty) {
                Get.snackbar(
                  'Lỗi',
                  'Vui lòng nhập lý do từ chối',
                  backgroundColor: Colors.red[400],
                  colorText: Colors.white,
                );
                return;
              }
              Get.back();
              // controller.(bookingId, reasonController.text.trim());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
            ),
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }

  Future<void> _showApproveDialog(BuildContext context, String bookingId) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Xác nhận chấp nhận',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Text('Bạn có chắc chắn muốn chấp nhận đặt bàn này?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // controller.approveBooking(bookingId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
            ),
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }
} 