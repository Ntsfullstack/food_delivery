import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/home_screen/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryFoodItems extends StatelessWidget {
  final HomeController controller;

  const CategoryFoodItems({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get filtered items based on selected category
      final filteredItems = controller.getFilteredItems();

      // If no items found for this category
      if (filteredItems.isEmpty) {
        return _buildEmptyState();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
            child: _buildSectionHeader(),
          ),
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
            ),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return _buildFoodCard(item);
            },
          ),
          SizedBox(height: 20.h),
        ],
      );
    });
  }

  Widget _buildSectionHeader() {
    // Get current category name
    String categoryName = controller.categories.isEmpty
        ? 'Tất cả'
        : controller.categories[controller.selectedCategory.value]['name']
            .toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Món $categoryName',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF303030),
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(50.w, 30.h),
          ),
          child: Row(
            children: [
              Text(
                'Xem tất cả',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFF7043),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: const Color(0xFFFF7043),
                size: 18.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoodCard(Map<String, dynamic> item) {
    // Extract values with null safety
    final String name = item['name']?.toString() ?? 'Unnamed Item';
    final String imageUrl = item['image']?.toString() ?? '';

    // Handle null price with a default value
    final double price =
        item['price'] != null ? (item['price'] as num).toDouble() : 0.0;

    // Handle null rating with a default value
    final double rating =
        item['rating'] != null ? (item['rating'] as num).toDouble() : 4.0;

    return GestureDetector(
      onTap: () {
        Get.toNamed('/food-detail', arguments: item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                  child: imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFF7043),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.error, color: Colors.grey[400]),
                          ),
                        )
                      : Container(
                          height: 120.h,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey[400]),
                        ),
                ),

                // Rating badge
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 12.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          rating.toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Favorite button
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.grey[400],
                      size: 16.sp,
                    ),
                  ),
                ),
              ],
            ),

            // Food details
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF303030),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${price.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF7043),
                        ),
                      ),
                      Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF7043), Color(0xFFFF5722)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF7043).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 80.sp,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16.h),
            Text(
              'Không tìm thấy món ăn',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF303030),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Hiện tại danh mục này chưa có món ăn nào',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
