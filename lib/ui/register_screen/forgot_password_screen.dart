import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/register_screen/forgot_password_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: const Color(0xFF303030),
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Quên mật khẩu',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => _buildMainContent()),
    );
  }

  Widget _buildMainContent() {
    // Hiển thị nội dung dựa trên trạng thái hiện tại
    if (controller.resetState.value == ResetPasswordState.enterEmail) {
      return _buildEnterEmailView();
    } else if (controller.resetState.value == ResetPasswordState.verifyOtp) {
      return _buildVerifyOtpView();
    } else {
      return _buildNewPasswordView();
    }
  }

  Widget _buildEnterEmailView() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon và thông tin
          _buildHeaderInfo(
            icon: Icons.email_outlined,
            title: 'Nhập email của bạn',
            description:
                'Chúng tôi sẽ gửi một mã OTP đến email của bạn để xác nhận việc đặt lại mật khẩu',
          ),
          SizedBox(height: 32.h),

          // Form nhập email
          _buildInputField(
            label: 'Email',
            hintText: 'Nhập email đã đăng ký',
            icon: Icons.email_outlined,
            onChanged: (value) => controller.email.value = value,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 24.h),

          // Nút tiếp tục
          _buildGradientButton(
            label: 'Tiếp tục',
            onPressed: () => controller.sendResetCode(),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyOtpView() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon và thông tin
          _buildHeaderInfo(
            icon: Icons.verified_user_outlined,
            title: 'Nhập mã xác thực',
            description:
                'Chúng tôi đã gửi mã OTP đến ${controller.email.value}. Vui lòng kiểm tra hộp thư và nhập mã tại đây',
          ),
          SizedBox(height: 32.h),

          // OTP field
          _buildOtpField(),
          SizedBox(height: 16.h),

          // Đếm ngược thời gian
          Center(
            child: Obx(() => Text(
                  controller.timeLeft.value > 0
                      ? 'Gửi lại sau ${controller.timeLeft.value}s'
                      : 'Không nhận được mã?',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                )),
          ),
          SizedBox(height: 8.h),

          // Nút gửi lại
          Center(
            child: Obx(
              () => TextButton(
                onPressed: controller.timeLeft.value > 0
                    ? null
                    : () => controller.resendCode(),
                child: Text(
                  'Gửi lại mã',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: controller.timeLeft.value > 0
                        ? Colors.grey[400]
                        : const Color(0xFFFF7043),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Nút xác nhận
          _buildGradientButton(
            label: 'Xác nhận',
            onPressed: () => controller.verifyOtp(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewPasswordView() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon và thông tin
          _buildHeaderInfo(
            icon: Icons.lock_reset_outlined,
            title: 'Tạo mật khẩu mới',
            description:
                'Mật khẩu mới của bạn phải khác với mật khẩu đã sử dụng trước đây',
          ),
          SizedBox(height: 32.h),

          // Nhập mật khẩu mới
          _buildPasswordField(
            label: 'Mật khẩu mới',
            hintText: 'Nhập mật khẩu mới',
            isVisible: controller.isPasswordVisible,
            onChanged: (value) => controller.newPassword.value = value,
            toggleVisibility: () => controller.togglePasswordVisibility(),
          ),
          SizedBox(height: 20.h),

          // Nhập lại mật khẩu mới
          _buildPasswordField(
            label: 'Xác nhận mật khẩu',
            hintText: 'Nhập lại mật khẩu mới',
            isVisible: controller.isConfirmPasswordVisible,
            onChanged: (value) => controller.confirmPassword.value = value,
            toggleVisibility: () =>
                controller.toggleConfirmPasswordVisibility(),
          ),
          SizedBox(height: 24.h),

          // Mật khẩu mạnh
          _buildPasswordStrengthIndicator(),
          SizedBox(height: 32.h),

          // Nút đặt lại mật khẩu
          _buildGradientButton(
            label: 'Đặt lại mật khẩu',
            onPressed: () => controller.resetPassword(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFFFF7043).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFF7043),
              size: 40.sp,
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF303030),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey[600],
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
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

  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required RxBool isVisible,
    required Function(String) onChanged,
    required VoidCallback toggleVisibility,
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
              obscureText: !isVisible.value,
              onChanged: onChanged,
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
                  Icons.lock_outline_rounded,
                  color: const Color(0xFFFF7043),
                  size: 20.sp,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible.value
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Colors.grey[500],
                    size: 20.sp,
                  ),
                  onPressed: toggleVisibility,
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

  Widget _buildOtpField() {
    return Center(
      child: SizedBox(
        height: 60.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: 60.w,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF303030),
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1.w,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: const Color(0xFFFF7043),
                      width: 1.5.w,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    FocusScope.of(context as BuildContext).nextFocus();
                  }
                  controller.updateOtpDigit(index, value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    return Obx(() {
      final strength = controller.passwordStrength.value;
      Color strengthColor;
      String strengthText;

      switch (strength) {
        case 0:
          strengthColor = Colors.grey;
          strengthText = 'Chưa nhập mật khẩu';
          break;
        case 1:
          strengthColor = Colors.red;
          strengthText = 'Yếu';
          break;
        case 2:
          strengthColor = Colors.orange;
          strengthText = 'Trung bình';
          break;
        case 3:
          strengthColor = Colors.green;
          strengthText = 'Mạnh';
          break;
        default:
          strengthColor = Colors.grey;
          strengthText = 'Chưa nhập mật khẩu';
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Độ mạnh mật khẩu: ',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                strengthText,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: strengthColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(
              3,
              (index) => Expanded(
                child: Container(
                  height: 4.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: index < strength ? strengthColor : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          if (controller.passwordError.isNotEmpty)
            Text(
              controller.passwordError.value,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.red[600],
              ),
            ),
        ],
      );
    });
  }

  Widget _buildGradientButton({
    required String label,
    required VoidCallback onPressed,
  }) {
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
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
