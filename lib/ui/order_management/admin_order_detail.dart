import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/order/order_detail.dart';
import '../../x_utils/currency_formatter.dart';
import 'order_management_controller.dart';

class AdminOrderDetailScreen extends GetView<OrderManagementController> {
  const AdminOrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments as String;

    // Load order detail when screen is built
    controller.loadOrderDetail(orderId);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Chi tiết đơn hàng',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF303030)),
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

        final order = controller.selectedOrder.value;
        if (order == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Không tìm thấy thông tin đơn hàng',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () => controller.loadOrderDetail(orderId),
                  child: Text(
                    'Thử lại',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: const Color(0xFFFF7043),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderStatusCard(order),
              SizedBox(height: 16.h),
              _buildCustomerInfoCard(order),
              SizedBox(height: 16.h),
              _buildOrderItemsCard(order),
              SizedBox(height: 16.h),
              _buildOrderSummaryCard(order),
              SizedBox(height: 16.h),
              _buildActionButtons(order),
              SizedBox(height: 24.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOrderStatusCard(OrderDetail order) {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Text(
            'Trạng thái đơn hàng',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: _getStatusColor(order.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              _getStatusText(order.status),
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: _getStatusColor(order.status),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfoCard(OrderDetail order) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Text(
            'Thông tin khách hàng',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow('Tên khách hàng', order.username ?? 'N/A'),
          SizedBox(height: 8.h),
          _buildInfoRow('Email', order.email ?? 'N/A'),
          SizedBox(height: 8.h),
          _buildInfoRow('ID khách hàng', order.userId ?? 'N/A'),
          if (order.tableId != null) ...[
            SizedBox(height: 8.h),
            _buildInfoRow('Bàn số', order.tableId.toString()),
          ],
          SizedBox(height: 8.h),
          _buildInfoRow('Ngày đặt hàng', _formatDate(order.orderDate?.toString() ?? '')),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateStr;
    }
  }

  Widget _buildOrderItemsCard(OrderDetail order) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Text(
            'Chi tiết đơn hàng',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 12.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items?.length ?? 0,
            itemBuilder: (context, index) {
              final item = order.items![index];
              final itemPrice = double.tryParse(item.price ?? '0') ?? 0.0;
              final itemQuantity = item.quantity ?? 1;

              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.grey[200],
                        image: item.imageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(item.imageUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: item.imageUrl == null
                          ? Icon(
                              Icons.restaurant,
                              color: Colors.grey[400],
                              size: 24.sp,
                            )
                          : null,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.dishName ?? 'N/A',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF303030),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '$itemQuantity x ${CurrencyFormatter.format(itemPrice)}',
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (item.specialRequests != null && item.specialRequests.toString().isNotEmpty) ...[
                            SizedBox(height: 4.h),
                            Text(
                              'Yêu cầu: ${item.specialRequests}',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Text(
                      CurrencyFormatter.format(itemPrice * itemQuantity),
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF7043),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard(OrderDetail order) {
    final totalPrice = double.tryParse(order.totalPrice ?? '0') ?? 0.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Text(
            'Tổng kết đơn hàng',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 12.h),
          _buildSummaryRow('Tạm tính', totalPrice),
          SizedBox(height: 12.h),
          const Divider(),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            'Tổng cộng',
            totalPrice,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(OrderDetail order) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.r),

        child: ElevatedButton(
          onPressed: () => _showStatusUpdateDialog(order),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF7043),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            'Cập nhật trạng thái đơn hàng',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showStatusUpdateDialog(OrderDetail order) {
    final List<String> statusOptions = [
      'Đang xử lý',
      'Đang giao', 
      'Hoàn thành',
      'Đã hủy',
    ];
    
    String selectedStatus = _getStatusText(order.status);

    Get.dialog(
      AlertDialog(
        title: Text(
          'Cập nhật trạng thái đơn hàng',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: statusOptions.map((status) => RadioListTile<String>(
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
              )).toList(),
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
              if (selectedStatus != _getStatusText(order.status)) {
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

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF303030),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? const Color(0xFF303030) : Colors.grey[600],
          ),
        ),
        Text(
          CurrencyFormatter.format(amount),
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? const Color(0xFFFF7043) : const Color(0xFF303030),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFFA000);
      case 'processing':
        return const Color(0xFF2196F3);
      case 'completed':
        return const Color(0xFF4CAF50);
      case 'cancelled':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return 'Đang xử lý';
      case 'processing':
        return 'Đang xử lý';
      case 'confirmed':
        return 'Đang giao';
      case 'completed':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Đang xử lý';
    }
  }
}