import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'booking_controller.dart';

class ConfirmBookingScreen extends GetView<TableBookingController> {
  const ConfirmBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Xác nhận đặt bàn',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookingDetailsCard(),
            SizedBox(height: 16.h),
            _buildSelectedDishesCard(),
            SizedBox(height: 24.h),
            _buildConfirmButton(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingDetailsCard() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
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
          Text(
            'Thông tin đặt bàn',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            icon: Icons.person_outline,
            title: 'Tên khách hàng',
            value: controller.nameController.text,
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.phone_outlined,
            title: 'Số điện thoại',
            value: controller.phoneController.text,
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.event,
            title: 'Ngày đặt bàn',
            value: DateFormat('dd/MM/yyyy').format(controller.selectedDate.value),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.access_time,
            title: 'Giờ đặt bàn',
            value: controller.selectedTime.value.format(Get.context!),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            icon: Icons.people,
            title: 'Số người',
            value: '${controller.numberOfPeople.value} người',
          ),
          if (controller.specialRequestsController.text.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.note,
              title: 'Yêu cầu đặc biệt',
              value: controller.specialRequestsController.text,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedDishesCard() {
    final selectedDishIds = controller.selectedDishes;
    final selectedDishes = controller.categoryDishes
        .where((dish) => selectedDishIds.contains(dish.id))
        .toList();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      padding: EdgeInsets.all(16.r),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Món ăn đã chọn',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECE8),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${selectedDishes.length} món',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFF7043),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (selectedDishes.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  'Không có món ăn nào được chọn',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectedDishes.length,
              separatorBuilder: (context, index) => Divider(
                height: 24.h,
                color: Colors.grey[200],
              ),
              itemBuilder: (context, index) {
                final dish = selectedDishes[index];
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: dish.image != null && dish.image!.isNotEmpty
                          ? Image.network(
                              dish.image!,
                              height: 50.h,
                              width: 50.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 50.h,
                                  width: 50.w,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.restaurant,
                                    color: Colors.grey[500],
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 50.h,
                              width: 50.w,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.restaurant,
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
                            dish.name ?? 'Không có tên',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF303030),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${dish.price ?? 0} VNĐ',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFF7043),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                controller.summitBooking();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7043),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Xác nhận đặt bàn',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}