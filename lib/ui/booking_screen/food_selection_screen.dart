import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_controller.dart';
import '../../models/food/dishes.dart';
import 'confirm_booking_screen.dart';

class FoodSelectionScreen extends GetView<TableBookingController> {
  const FoodSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize by fetching dishes when the screen builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getListDishesByCategory(categoryId: 3);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Chọn món ăn',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Danh sách món ăn', Icons.restaurant_menu),
                    SizedBox(height: 16.h),
                    _buildDishesList(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.r,
          color: const Color(0xFFFF7043),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF303030),
          ),
        ),
      ],
    );
  }

  Widget _buildDishesList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Obx(() {
        if (controller.categoryDishes.isEmpty) {
          return Center(
            child: Container(
              height: 100.h,
              alignment: Alignment.center,
              child: Text(
                'Không có món ăn nào',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFECE8),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'Đã chọn: ${controller.selectedDishes.length} món',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFF7043),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(12.r),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 12.h,
              ),
              itemCount: controller.categoryDishes.length,
              itemBuilder: (context, index) {
                final dish = controller.categoryDishes[index];
                return _buildDishGridItem(dish);
              },
            ),
            SizedBox(height: 12.h),
          ],
        );
      }),
    );
  }

  Widget _buildDishGridItem(Dishes dish) {
    return Obx(() {
      final isSelected = controller.selectedDishes.contains(dish.id);
      return InkWell(
        onTap: () => controller.toggleDishSelection(dish.id),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? const Color(0xFFFF7043) : Colors.grey[200]!,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dish Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: dish.image != null && dish.image!.isNotEmpty
                          ? Image.network(
                              dish.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 32.r,
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.restaurant,
                                size: 32.r,
                                color: Colors.grey[400],
                              ),
                            ),
                    ),
                  ),
                  // Selection Indicator
                  Positioned(
                    top: 8.r,
                    right: 8.r,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected ? const Color(0xFFFF7043) : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFF7043),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
              // Dish Info
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF303030),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // if (dish.description != null) ...[
                    //   SizedBox(height: 4.h),
                    //   Text(
                    //     dish.description!,
                    //     style: GoogleFonts.poppins(
                    //       fontSize: 12.sp,
                    //       color: Colors.grey[600],
                    //     ),
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ],
                    Text(
                      '${dish.price?.toStringAsFixed(0) ?? '0'}đ',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFF7043),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const ConfirmBookingScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7043),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Tiếp tục',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 