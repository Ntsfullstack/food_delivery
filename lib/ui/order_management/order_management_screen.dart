import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/models/order_managerment/order_managerment.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'order_management_controller.dart';

class OrderManagementScreen extends GetView<OrderManagementController> {
  const OrderManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7043),
        elevation: 0,
        title: Text(
          'Quản lý đơn hàng',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildStatusFilter(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshOrders,
              child: Obx(() {
                if (controller.isLoadingData.value && controller.orders.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final orders = controller.filteredOrders;
                
                if (orders.isEmpty) {
                  return Center(
                    child: Text(
                      'Không tìm thấy đơn hàng nào',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }
                
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                        controller.hasMoreData.value &&
                        !controller.isLoadingData.value) {
                      controller.loadMoreOrders();
                      return true;
                    }
                    return false;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: orders.length + (controller.hasMoreData.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == orders.length) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      }
                      return _buildOrderItem(orders[index]);
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: TextField(
        onChanged: controller.setSearchQuery,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm đơn hàng...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: const Color(0xFFFF7043), width: 1.w),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      height: 50.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.statusList.length,
        itemBuilder: (context, index) {
          final status = controller.statusList[index];
          final isSelected = status == controller.selectedStatus.value;
          
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
                status,
                style: GoogleFonts.poppins(
                  color: isSelected ? Colors.white : Colors.grey[800],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  Widget _buildOrderItem(OrderManagement order) {
    Color statusColor;
    switch (order.status) {
      case 'Hoàn thành':
        statusColor = Colors.green;
        break;
      case 'Đang giao':
        statusColor = Colors.blue;
        break;
      case 'Đã hủy':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final formattedDate = order.orderDate != null 
        ? dateFormat.format(order.orderDate!)
        : 'N/A';

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
                    order.status ?? 'Đang xử lý',
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
            Row(
              children: [
                Icon(Icons.person_outline, size: 18.sp, color: Colors.grey[600]),
                SizedBox(width: 8.w),
                Text(
                  order.username ?? 'Khách hàng',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[800],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.access_time, size: 18.sp, color: Colors.grey[600]),
                SizedBox(width: 8.w),
                Text(
                  formattedDate,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[800],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.attach_money, size: 18.sp, color: Colors.grey[600]),
                SizedBox(width: 8.w),
                Text(
                  '${order.totalPrice ?? "0"} VNĐ',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to order detail screen
                    Get.toNamed('/order-detail/${order.orderId}');
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
                ElevatedButton(
                  onPressed: () {
                    _showStatusUpdateDialog(order);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7043),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Cập nhật',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showStatusUpdateDialog(OrderManagement order) {
    final currentStatus = order.status ?? 'Đang xử lý';
    String selectedStatus = currentStatus;
    
    Get.dialog(
      AlertDialog(
        title: Text(
          'Cập nhật trạng thái',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: controller.statusList
                  .where((status) => status != 'Tất cả')
                  .map((status) => RadioListTile<String>(
                        title: Text(
                          status,
                          style: GoogleFonts.poppins(),
                        ),
                        value: status,
                        groupValue: selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value!;
                          });
                        },
                      ))
                  .toList(),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: GoogleFonts.poppins(color: Colors.grey[800]),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              if (selectedStatus != currentStatus) {
                controller.updateOrderStatus(order.orderId.toString(), selectedStatus);
              }
            },
            child: Text(
              'Cập nhật',
              style: GoogleFonts.poppins(color: const Color(0xFFFF7043)),
            ),
          ),
        ],
      ),
    );
  }
}