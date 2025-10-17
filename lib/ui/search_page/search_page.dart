import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/search_page/search_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_delivery_app/ui/home_screen/widget/recomment_card.dart';
import 'package:food_delivery_app/routes/router_name.dart';

class SearchPage extends GetView<SearchScreenController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header with search bar
            _buildSearchHeader(),

   

            // Search results
            Expanded(
              child: Obx(() {
                if (controller.loading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFF7043),
                    ),
                  );
                }

                if (controller.searchText.value.isEmpty) {
                  return _buildEmptyState();
                }

                if (controller.filteredDishes.isEmpty) {
                  return _buildNoResultsState();
                }

                return _buildSearchResults();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(10.r),
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
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: const Color(0xFF303030),
              ),
            ),
          ),

          SizedBox(width: 16.w),

          // Search bar
          Expanded(
            child: Container(
              height: 55.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: Colors.grey[500],
                    size: 22.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      controller: controller.searchTextController,
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm món ăn...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => controller.onSearchChanged(value),
                    ),
                  ),
                  Obx(() {
                    if (controller.searchText.value.isNotEmpty) {
                      return GestureDetector(
                        onTap: () => controller.clearSearch(),
                        child: Icon(
                          Icons.clear_rounded,
                          color: Colors.grey[500],
                          size: 20.sp,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilters() {
    return Obx(() {
      if (controller.categories.isEmpty) return const SizedBox.shrink();

      return Container(
        height: 50.h,
        margin: EdgeInsets.only(bottom: 16.h),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final isSelected = controller.selectedCategoryFilter.value == index;

            return GestureDetector(
              onTap: () => controller.setSelectedCategoryFilter(index),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFF7043) : Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFFF7043) : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    category['name'],
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xFF303030),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 80.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 24.h),
          Text(
            'Tìm kiếm món ăn yêu thích',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Nhập tên món ăn để bắt đầu tìm kiếm',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),

          // Recent searches or popular dishes
          Obx(() {
            if (controller.recentSearches.isNotEmpty) {
              return _buildRecentSearches();
            }
            return _buildPopularDishes();
          }),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tìm kiếm gần đây',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF303030),
                ),
              ),
              TextButton(
                onPressed: () => controller.clearRecentSearches(),
                child: Text(
                  'Xóa tất cả',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: const Color(0xFFFF7043),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        ...controller.recentSearches.take(5).map((search) =>
            ListTile(
              leading: Icon(Icons.history, color: Colors.grey[400], size: 20.sp),
              title: Text(
                search,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: const Color(0xFF303030),
                ),
              ),
              trailing: GestureDetector(
                onTap: () => controller.removeRecentSearch(search),
                child: Icon(Icons.close, color: Colors.grey[400], size: 18.sp),
              ),
              onTap: () => controller.searchTextController.text = search,
            ),
        ).toList(),
      ],
    );
  }

  Widget _buildPopularDishes() {
    return Obx(() {
      if (controller.popularDishes.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Món ăn phổ biến',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF303030),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          ...controller.popularDishes.take(3).map((dish) =>
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    dish.image ?? '',
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40.w,
                      height: 40.h,
                      color: Colors.grey[200],
                      child: Icon(Icons.restaurant, color: Colors.grey[400]),
                    ),
                  ),
                ),
                title: Text(
                  dish.name ?? 'Không tên',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: const Color(0xFF303030),
                  ),
                ),
                subtitle: Text(
                  '${dish.price?.toStringAsFixed(0) ?? '0'}đ',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: const Color(0xFFFF7043),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => Get.toNamed(RouterName.foodDetail, arguments: dish.id),
              ),
          ).toList(),
        ],
      );
    });
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 24.h),
          Text(
            'Không tìm thấy kết quả',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF303030),
            ),
          ),
          SizedBox(height: 8.h),
          Obx(() => Text(
            'Không có món ăn nào phù hợp với "${controller.searchText.value}"',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          )),
          SizedBox(height: 24.h),
          Text(
            'Thử tìm kiếm với từ khóa khác',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Obx(() {
      return ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: controller.filteredDishes.length,
        itemBuilder: (context, index) {
          final dish = controller.filteredDishes[index];
          return RecommendedCard(
            dish: dish,
            onTap: () {
              controller.addToRecentSearches(controller.searchText.value);
              Get.toNamed(RouterName.foodDetail, arguments: dish.id);
            },
          );
        },
      );
    });
  }
}