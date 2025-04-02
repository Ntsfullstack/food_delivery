import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:food_delivery_app/ui/list_user_order/list_user_order_controller.dart';

import '../../models/order/order.dart';

class ListUserOrderScreen extends GetView<ListUserOrderController> {
  const ListUserOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Đơn hàng của tôi',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStatusFilter(),
          Expanded(
            child: Obx(() {
              if (controller.isLoadingOrders && controller.orders.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFF7043),
                  ),
                );
              }

              if (controller.orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 70.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Không tìm thấy đơn hàng nào',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      controller.hasMoreData.value &&
                      !controller.isLoadingOrders) {
                    controller.loadMoreOrders();
                    return true;
                  }
                  return false;
                },
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: controller.orders.length + (controller.hasMoreData.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.orders.length) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: const CircularProgressIndicator(
                            color: Color(0xFFFF7043),
                          ),
                        ),
                      );
                    }

                    final order = controller.orders[index];
                    return _buildOrderCard(order);
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
        itemCount: controller.statusList.length,
        itemBuilder: (context, index) {
          final status = controller.statusList[index];
          return Obx(() {
            final isSelected = status == controller.selectedStatus.value;
            
            // Hiển thị tên trạng thái người dùng có thể đọc được
            final displayName = status == 'Tất cả' 
                ? 'Tất cả' 
                : controller.statusDisplayNames[status] ?? status;
            
            return GestureDetector(
              onTap: () => controller.setStatus(status),
              child: Container(
                margin: EdgeInsets.only(right: 10.w, bottom: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFF7043) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  displayName,
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : Colors.grey[800],
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildOrderCard(ListOrder order) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    
    // Xác định màu sắc dựa trên trạng thái API thực tế
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
        final date = DateTime.parse(order.createdAt!.toString());
        formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
      } catch (e) {
        print('Error parsing date: $e');
      }
    }

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
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    // Hiển thị tên trạng thái người dùng có thể đọc được
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
            Text(
              'Ngày đặt: $formattedDate',
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
            ),

            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    controller.viewOrderDetail(order.orderId.toString());
                  },
                  icon: const Icon(Icons.visibility_outlined),
                  label: Text(
                    'Chi tiết',
                    style: GoogleFonts.poppins(),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFF7043),
                    side: const BorderSide(color: Color(0xFFFF7043)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}