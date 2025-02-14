import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../home_screen/home_screen.dart';
import 'bottom_navigation_controller.dart';


class BottomNavigation extends GetView<BottomNavigationController> {
  BottomNavigation({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const HomeScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
            () => Container(
          height: kBottomNavigationBarHeight * 1.6.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xCC4F6D7E),
                Color(0x804F6D7E),
              ],
            ),
            borderRadius:  BorderRadius.vertical(
              top: Radius.circular(30.h),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
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
                selectedFontSize: 20.sp, // Tăng kích thước cho label đã chọn
                unselectedFontSize: 20.sp, // Tăng kích thước cho label chưa chọn
                type: BottomNavigationBarType.fixed, // Thêm type fixed để đảm bảo vị trí center
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined, color: Colors.white),
                    label: '.',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.location_on_outlined, color: Colors.white),
                    label: '.',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined, color: Colors.white),
                    label: '.',
                  ),
                ],
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white, // Đổi màu unselected thành trắng
                selectedLabelStyle: TextStyle(height: 0.5.h), // Điều chỉnh vị trí của label
                unselectedLabelStyle: TextStyle(height: 0.5.h), // Điều chỉnh vị trí của label
              ),
            ),
          ),
        ),
      ),
    );
  }
}