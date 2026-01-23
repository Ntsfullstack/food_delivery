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
        IconButton(
          icon: const Icon(Icons.bar_chart, color: Colors.white),
          onPressed: () => Get.toNamed(RouterName.adminReports),
          tooltip: 'Báo cáo',
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
          // In your _buildDrawer method, add these items
          _buildDrawerItem(
            icon: Icons.restaurant_menu,
            title: 'Quản lý món ăn',
            onTap: () => Get.toNamed(RouterName.dishManagement),
          ),
          _buildDrawerItem(
            icon: Icons.shopping_bag,
            title: 'Quản lý đơn hàng',
            onTap: () => Get.toNamed(RouterName.orderManagement),
          ),
          _buildDrawerItem(
            icon: Icons.receipt_long,
            title: 'Quản lý hóa đơn',
            onTap: () => Get.toNamed(RouterName.invoiceManagement),
          ),
          // _buildDrawerItem(c
          //   icon: Icons.category_outlined,
          //   title: 'Danh mục'
          //   onTap: () {},
          // ),
          _buildDrawerItem(
            icon: Icons.store_outlined,
            title: 'Quản lý đặt bàn',
            onTap: () => Get.toNamed(RouterName.bookingTableManagement),
          ),
          _buildDrawerItem(
            icon: Icons.person_outline,
            title: 'Người dùng',
            onTap: () => Get.toNamed(RouterName.listUser),
          ),
          _buildDrawerItem(
            icon: Icons.bar_chart,
            title: 'Báo cáo',
            onTap: () => Get.toNamed(RouterName.adminReports),
          ),
          // _buildDrawerItem(
          //   icon: Icons.table_rows,
          //   title: 'Đặt bàn',
          //   // onTap: () {
          //   //   Get.toNamed(RouterName.);
          //   // },
          // ),
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
            'Xin chào, ${authController.currentUser.value?.fullName.split(' ').last ?? 'Admin'}!',
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
          const Row(
            children: [
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.white,
              //     foregroundColor: const Color(0xFFFF7043),
              //     padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //     ),
              //   ),
              //   child: Text(
              //     'Thống kê hôm nay',
              //     style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              //   ),
              // ),
              // SizedBox(width: 10.w),
              // OutlinedButton(
              //   onPressed: () => controller.exportOrdersReport(),
              //   style: OutlinedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     side: const BorderSide(color: Colors.white),
              //     padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //     ),
              //   ),
              //   child: Text(
              //     'Xuất báo cáo',
              //     style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              //   ),
              // ),
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
            _buildStatCardWithObx(
              icon: Icons.fastfood,
              iconColor: Colors.orange,
              title: 'Tổng món ăn',
              valueBuilder: () => '${controller.dashboard.value.dishes?.total ?? 0}',
            ),
            SizedBox(width: 12.w),
            _buildStatCardWithObx(
              icon: Icons.attach_money,
              iconColor: Colors.blue,
              title: 'Doanh thu',
              valueBuilder: () => '${controller.getTotalRevenueToday()} VNĐ',
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _buildStatCardWithObx(
              icon: Icons.people_outline,
              iconColor: Colors.green,
              title: 'Khách hàng',
              valueBuilder: () => '${controller.dashboard.value.users?.total ?? 0}',
            ),
            SizedBox(width: 12.w),
            _buildStatCardWithObx(
              icon: Icons.shopping_bag_outlined,
              iconColor: Colors.purple,
              title: 'Đơn hàng',
              valueBuilder: () => '${controller.dashboard.value.orders?.total ?? 0}',
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _buildStatCardWithObx(
              icon: Icons.table_bar,
              iconColor: Colors.teal,
              title: 'Bàn trống',
              valueBuilder: () => '${controller.getAvailableTables()}',
            ),
            SizedBox(width: 12.w),
            _buildStatCardWithObx(
              icon: Icons.calendar_today,
              iconColor: Colors.amber,
              title: 'Đặt bàn hôm nay',
              valueBuilder: () => '${controller.getTodayReservations()}',
            ),
          ],
        ),
      ],
    );
  }

  // Thay đổi phương thức _buildStatCard thành _buildStatCardWithObx
  Widget _buildStatCardWithObx({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String Function() valueBuilder,
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
                size: 24.sp,
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
            // Chỉ wrap phần Text trong Obx
            Obx(() => Text(
              valueBuilder(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            )),
          ],
        ),
      ),
    );
  }
  //
  // Widget _buildSalesChart() {
  //   return Container(
  //     padding: EdgeInsets.all(16.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12.r),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Doanh thu theo ngày',
  //               style: GoogleFonts.poppins(
  //                 color: Colors.black87,
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 16.sp,
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 // TODO: Navigate to detailed sales report
  //               },
  //               child: Text(
  //                 'Xem chi tiết',
  //                 style: GoogleFonts.poppins(
  //                   color: const Color(0xFFFF7043),
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 12.h),
  //         Obx(() {
  //           final salesData = controller.getSalesByDay();
  //           return salesData.isEmpty
  //               ? Container(
  //                   height: 150.h,
  //                   child: Center(
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(
  //                           Icons.bar_chart_outlined,
  //                           size: 48.sp,
  //                           color: Colors.grey[400],
  //                         ),
  //                         SizedBox(height: 8.h),
  //                         Text(
  //                           'Không có dữ liệu doanh thu',
  //                           style: GoogleFonts.poppins(
  //                             color: Colors.grey[600],
  //                             fontSize: 14.sp,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               : SizedBox(
  //                   height: 150.h,
  //                   child: ListView.builder(
  //                     scrollDirection: Axis.horizontal,
  //                     itemCount: salesData.length,
  //                     itemBuilder: (context, index) {
  //                       final data = salesData[index];
  //                       final revenue = data['revenue']?.toDouble() ?? 0.0;
  //                       final date = data['date'] ?? '';
  //
  //                       return Container(
  //                         width: 80.w,
  //                         margin: EdgeInsets.only(right: 8.w),
  //                         child: Column(
  //                           children: [
  //                             Expanded(
  //                               child: Container(
  //                                 width: 40.w,
  //                                 decoration: BoxDecoration(
  //                                   color: const Color(0xFFFF7043).withOpacity(0.2),
  //                                   borderRadius: BorderRadius.circular(4.r),
  //                                 ),
  //                                 child: FractionallySizedBox(
  //                                   alignment: Alignment.bottomCenter,
  //                                   heightFactor: (revenue / 1000000).clamp(0.0, 1.0), // Normalize to max 1M
  //                                   child: Container(
  //                                     decoration: BoxDecoration(
  //                                       color: const Color(0xFFFF7043),
  //                                       borderRadius: BorderRadius.circular(4.r),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             SizedBox(height: 20.h),
  //                             Text(
  //                               '${(revenue / 1000).toStringAsFixed(0)}K',
  //                               style: GoogleFonts.poppins(
  //                                 fontSize: 10.sp,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                             SizedBox(height: 4.h),
  //                             Text(
  //                               date,
  //                               style: GoogleFonts.poppins(
  //                                 fontSize: 10.sp,
  //                                 color: Colors.grey[600],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 );
  //         }),
  //       ],
  //     ),
  //   );
  // }

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
              onPressed: () => Get.toNamed(RouterName.orderManagement),
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
          child: Obx(() {
            final recentOrders = controller.getRecentOrders();
            if (recentOrders.isEmpty) {
              return SizedBox(
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 48.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Không có đơn hàng gần đây',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentOrders.length > 5 ? 5 : recentOrders.length,
              itemBuilder: (context, index) {
                final order = recentOrders[index];
                return _buildOrderItem(
                  orderId: 'Đơn #${order['orderId'] ?? ''}',
                  customerName: order['customerName'] ?? 'Khách hàng',
                  time: order['orderDate'] ?? '',
                  status: _getStatusText(order['status'] ?? ''),
                  amount: '${order['totalPrice'] ?? 0} VNĐ',
                );
              },
            );
          }),
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
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[300]!, width: 1.w),
        borderRadius: BorderRadius.circular(12.r),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
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
              ],
            ),
            SizedBox(width: 12.w),
            Row(
              children: [
                Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
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

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return 'Chờ xử lý';
      case 'processing':
        return 'Đang xử lý';
      case 'confirmed':
        return 'Đang giao';
      case 'completed':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Đang xử lý';
    }
  }

  // Widget _buildPopularDishes() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'Món ăn phổ biến',
  //             style: GoogleFonts.poppins(
  //               color: Colors.black87,
  //               fontWeight: FontWeight.w600,
  //               fontSize: 16.sp,
  //             ),
  //           ),
  //           // TextButton(
  //           //   onPressed: () {},
  //           //   child: Text(
  //           //     'Xem tất cả',
  //           //     style: GoogleFonts.poppins(
  //           //       color: const Color(0xFFFF7043),
  //           //       fontWeight: FontWeight.w500,
  //           //     ),
  //           //   ),
  //           // ),
  //         ],
  //       ),
  //       SizedBox(height: 10.h),
  //       // Chỉ wrap phần content trong Obx
  //       Obx(() {
  //         final popularDishes = controller.getPopularDishes();
  //         return popularDishes.isEmpty
  //             ? Container(
  //           height: 200.h,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(12.r),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(0.05),
  //                 blurRadius: 8,
  //                 offset: const Offset(0, 2),
  //               ),
  //             ],
  //           ),
  //           child: Center(
  //             child: Text(
  //               'Không có món ăn phổ biến',
  //               style: GoogleFonts.poppins(
  //                 color: Colors.grey[600],
  //                 fontSize: 14.sp,
  //               ),
  //             ),
  //           ),
  //         )
  //             : SizedBox(
  //           height: 200.h,
  //           child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: popularDishes.length,
  //             itemBuilder: (context, index) {
  //               final dish = popularDishes[index];
  //               return _buildPopularDishItem(
  //                 image: dish.image ?? 'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/09/ghibli-thumb.jpg',
  //                 name: dish.dishName ?? 'Món ăn ${index + 1}',
  //                 price: '${dish.price ?? "0"} VNĐ',
  //                 rating: 4.5, // Placeholder since rating isn't in your model
  //                 restaurant: 'Nhà hàng', // Placeholder
  //               );
  //             },
  //           ),
  //         );
  //       }),
  //     ],
  //   );
  // }

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
