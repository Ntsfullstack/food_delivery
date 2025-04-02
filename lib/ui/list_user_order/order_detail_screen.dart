import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:food_delivery_app/ui/list_user_order/order_detail_controller.dart';

import '../../models/order/order_detail.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Chi tiết đơn hàng',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20.sp),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF7043),
            ),
          );
        }

        if (controller.orderDetail.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 70.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Không tìm thấy thông tin đơn hàng',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          );
        }

        final order = controller.orderDetail.value!;
        final formatter = NumberFormat('#,###', 'vi_VN');

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderInfoCard(order, formatter),
              SizedBox(height: 16.h),
              _buildUserInfoCard(order),
              SizedBox(height: 16.h),
              _buildOrderItemsCard(order, formatter),
              SizedBox(height: 16.h),
              _buildOrderSummaryCard(order, formatter),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOrderInfoCard(OrderDetail order, NumberFormat formatter) {
    // Xác định màu sắc dựa trên trạng thái
    Color statusColor;
    switch (order.status) {
      case 'pending':
        statusColor = Colors.blue;
        break;
      case 'confirmed':
        statusColor = Colors.orange;
        break;
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    // Format date
    String formattedDate = 'N/A';
    if (order.createdAt != null) {
      try {
        formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(order.createdAt!);
      } catch (e) {
        print('Error formatting date: $e');
      }
    }

    return Card(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đơn hàng #${order.orderId}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    controller.getStatusDisplayName(order.status),
                    style: GoogleFonts.poppins(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildInfoRow('Ngày đặt:', formattedDate),
            if (order.tableId != null)
              _buildInfoRow('Bàn số:', order.tableId.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(OrderDetail order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin người đặt',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 12.h),
            _buildInfoRow('Tên người dùng:', order.username ?? 'N/A'),
            _buildInfoRow('Email:', order.email ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsCard(OrderDetail order, NumberFormat formatter) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Món ăn đã đặt',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 12.h),
            if (order.items == null || order.items!.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    'Không có món ăn nào',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.items!.length,
                itemBuilder: (context, index) {
                  final item = order.items![index];
                  // Parse price to double for calculation
                  double itemPrice = double.tryParse(item.price ?? '0') ?? 0;
                  double totalItemPrice = itemPrice * (item.quantity ?? 1);

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: item.imageUrl != null
                              ? Image.network(
                                  item.imageUrl!,
                                  width: 60.w,
                                  height: 60.w,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60.w,
                                      height: 60.w,
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.grey[500],
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  width: 60.w,
                                  height: 60.w,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.grey[500],
                                  ),
                                ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.dishName ?? 'N/A',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${formatter.format(itemPrice)}đ x ${item.quantity}',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${formatter.format(totalItemPrice)}đ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard(OrderDetail order, NumberFormat formatter) {
    // Parse totalPrice to double
    double totalPrice = double.tryParse(order.totalPrice ?? '0') ?? 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tổng cộng',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Divider(height: 24.h),
            _buildPriceRow(
              'Tổng cộng:',
              formatter.format(totalPrice),
              isTotal: true,
            ),
            SizedBox(height: 16.h),
            if (order.status == 'pending')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showCancelDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Hủy đơn hàng',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.w,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: isTotal ? Colors.black87 : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              fontSize: isTotal ? 16.sp : 14.sp,
            ),
          ),
          Text(
            '${value}đ',
            style: GoogleFonts.poppins(
              color: isTotal ? const Color(0xFFFF7043) : Colors.black87,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              fontSize: isTotal ? 16.sp : 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hủy đơn hàng',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Bạn có chắc chắn muốn hủy đơn hàng này không?',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Không',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      controller.cancelOrder();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Hủy đơn',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
