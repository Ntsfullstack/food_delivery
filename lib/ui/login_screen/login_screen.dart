import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/core/config/assets/app_images.dart';
import 'package:food_delivery_app/core/config/assets/app_vectors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/router_name.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

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
                SizedBox(height: 40.h),
                _buildHeader(),
                SizedBox(height: 40.h),
                _buildLoginForm(),
                SizedBox(height: 24.h),
                _buildForgotPassword(),
                SizedBox(height: 32.h),
                _buildLoginButton(),
                SizedBox(height: 40.h),
                _buildSocialLoginSection(),
                SizedBox(height: 32.h),
                _buildSignUpLink(),
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
        Center(
          child: Image.asset(
            AppImages.logo,
            width: 120.w,
            height: 120.h,
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đăng nhập',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF303030),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          label: 'Mã người dùng',
          hintText: 'Nhập mã người dùng của bạn',
          icon: Icons.person_outline_rounded,
          onChanged: (value) => controller.email.value = value,
        ),
        SizedBox(height: 24.h),
        _buildPasswordField(),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
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

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigate to forgot password screen
          {}
        },
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 8.w,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Quên mật khẩu?',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFFF7043),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
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
        onPressed: () => controller.login(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Đăng nhập',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[300])),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Hoặc đăng nhập với',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[500],
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[300])),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: AppVectors.google,
              label: 'Google',
              onTap: () => controller.loginWithGoogle(),
              backgroundColor: Colors.white,
              borderColor: Colors.grey[300]!,
              textColor: const Color(0xFF303030),
            ),
            SizedBox(width: 16.w),
            _buildSocialButton(
              icon: AppVectors.microsoft,
              label: 'Microsoft',
              onTap: () => controller.loginWithFacebook(),
              backgroundColor: Colors.blue[900]!,
              textColor: Colors.white,
            ),
          ],
        ),
        SizedBox(height: 16.h),
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

  Widget _buildSignUpLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Chưa có tài khoản? ",
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
          children: [
            TextSpan(
              text: 'Đăng ký',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFF7043),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(RouterName.register);
                },
            ),
          ],
        ),
      ),
    );
  }
}
