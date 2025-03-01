import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cart_screen/cart_screen.dart';
import '../home_screen/home_screen.dart';
import '../booking_screen/booking_screen.dart';
import '../setting_screen/setting_screen.dart';
import 'bottom_navigation_controller.dart';

class BottomNavigation extends GetView<BottomNavigationController> {
  BottomNavigation({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    const TableBookingScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for the floating effect
      body: Obx(() => _pages[controller.currentIndex.value]),
      floatingActionButton: _buildCenterButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => Container(
          height: 90.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            child: BottomAppBar(
              notchMargin: 8,
              elevation: 0,
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    Icons.home_rounded,
                    'Trang chủ',
                    0,
                  ),
                  _buildNavItem(
                    Icons.search_rounded,
                    'Tìm kiếm',
                    1,
                  ),
                  // Empty space for the center button
                  SizedBox(width: 20.w),
                  _buildNavItem(
                    Icons.table_bar,
                    'đặt bàn',
                    2,
                  ),
                  _buildNavItem(
                    Icons.settings,
                    'cài đặt',
                    3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7043), Color(0xFFFF5722)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7043).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      height: 70.h,
      width: 60.h,
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {
          // Show cart or special action
          Get.toNamed('/cart');
        },
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds);
          },
          child: Icon(
            Icons.shopping_bag_rounded,
            size: 24.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = controller.currentIndex.value == index;
    return InkWell(
      onTap: () => controller.changePage(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Important to prevent overflow
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with background indicator
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: isSelected
                  ? BoxDecoration(
                      color: const Color(0xFFFF7043).withOpacity(0.1),
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Icon(
                icon,
                color:
                    isSelected ? const Color(0xFFFF7043) : Colors.grey.shade400,
                size: 22.sp, // Fixed size for icons, no animation
              ),
            ),
            SizedBox(height: 4.h), // Reduced spacing
            // Label with optional animation for color/weight only (not size)
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: GoogleFonts.poppins(
                fontSize: 10.sp, // Fixed size for all states
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color:
                    isSelected ? const Color(0xFFFF7043) : Colors.grey.shade500,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
