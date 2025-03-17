import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/routes/router_name.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_screen/login_controller.dart';
import 'dashboard_controller.dart';

class AdminDashboardScreen extends GetView<AdminDashboardController> {
  AdminDashboardScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshDashboard();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeCard(),
                  SizedBox(height: 20.h),
                  _buildStatsCards(),
                  SizedBox(height: 20.h),
                  _buildRecentOrders(),
                  SizedBox(height: 20.h),
                  _buildPopularDishes(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFF7043),
      elevation: 0,
      title: Text(
        'Quản trị hệ thống',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFFF7043),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40.sp,
                    color: const Color(0xFFFF7043),
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(() => Text(
                  authController.currentUser.value?.fullName ?? 'Admin',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                )),
                Obx(() => Text(
                  authController.currentUser.value?.email ?? 'admin@example.com',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12.sp,
                  ),
                )),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard_outlined,
            title: 'Tổng quan',
            isSelected: true,
            onTap: () => Get.back(),
          ),
          _buildDrawerItem(
            icon: Icons.restaurant_menu,
            title: 'Quản lý món ăn',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.category_outlined,
            title: 'Danh mục',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.store_outlined,
            title: 'Quản lý nhà hàng',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.person_outline,
            title: 'Người dùng',
            onTap: () => Get.toNamed(RouterName.listUser),
          ),
          _buildDrawerItem(
            icon: Icons.assignment_outlined,
            title: 'Đơn hàng',
            onTap: () {},
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Cài đặt',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.exit_to_app,
            title: 'Đăng xuất',
            onTap: () => authController.logout(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFFFF7043) : Colors.grey[700],
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: isSelected ? const Color(0xFFFF7043) : Colors.grey[800],
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: const Color(0xFFFFECE8),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7043), Color(0xFFFF5722)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7043).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
            'Xin chào, ${authController.currentUser.value?.fullName?.split(' ').last ?? 'Admin'}!',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          )),
          SizedBox(height: 8.h),
          Text(
            'Chào mừng bạn trở lại với hệ thống quản trị',
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFFF7043),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Thống kê hôm nay',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 10.w),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Xem báo cáo',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tổng quan hệ thống',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _buildStatCard(
              icon: Icons.fastfood,
              iconColor: Colors.orange,
              title: 'Tổng món ăn',
              value: '128',
            ),
            SizedBox(width: 12.w),
            _buildStatCard(
              icon: Icons.store,
              iconColor: Colors.blue,
              title: 'Nhà hàng',
              value: '24',
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _buildStatCard(
              icon: Icons.people_outline,
              iconColor: Colors.green,
              title: 'Người dùng',
              value: '1,256',
            ),
            SizedBox(width: 12.w),
            _buildStatCard(
              icon: Icons.shopping_bag_outlined,
              iconColor: Colors.purple,
              title: 'Đơn hàng',
              value: '568',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Đơn hàng gần đây',
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Xem tất cả',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFF7043),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[200]),
            itemBuilder: (context, index) {
              return _buildOrderItem(
                orderId: '#ORD-${1000 + index}',
                customerName: 'Khách hàng ${index + 1}',
                time: '30 phút trước',
                status: index % 3 == 0 ? 'Đang giao' : (index % 3 == 1 ? 'Hoàn thành' : 'Chờ xác nhận'),
                amount: '${150000 + index * 2000} VNĐ',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItem({
    required String orderId,
    required String customerName,
    required String time,
    required String status,
    required String amount,
  }) {
    Color statusColor;
    if (status == 'Hoàn thành') {
      statusColor = Colors.green;
    } else if (status == 'Đang giao') {
      statusColor = Colors.blue;
    } else {
      statusColor = Colors.orange;
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      title: Row(
        children: [
          Text(
            orderId,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                color: statusColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Row(
          children: [
            Icon(Icons.person_outline, size: 14.sp, color: Colors.grey),
            SizedBox(width: 4.w),
            Text(
              customerName,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(width: 12.w),
            Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
            SizedBox(width: 4.w),
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      trailing: Text(
        amount,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: Colors.black87,
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildPopularDishes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Món ăn phổ biến',
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Xem tất cả',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFF7043),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildPopularDishItem(
                image: 'https://via.placeholder.com/150',
                name: 'Món ăn ${index + 1}',
                price: '${80000 + index * 5000} VNĐ',
                rating: (4 + index % 2 * 0.5),
                restaurant: 'Nhà hàng ${index + 1}',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularDishItem({
    required String image,
    required String name,
    required String price,
    required double rating,
    required String restaurant,
  }) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: Image.network(
              image,
              height: 100.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  restaurant,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF7043),
                        fontSize: 13.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16.sp,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          rating.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}