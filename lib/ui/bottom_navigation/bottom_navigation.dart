import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../home_screen/home_screen.dart';
import '../setting_screen/setting_screen.dart';
import 'bottom_navigation_controller.dart';

class BottomNavigation extends GetView<BottomNavigationController> {
  BottomNavigation({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(),
    const Center(),
    const SettingsScreen()
  ];

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: isSelected
          ? const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.grey : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.grey : Colors.white,
              fontSize: 14.sp,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
            () => Material(
          elevation: 0,
          color: Colors.grey,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: controller.changePage,
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              items: [
                BottomNavigationBarItem(
                  icon: _buildNavItem(
                    Icons.home_outlined,
                    'Trang chủ',
                    controller.currentIndex.value == 0,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildNavItem(
                    Icons.shopping_cart,
                    'Giỏ hàng',
                    controller.currentIndex.value == 1,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildNavItem(
                    Icons.table_rows_outlined,
                    'Đặt bàn',
                    controller.currentIndex.value == 2,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildNavItem(
                    Icons.people,
                    'Tài khoản',
                    controller.currentIndex.value == 3,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}