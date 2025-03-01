import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/setting_screen/list_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey[800],
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Thông tin cá nhân',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        actions: [
          // Only wrap the IconButton in Obx
          Obx(() => IconButton(
                icon: Icon(
                  controller.isEditing.value
                      ? Icons.close_rounded
                      : Icons.edit_outlined,
                  color: controller.isEditing.value
                      ? Colors.red[400]
                      : const Color(0xFFFF7043),
                  size: 22.sp,
                ),
                onPressed: () {
                  if (controller.isEditing.value) {
                    controller.cancelEditing();
                  } else {
                    controller.startEditing();
                  }
                },
              )),
        ],
      ),
      body: Obx(() {
        // Use a single Obx here to react to isEditing changes
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileHeader(),
              SizedBox(height: 30.h),
              _buildInfoCard(),
              SizedBox(height: 20.h),
              if (controller.isEditing.value) _buildSaveButton(),
              SizedBox(height: 20.h),
              _buildAdditionalOptions(),
              SizedBox(height: 30.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFF7043),
                  width: 2.w,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70.r),
                child: Obx(() => controller.profileImage.value != null
                    ? Image.file(
                        controller.profileImage.value!,
                        width: 130.w,
                        height: 130.w,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://randomuser.me/api/portraits/men/32.jpg',
                        width: 130.w,
                        height: 130.w,
                        fit: BoxFit.cover,
                      )),
              ),
            ),
            if (controller.isEditing.value)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFF7043),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF7043).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                    onPressed: controller.pickImage,
                    constraints: BoxConstraints.tightFor(
                      width: 44.w,
                      height: 44.w,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),
        Obx(() => Text(
              controller.userName.value,
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF303030),
              ),
            )),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFF7043).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_rounded,
                color: const Color(0xFFFF7043),
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                'Đã xác minh',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFFF7043),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
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
        children: [
          _buildInfoField(
            label: 'Họ và tên',
            value: controller.userName.value,
            icon: Icons.person_outline_rounded,
            onChanged: (value) => controller.tempName = value,
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          _buildInfoField(
            label: 'Email',
            value: controller.email.value,
            icon: Icons.email_outlined,
            onChanged: (value) => controller.tempEmail = value,
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          _buildInfoField(
            label: 'Số điện thoại',
            value: controller.phoneNumber.value,
            icon: Icons.phone_outlined,
            onChanged: (value) => controller.tempPhone = value,
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          _buildInfoField(
            label: 'Địa chỉ',
            value: controller.address.value,
            icon: Icons.location_on_outlined,
            onChanged: (value) => controller.tempAddress = value,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: Colors.grey[500],
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          controller.isEditing.value
              ? TextFormField(
                  initialValue: value,
                  onChanged: onChanged,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: const Color(0xFF303030),
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Nhập $label',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                )
              : Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: const Color(0xFF303030),
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 54.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7043), Color(0xFFFF5722)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7043).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: controller.saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Lưu thay đổi',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalOptions() {
    return Container(
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
        children: [
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          CustomListTile(
            title: 'Đổi mật khẩu',
            icon: Icons.lock_outline_rounded,
            onTap: () => Get.toNamed('/change-password'),
          ),
        ],
      ),
    );
  }
}
