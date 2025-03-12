import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/setting_screen/list_tile.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Cài đặt',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          _buildProfileSection(),
          SizedBox(height: 16.h),
          _buildGeneralSettings(),
          SizedBox(height: 16.h),
          _buildAccountSection(),
          SizedBox(height: 16.h),
          _buildSupportSection(),
          SizedBox(height: 16.h),
          _buildButtons(),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
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
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.viewProfile,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.r),
              child: Image.network(
                'https://ui-avatars.com/api/?name=${controller.profile.value?.fullName ?? "User"}&background=FF7043&color=fff',
                width: 70.w,
                height: 70.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  controller.profile.value?.fullName ?? 'Loading...',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF303030),
                  ),
                )),
                SizedBox(height: 4.h),
                Obx(() => Text(
                  controller.profile.value?.email ?? 'Loading...',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                )),
              ],
            ),
          ),
          IconButton(
            onPressed: controller.viewProfile,
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[400],
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            'Cài đặt chung',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
        ),
        Container(
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
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              // Notification toggle
              _buildNotificationToggle(),

              // Promotional notification toggle
              _buildPromoNotificationToggle(),

              // Language selector
              _buildLanguageSelector(),
            ],
          ),
        ),
      ],
    );
  }

  // Separate widget for dark mode toggle

  // Separate widget for notification toggle
  Widget _buildNotificationToggle() {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: const Color(0xFFFF7043).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.notifications_outlined,
          color: const Color(0xFFFF7043),
          size: 22.sp,
        ),
      ),
      title: Text(
        'Thông báo',
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF303030),
        ),
      ),
      subtitle: Text(
        'Nhận thông báo từ ứng dụng',
        style: GoogleFonts.poppins(
          fontSize: 13.sp,
          color: Colors.grey[600],
        ),
      ),
      // Only wrap the Switch in Obx
      trailing: Obx(() => Switch(
            value: controller.isNotificationEnabled,
            onChanged: controller.toggleNotification,
            activeColor: const Color(0xFFFF7043),
          )),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
    );
  }

  // Separate widget for promo notification toggle
  Widget _buildPromoNotificationToggle() {
    return Obx(() {
      // Only show this option if notifications are enabled
      if (!controller.isNotificationEnabled) {
        return const SizedBox.shrink();
      }

      return ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: const Color(0xFFFF7043).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.discount_outlined,
            color: const Color(0xFFFF7043),
            size: 22.sp,
          ),
        ),
        title: Text(
          'Thông báo khuyến mãi',
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF303030),
          ),
        ),
        subtitle: Text(
          'Nhận thông báo về khuyến mãi, ưu đãi',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            color: Colors.grey[600],
          ),
        ),
        trailing: Switch(
          value: controller.isPromoNotificationEnabled,
          onChanged: controller.togglePromoNotification,
          activeColor: const Color(0xFFFF7043),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      );
    });
  }

  // Separate widget for language selection
  Widget _buildLanguageSelector() {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: const Color(0xFFFF7043).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.language_rounded,
          color: const Color(0xFFFF7043),
          size: 22.sp,
        ),
      ),
      title: Text(
        'Ngôn ngữ',
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF303030),
        ),
      ),
      // Only wrap the language value in Obx
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Text(
                controller.selectedLanguage,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFF7043),
                  fontWeight: FontWeight.w500,
                ),
              )),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey[400],
            size: 18.sp,
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      onTap: _showLanguageBottomSheet,
    );
  }

  Widget _buildAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            'Tài khoản',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
        ),
        Container(
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
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomListTile(
                title: 'Đơn hàng của tôi',
                icon: Icons.shopping_bag_outlined,
                onTap: () => Get.toNamed('/orders'),
              ),
              CustomListTile(
                icon: Icons.location_on_outlined,
                title: 'Địa chỉ đã lưu',
                onTap: controller.viewAddresses,
              ),
              CustomListTile(
                icon: Icons.payment_rounded,
                title: 'Phương thức thanh toán',
                onTap: controller.viewPaymentMethods,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            'Hỗ trợ',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
        ),
        Container(
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
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomListTile(
                icon: Icons.help_outline_rounded,
                title: 'Trung tâm hỗ trợ',
                onTap: controller.openHelpCenter,
              ),
              CustomListTile(
                icon: Icons.description_outlined,
                title: 'Điều khoản dịch vụ',
                onTap: controller.openTermsOfService,
              ),
              CustomListTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Chính sách bảo mật',
                onTap: controller.openPrivacyPolicy,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () => _showLogoutConfirmation(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[100],
              foregroundColor: Colors.red[700],
              padding: EdgeInsets.symmetric(vertical: 14.h),
              minimumSize: Size(double.infinity, 0),
              elevation: 0,
            ),
            child: Text(
              'Đăng xuất',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chọn ngôn ngữ',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF303030),
              ),
            ),
            SizedBox(height: 16.h),
            ...controller.availableLanguages.map((language) => ListTile(
                  title: Text(
                    language,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: const Color(0xFF303030),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    controller.changeLanguage(language);
                    Get.back();
                  },
                  // Only wrap the check icon in Obx
                  trailing: Obx(() => controller.selectedLanguage == language
                      ? Icon(
                          Icons.check_circle,
                          color: const Color(0xFFFF7043),
                        )
                      : SizedBox(width: 24.w)),
                )),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout_rounded,
                color: Colors.red[400],
                size: 48.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'Đăng xuất',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF303030),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Hủy',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        backgroundColor: Colors.red[500],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Đăng xuất',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
