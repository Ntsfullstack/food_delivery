import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'otp_controller.dart';

class VerifyEmailScreen extends GetView<VerifyEmailController> {
  const VerifyEmailScreen({Key? key}) : super(key: key);

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
                SizedBox(height: 40.h),
                _buildInstructions(),
                SizedBox(height: 40.h),
                _buildVerificationCodeInput(),
                SizedBox(height: 24.h),
                _buildResendOption(),
                SizedBox(height: 40.h),
                _buildVerifyButton(),
                SizedBox(height: 24.h),
                _buildBackToLoginButton(),
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
          onPressed: () => controller.backToLogin(),
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
        ),
        SizedBox(height: 24.h),
        Text(
          'Xác thực Email',
          style: GoogleFonts.poppins(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF303030),
          ),
        ),
        SizedBox(height: 8.h),
        Obx(() => Text(
          'Vui lòng nhập mã xác thực đã được gửi đến ${controller.email.value}',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        )),
      ],
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue[700],
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Kiểm tra hộp thư của bạn để lấy mã xác thực. Mã có hiệu lực trong vòng 10 phút.',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.blue[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCodeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mã xác thực',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        SizedBox(height: 12.h),
        PinCodeTextField(
          appContext: Get.context!,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8.r),
            fieldHeight: 50.h,
            fieldWidth: 45.w,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.grey[100],
            selectedFillColor: Colors.white,
            activeColor: const Color(0xFFFF7043),
            inactiveColor: Colors.grey[300],
            selectedColor: const Color(0xFFFF7043),
          ),
          cursorColor: const Color(0xFFFF7043),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            controller.verificationCode.value = value;
          },
        ),
      ],
    );
  }

  Widget _buildResendOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Chưa nhận được mã?',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 4.w),
        // Obx(() => TextButton(
        //   onPressed: controller.canResend.value
        //       ? controller.resendVerificationCode
        //       : null,
        //   style: TextButton.styleFrom(
        //     padding: EdgeInsets.symmetric(horizontal: 8.w),
        //     foregroundColor: const Color(0xFFFF7043),
        //     textStyle: GoogleFonts.poppins(
        //       fontSize: 14.sp,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        //   child: Text(
        //     controller.canResend.value
        //         ? 'Gửi lại mã'
        //         : 'Gửi lại sau ${controller.countdown.value}s',
        //   ),
        // )),
      ],
    );
  }

  Widget _buildVerifyButton() {
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
        onPressed: controller.verifyEmail,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Xác thực',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBackToLoginButton() {
    return Center(
      child: TextButton(
        onPressed: controller.backToLogin,
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey[700],
          textStyle: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        child: Text(
          'Quay lại đăng nhập',
        ),
      ),
    );
  }
}