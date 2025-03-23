import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'food_detail_controller.dart';

class FoodDetailScreen extends GetView<FoodDetailController> {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          // Show loading indicator
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF7043)),
            );
          }

          // Show error message if dish is null
          if (controller.dish.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60.sp, color: Colors.grey),
                  SizedBox(height: 16.h),
                  Text(
                    'Không tìm thấy thông tin món ăn',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7043),
                    ),
                    child: Text(
                      'Quay lại',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          // Get dish data
          final dish = controller.dish.value!;

          // Main UI
          return Stack(
            children: [
              // Scrollable content
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Food image
                  SliverAppBar(
                    expandedHeight: 350.h,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: 'food_${dish.dishId ?? ''}',
                        child: CachedNetworkImage(
                          imageUrl: dish.imageUrl ?? 'https://via.placeholder.com/800x600?text=No+Image',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(color: Color(0xFFFF7043)),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.error)),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Food details
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header (Food name and basic info)
                          Padding(
                            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dish.name ?? 'Không có tên',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF303030),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_fire_department_rounded,
                                      size: 18.sp,
                                      color: Colors.orange[400],
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      '${210 + ((dish.name?.length ?? 0) % 4) * 50} Calories',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: 18.sp,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      '15-30 phút',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Rating section
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4CAF50),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        dish.rating ?? "4.8",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  '${124 + ((dish.name?.length ?? 0) % 10) * 10} đánh giá',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Obx(() => Text(
                                  '${controller.getTotalPrice().toStringAsFixed(1)}K',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFFF7043),
                                  ),
                                )),
                              ],
                            ),
                          ),

                          // Description section
                          if (dish.description != null && dish.description!.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mô tả',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF303030),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    dish.description!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Category section
                          if (dish.category != null && dish.category!.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Danh mục',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF303030),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      dish.category!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Size options
                          if (dish.sizes != null && dish.sizes!.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Chọn kích cỡ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF303030),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Row(
                                      children: dish.sizes!.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        final size = entry.value;
                                        final price = size.price;
                                        final sizeName = size.sizeName ?? 'Size ${index + 1}';

                                        return Obx(() {
                                          final isSelected = controller.selectedSizeIndex.value == index;
                                          return GestureDetector(
                                            onTap: () => controller.selectSize(index),
                                            child: Container(
                                              margin: EdgeInsets.only(right: 12.w),
                                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                                              decoration: BoxDecoration(
                                                color: isSelected ? const Color(0xFFFF7043) : Colors.white,
                                                borderRadius: BorderRadius.circular(12.r),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? const Color(0xFFFF7043)
                                                      : Colors.grey[300]!,
                                                ),
                                              ),
                                              child: Text(
                                                '$sizeName (${price != null ? (price / 1000).toStringAsFixed(0) + 'K' : 'N/A'})',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: isSelected ? Colors.white : Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          SizedBox(height: 100.h), // Space for bottom bar
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Back button
              Positioned(
                top: 20.h,
                left: 20.w,
                child: InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: const Color(0xFF303030),
                      size: 20.sp,
                    ),
                  ),
                ),
              ),

              // Favorite button
              Positioned(
                top: 20.h,
                right: 20.w,
                child: Obx(() => InkWell(
                  onTap: () => controller.toggleFavorite(),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      controller.isFavorite.value
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: controller.isFavorite.value
                          ? const Color(0xFFFF5252)
                          : const Color(0xFF9E9E9E),
                      size: 20.sp,
                    ),
                  ),
                )),
              ),

              // Bottom bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 120.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(() => IconButton(
                              icon: Icon(
                                Icons.remove,
                                size: 20.sp,
                                color: controller.quantity.value > 1
                                    ? const Color(0xFF303030)
                                    : Colors.grey[400],
                              ),
                              onPressed: () => controller.decreaseQuantity(),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            )),
                            Obx(() => Text(
                              controller.quantity.value.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF303030),
                              ),
                            )),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 20.sp,
                                color: const Color(0xFF303030),
                              ),
                              onPressed: () => controller.increaseQuantity(),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Obx(() => ElevatedButton(
                          onPressed: () => controller.addToCart(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF7043),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'THÊM VÀO GIỎ - ',
                                style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '${controller.getTotalPrice().toStringAsFixed(1)}K',
                                style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}