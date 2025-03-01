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
        child: Stack(
          children: [
            // Scrollable content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Food image
                _buildFoodImage(),

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
                        _buildHeader(),
                        _buildRatingSection(),
                        _buildDescription(),
                        _buildIngredients(),
                        _buildSizeOptions(),
                        _buildAddOns(),
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
              child: _buildBackButton(),
            ),

            // Favorite button
            Positioned(
              top: 20.h,
              right: 20.w,
              child: _buildFavoriteButton(),
            ),

            // Bottom bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodImage() {
    return SliverAppBar(
      expandedHeight: 350.h,
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag:
              'food_${controller.foodItem['name'].toString().toLowerCase().replaceAll(' ', '_')}',
          child: CachedNetworkImage(
            imageUrl: controller.foodItem['image'].toString(),
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
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.foodItem['name'].toString(),
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
                '${210 + (controller.foodItem['name'].toString().length % 4) * 50} Calories',
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
                '${15 + (controller.foodItem['name'].toString().length % 3) * 5}-30 phút',
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
    );
  }

  Widget _buildRatingSection() {
    return Padding(
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
                  controller.foodItem.containsKey('rating')
                      ? controller.foodItem['rating'].toString()
                      : "4.8",
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
            '${124 + (controller.foodItem['name'].toString().length % 10) * 10} đánh giá',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            '\$${controller.foodItem['price'].toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFFF7043),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
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
            controller.getDescription(),
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thành phần',
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
              children:
                  controller.getIngredients().asMap().entries.map((entry) {
                final ingredient = entry.value;
                return Container(
                  width: 80.w,
                  margin: EdgeInsets.only(right: 12.w),
                  child: Column(
                    children: [
                      Container(
                        width: 70.w,
                        height: 70.w,
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Icon(
                          _getIngredientIcon(ingredient['icon'] ?? ''),
                          color: const Color(0xFFFF7043),
                          size: 32.r,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        ingredient['name'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIngredientIcon(String iconName) {
    switch (iconName) {
      case 'meat.png':
        return Icons.kebab_dining;
      case 'noodles.png':
        return Icons.ramen_dining;
      case 'green_onion.png':
        return Icons.eco;
      case 'bean_sprouts.png':
        return Icons.spa;
      case 'spices.png':
        return Icons.soup_kitchen;
      case 'patty.png':
        return Icons.lunch_dining;
      case 'bun.png':
        return Icons.bakery_dining;
      case 'cheese.png':
        return Icons.egg_alt;
      case 'lettuce.png':
        return Icons.eco;
      case 'tomato.png':
        return Icons.circle;
      default:
        return Icons.restaurant;
    }
  }

  Widget _buildSizeOptions() {
    return Padding(
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
          Row(
            children: controller.sizes.asMap().entries.map((entry) {
              final index = entry.key;
              final size = entry.value;

              return Obx(() {
                final isSelected = controller.selectedSizeIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.selectSize(index),
                  child: Container(
                    margin: EdgeInsets.only(right: 12.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFFFF7043) : Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFFF7043)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Text(
                      size['name'].toString(),
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
        ],
      ),
    );
  }

  Widget _buildAddOns() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thêm món',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 16.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.addOns.length,
            itemBuilder: (context, index) {
              final addOn = controller.addOns[index];
              return Obx(() {
                final isSelected = controller.selectedAddOns.contains(index);
                return GestureDetector(
                  onTap: () => controller.toggleAddOn(index),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFFF7043)
                            : Colors.grey[200]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Icon(
                              addOn['icon'] as IconData?,
                              color: const Color(0xFFFF7043),
                              size: 24.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addOn['name'].toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF303030),
                                ),
                              ),
                              Text(
                                '+\$${(addOn['price'] as num).toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: isSelected,
                          onChanged: (_) => controller.toggleAddOn(index),
                          activeColor: const Color(0xFFFF7043),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
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
    );
  }

  Widget _buildFavoriteButton() {
    return Obx(() => InkWell(
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
        ));
  }

  Widget _buildBottomBar() {
    return Container(
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
                        '\$${controller.getTotalPrice().toStringAsFixed(2)}',
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
    );
  }
}
