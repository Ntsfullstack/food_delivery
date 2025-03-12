import 'dart:io';
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
        elevation: 0.5,
        title: Text(
          'Thông tin cá nhân',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        actions: [
          Obx(() => TextButton(
                onPressed: controller.isEditing.value
                    ? controller.updateProfile
                    : controller.toggleEditing,
                child: Text(
                  controller.isEditing.value ? 'Lưu' : 'Chỉnh sửa',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF7043),
                  ),
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAvatarSection(),
            SizedBox(height: 24.h),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Stack(
            children: [
              Obx(() {
                final avatarPath = controller.avatarPath.value;
                return CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: avatarPath.isNotEmpty
                      ? FileImage(File(avatarPath))
                      : const NetworkImage(
                          'https://ui-avatars.com/api/?name=User&background=FF7043&color=fff',
                        ) as ImageProvider,
                );
              }),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF7043),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Obx(() {
            final profile = controller.profile.value;
            if (profile == null) return const SizedBox.shrink();
            return Text(
              profile.fullName,
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF303030),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin cơ bản',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 16.h),
          _buildInfoCard(),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
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
      child: Obx(() {
        final isEditing = controller.isEditing.value;
        return Column(
          children: [
            _buildTextField(
              label: 'Họ và tên',
              controller: controller.fullNameController,
              enabled: isEditing,
              icon: Icons.person_outline,
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              label: 'Tên đăng nhập',
              controller: controller.usernameController,
              enabled: false, // Username không được phép sửa
              icon: Icons.account_circle_outlined,
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              label: 'Email',
              controller: controller.emailController,
              enabled: false, // Email không được phép sửa
              icon: Icons.email_outlined,
            ),
            SizedBox(height: 16.h),
            _buildTextField(
              label: 'Số điện thoại',
              controller: controller.phoneController,
              enabled: isEditing,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: const Color(0xFF303030),
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: const Color(0xFFFF7043),
              size: 20.sp,
            ),
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFFFF7043),
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
