import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/core/config/assets/app_vectors.dart';
import 'package:food_delivery_app/ui/register_screen/register_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/router_name.dart';

class SignUpScreen extends GetView<RegisterController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                _buildHeader(),
                SizedBox(height: 32.h),
                _buildRegistrationForm(),
                SizedBox(height: 24.h),
                _buildTermsAndPrivacy(),
                SizedBox(height: 24.h),
                _buildSignUpButton(),
                SizedBox(height: 32.h),
                _buildSocialDivider(),
                SizedBox(height: 24.h),
                _buildSocialSignUp(),
                SizedBox(height: 24.h),
                _buildLoginLink(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: const Color(0xFF303030),
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 24.h),
        Text(
          'Tạo tài khoản',
          style: GoogleFonts.poppins(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF303030),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Vui lòng nhập thông tin của bạn để tạo tài khoản',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          label: 'Tên đăng nhập',
          hintText: 'Nhập tên đăng nhập của bạn',
          icon: Icons.account_circle_outlined,
          onChanged: (value) => controller.username.value = value,
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 20.h),
        _buildInputField(
          label: 'Email',
          hintText: 'Nhập email của bạn',
          icon: Icons.email_outlined,
          onChanged: (value) => controller.email.value = value,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20.h),
        _buildInputField(
          label: 'Họ và tên',
          hintText: 'Nhập họ và tên của bạn',
          icon: Icons.people,
          onChanged: (value) => controller.fullName.value = value,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 20.h),
        _buildInputField(
          label: 'Số điện thoại',
          hintText: 'Nhập số điện thoại của bạn',
          icon: Icons.phone_android_rounded,
          onChanged: (value) => controller.mobileNumber.value = value,
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 20.h),
        _buildPasswordField(),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    required Function(String) onChanged,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1.w,
            ),
          ),
          child: TextField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              color: const Color(0xFF303030),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                icon,
                color: const Color(0xFFFF7043),
                size: 20.sp,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mật khẩu',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        SizedBox(height: 8.h),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.w,
              ),
            ),
            child: TextField(
              obscureText: !controller.isPasswordVisible.value,
              onChanged: (value) => controller.password.value = value,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                color: const Color(0xFF303030),
              ),
              decoration: InputDecoration(
                hintText: 'Nhập mật khẩu của bạn',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: const Color(0xFFFF7043),
                  size: 20.sp,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Colors.grey[500],
                    size: 20.sp,
                  ),
                  onPressed: () => controller.togglePasswordVisibility(),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndPrivacy() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            color: Colors.grey[600],
          ),
          children: [
            const TextSpan(text: 'Bằng việc tiếp tục, bạn đồng ý với '),
            TextSpan(
              text: 'Điều khoản sử dụng',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFF7043),
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            const TextSpan(text: ' và '),
            TextSpan(
              text: 'Chính sách bảo mật',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFF7043),
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            const TextSpan(text: ' của chúng tôi'),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
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
        onPressed: () => controller.signUp(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Đăng ký',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Hoặc đăng ký với',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
      ],
    );
  }

  Widget _buildSocialSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: AppVectors.google,
          label: 'Google',
          onTap: () => controller.signUpWithGoogle(),
          backgroundColor: Colors.white,
          borderColor: Colors.grey[300]!,
          textColor: const Color(0xFF303030),
        ),
        SizedBox(width: 16.w),
        _buildSocialButton(
          icon: AppVectors.microsoft,
          label: 'Microsoft',
          onTap: () => controller.signUpWithMicrosoft(),
          backgroundColor: Colors.blue[900]!,
          textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
    required Color backgroundColor,
    Color? borderColor,
    required Color textColor,
  }) {
    return Expanded(
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1.w)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 20.w,
                  height: 20.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Đã có tài khoản? ",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
          children: [
            TextSpan(
              text: 'Đăng nhập',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFF7043),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.back();
                },
            ),
          ],
        ),
      ),
    );
  }
}
