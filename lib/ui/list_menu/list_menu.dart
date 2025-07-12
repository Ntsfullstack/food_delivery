import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router_name.dart';
import '../home_screen/widget/recomment_card.dart';
import 'list_menu_controller.dart';

class ListMenu extends GetView<ListMenuController> {
  const ListMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(() => Text(
          controller.selectedCategory.value?.name ?? 'Thực đơn',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        )),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20.sp),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoadingMenuDishes.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF7043),
            ),
          );
        }

        if (controller.menuDishes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  size: 48.r,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Không có món ăn nào',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.r),
          itemCount: controller.menuDishes.length,
          itemBuilder: (context, index) {
            final dish = controller.menuDishes[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: RecommendedCard(
                dish: dish,
                onTap: () {
                  Get.toNamed(RouterName.foodDetail, arguments: dish.id);
                },
              ),
            );
          },
        );
      }),
    );
  }
}