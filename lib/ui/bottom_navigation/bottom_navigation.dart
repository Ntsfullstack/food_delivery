import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cart_screen/cart_screen.dart';
import '../home_screen/home_screen.dart';
import '../booking_screen/booking_screen.dart';
import '../list_user_order/list_user_order.dart';
import '../setting_screen/setting_screen.dart';
import 'bottom_navigation_controller.dart';

class BottomNavigation extends GetView<BottomNavigationController> {
  BottomNavigation({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    const TableBookingScreen(),
    const ListUserOrderScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for the floating effect
      body: Obx(() => _pages[controller.currentIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => Container(
          height: 115.h,
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
                    Icons.shopping_bag_rounded,
                    'giỏ hàng',
                    1,
                  ),
                  _buildNavItem(
                    Icons.table_bar,
                    'đặt bàn',
                    2,
                  ),
                  _buildNavItem(
                  Icons.list,
                      'Đơn hàng',
                      3),
                  _buildNavItem(
                    Icons.settings,
                    'cài đặt',
                    4,
                  ),
                ],
              ),
            ),
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
        padding: EdgeInsets.symmetric(horizontal: 15.w, ),
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
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
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
