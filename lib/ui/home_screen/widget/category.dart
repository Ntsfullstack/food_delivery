import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesList extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final RxInt selectedCategory;
  final Function(int) onCategorySelected;
  final String? title;

  const CategoriesList({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.title = 'Danh mục',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> categoryColors = [
      const Color(0xFFFFCDD2),
      const Color(0xFFBBDEFB),
      const Color(0xFFC8E6C9),
      const Color(0xFFFFE0B2),
      const Color(0xFFE1BEE7),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
            child: _buildSectionHeader(title!),
          ),
        SizedBox(
          height: 110.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final color = categoryColors[index % categoryColors.length];
              return Obx(() {
                final isSelected = selectedCategory.value == index;
                return GestureDetector(
                  onTap: () => onCategorySelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 90.w,
                    margin: EdgeInsets.only(right: 14.w),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFFFF7043) : Colors.white,
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? const Color(0xFFFF7043).withOpacity(0.3)
                              : Colors.grey.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50.r,
                          height: 50.r,
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.25)
                                : color.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.r),
                            child: category.containsKey('icon') &&
                                    category['icon'] != null
                                ? CachedNetworkImage(
                                    imageUrl: category['icon']!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: color.withOpacity(0.3),
                                      child: Center(
                                        child: SizedBox(
                                          width: 20.r,
                                          height: 20.r,
                                          child: CircularProgressIndicator(
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(0xFFFF7043),
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        _buildCategoryIcon(
                                            isSelected,
                                            category['name']?.toString() ?? '',
                                            color),
                                  )
                                : _buildCategoryIcon(isSelected,
                                    category['name']?.toString() ?? '', color),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          category['name']?.toString() ?? '',
                          style: GoogleFonts.poppins(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF303030),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryIcon(
      bool isSelected, String categoryName, Color defaultColor) {
    IconData iconData = Icons.restaurant_rounded;

    // Map category names to appropriate icons
    if (categoryName.toLowerCase().contains('bánh mì') ||
        categoryName.toLowerCase().contains('banh mi')) {
      iconData = Icons.breakfast_dining;
    } else if (categoryName.toLowerCase().contains('nước') ||
        categoryName.toLowerCase().contains('nuoc')) {
      iconData = Icons.local_drink;
    } else if (categoryName.toLowerCase().contains('khai vị')) {
      iconData = Icons.tapas;
    } else if (categoryName.toLowerCase().contains('xôi') ||
        categoryName.toLowerCase().contains('xoi')) {
      iconData = Icons.rice_bowl;
    } else if (categoryName.toLowerCase().contains('bao')) {
      iconData = Icons.bakery_dining;
    }

    return Container(
      color: defaultColor.withOpacity(0.3),
      child: Center(
        child: Icon(
          iconData,
          color: isSelected ? Colors.white : const Color(0xFFFF7043),
          size: 24.r,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF303030),
          ),
        ),
      ],
    );
  }
}
