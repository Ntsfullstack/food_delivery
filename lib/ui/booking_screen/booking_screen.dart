import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_controller.dart';

class TableBookingScreen extends GetView<TableBookingController> {
  const TableBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: const Color(0xFF303030),
              size: 16.r,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Đặt bàn',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),

                _buildSectionTitle(
                    'Thời gian đặt bàn', Icons.event_note_rounded),
                SizedBox(height: 16.h),

                // Date picker
                Row(
                  children: [
                    Expanded(child: _buildDateSelector()),
                    SizedBox(width: 12.w),
                    Expanded(child: _buildTimeSelector()),
                  ],
                ),
                SizedBox(height: 16.h),

                // Guests selection
                _buildGuestsSelector(),
                SizedBox(height: 24.h),

                // Guest information
                _buildSectionTitle(
                    'Thông tin khách hàng', Icons.person_rounded),
                SizedBox(height: 16.h),
                _buildInputField(
                  controller: controller.nameController,
                  label: 'Họ và tên',
                  icon: Icons.person_outline_rounded,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Vui lòng nhập họ tên' : null,
                ),
                SizedBox(height: 16.h),
                _buildInputField(
                  controller: controller.phoneController,
                  label: 'Số điện thoại',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Vui lòng nhập số điện thoại'
                      : null,
                ),
                SizedBox(height: 16.h),
                _buildInputField(
                  controller: controller.emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Vui lòng nhập email';
                    if (!GetUtils.isEmail(value!)) return 'Email không hợp lệ';
                    return null;
                  },
                ),
                SizedBox(height: 24.h),

                // Special requests
                _buildSectionTitle('Yêu cầu đặc biệt', Icons.edit_note_rounded),
                SizedBox(height: 16.h),
                _buildSpecialRequests(),
                SizedBox(height: 32.h),

                // Submit button
                _buildSubmitButton(),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFFFF7043),
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Obx(() {
      final selectedDate = controller.selectedDate.value;
      return GestureDetector(
        onTap: () => controller.selectDate(),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: const Color(0xFFFF7043),
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Ngày',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    DateFormat('dd').format(selectedDate),
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF303030),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMM').format(selectedDate),
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF303030),
                        ),
                      ),
                      Text(
                        DateFormat('yyyy').format(selectedDate),
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                DateFormat('EEEE').format(selectedDate),
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTimeSelector() {
    return Obx(() {
      final selectedTime = controller.selectedTime.value;

      // Format hours to ensure 2 digits
      final hour = selectedTime.hour.toString().padLeft(2, '0');

      // Format minutes to ensure 2 digits
      final minute = selectedTime.minute.toString().padLeft(2, '0');

      // Determine if it's AM or PM
      final period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';

      return GestureDetector(
        onTap: () => controller.selectTime(),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: const Color(0xFFFF7043),
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Giờ',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    '$hour:$minute',
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF303030),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    period,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF7043),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFECE8),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Giờ hoạt động: 10:00 AM - 10:00 PM',
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFF7043),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildGuestsSelector() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people_alt_rounded,
                color: const Color(0xFFFF7043),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Số người',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.numberOfPeople.value > 1) {
                        controller.numberOfPeople.value--;
                      }
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: controller.numberOfPeople.value > 1
                            ? const Color(0xFFFF7043)
                            : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120.w,
                    child: Center(
                      child: Text(
                        '${controller.numberOfPeople.value} người',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF303030),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.numberOfPeople.value < 10) {
                        controller.numberOfPeople.value++;
                      }
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: controller.numberOfPeople.value < 10
                            ? const Color(0xFFFF7043)
                            : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: const Color(0xFF303030),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFFFF7043),
          size: 20.sp,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFFF7043)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red[400]!),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red[400]!),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
      ),
    );
  }

  Widget _buildSpecialRequests() {
    return TextFormField(
      controller: controller.specialRequestsController,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: const Color(0xFF303030),
      ),
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Ví dụ: Cần bàn gần cửa sổ, ghế cho trẻ em...',
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: Colors.grey[400],
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFFF7043)),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7043), Color(0xFFFF5722)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
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
        onPressed: controller.submitBooking,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          'Xác nhận đặt bàn',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
