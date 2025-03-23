import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'invoice_management_controller.dart';

class InvoiceManagementScreen extends GetView<InvoiceManagementController> {
  const InvoiceManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7043),
        elevation: 0,
        title: Text(
          'Quản lý hóa đơn',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showDateFilterDialog(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshInvoices,
        child: Column(
          children: [
            _buildSearchBar(),
            _buildStatusFilter(),
            _buildDateRangeIndicator(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final invoices = controller.filteredInvoices;
                
                if (invoices.isEmpty) {
                  return Center(
                    child: Text(
                      'Không tìm thấy hóa đơn nào',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: invoices.length,
                  itemBuilder: (context, index) {
                    return _buildInvoiceItem(invoices[index]);
                  },
                );
              }),
            ),
          ],
        ),
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
          hintText: 'Tìm kiếm hóa đơn...',
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
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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

  // Continuing from where we left off
  Widget _buildDateRangeIndicator() {
    return Obx(() {
      if (controller.startDate.value == null && controller.endDate.value == null) {
        return const SizedBox.shrink();
      }
      
      final dateFormat = DateFormat('dd/MM/yyyy');
      String dateRangeText = 'Lọc theo ngày: ';
      
      if (controller.startDate.value != null && controller.endDate.value != null) {
        dateRangeText += '${dateFormat.format(controller.startDate.value!)} - ${dateFormat.format(controller.endDate.value!)}';
      } else if (controller.startDate.value != null) {
        dateRangeText += 'Từ ${dateFormat.format(controller.startDate.value!)}';
      } else if (controller.endDate.value != null) {
        dateRangeText += 'Đến ${dateFormat.format(controller.endDate.value!)}';
      }
      
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Text(
                dateRangeText,
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 14.sp,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () {
                controller.setDateRange(null, null);
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInvoiceItem(Invoice invoice) {
    Color statusColor;
    switch (invoice.status) {
      case 'Đã thanh toán':
        statusColor = Colors.green;
        break;
      case 'Đã hủy':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final formattedDate = dateFormat.format(invoice.date);

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
                  'Hóa đơn ${invoice.id}',
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
                    invoice.status,
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
                Icon(Icons.receipt_outlined, size: 18.sp, color: Colors.grey[600]),
                SizedBox(width: 8.w),
                Text(
                  'Đơn hàng: #${invoice.orderId}',
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
                Icon(Icons.person_outline, size: 18.sp, color: Colors.grey[600]),
                SizedBox(width: 8.w),
                Text(
                  invoice.customerName,
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
                Icon(Icons.payment, size: 18.sp, color: Colors.grey[600]),
                SizedBox(width: 8.w),
                Text(
                  invoice.paymentMethod,
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
                  controller.formatCurrency(invoice.amount),
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
                    // TODO: Navigate to invoice detail screen
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
                if (invoice.status == 'Chưa thanh toán')
                  ElevatedButton(
                    onPressed: () {
                      _showPaymentConfirmation(invoice);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7043),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Thanh toán',
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

  void _showDateFilterDialog(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: controller.startDate.value ?? DateTime.now().subtract(const Duration(days: 30)),
      end: controller.endDate.value ?? DateTime.now(),
    );
    
    final pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF7043),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (pickedDateRange != null) {
      controller.setDateRange(pickedDateRange.start, pickedDateRange.end);
    }
  }

  void _showPaymentConfirmation(Invoice invoice) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Xác nhận thanh toán',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Bạn có chắc chắn muốn đánh dấu hóa đơn ${invoice.id} là đã thanh toán?',
          style: GoogleFonts.poppins(),
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
              controller.markAsPaid(invoice.id);
            },
            child: Text(
              'Xác nhận',
              style: GoogleFonts.poppins(color: const Color(0xFFFF7043)),
            ),
          ),
        ],
      ),
    );
  }
}