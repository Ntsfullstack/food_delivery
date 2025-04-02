import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_app/ui/home_screen/widget/category.dart';
import 'package:food_delivery_app/ui/home_screen/widget/food_card.dart';
import 'package:food_delivery_app/ui/home_screen/widget/promo_banner.dart';
import 'package:food_delivery_app/ui/home_screen/widget/recomment_card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router_name.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xFFF8F9FA),
              floating: true,
              pinned: false,
              elevation: 0,
              expandedHeight: 120.h,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildHeader(),
              ),
            ),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(
              child: PromoBanner(
                banners: controller.banners,
                onPageChanged: controller.setBannerIndex,
                currentBannerIndex: controller.currentBannerIndex,
                onOrderNow: () {
                  // Handle the Order Now button tap
                  final currentBanner =
                  controller.banners[controller.currentBannerIndex.value];
                  Get.toNamed('/promo-details', arguments: currentBanner);
                },
              ),
            ),
            // Categories section
            SliverToBoxAdapter(
              child: Obx(() {
                // Show loading indicator while categories are loading
                if (controller.isLoadingCategories.value) {
                  return SizedBox(
                    height: 110.h,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF7043),
                      ),
                    ),
                  );
                }
                final List<Map<String, dynamic>> categoryList = [];
                for (var category in controller.apiCategories) {
                  categoryList.add({
                    'name': category.name ?? 'Không tên',
                    'id': category.id
                  });
                }
                return CategoriesList(
                  categories: categoryList,
                  selectedCategory: controller.selectedCategory,
                  onCategorySelected: controller.setSelectedCategory,
                );
              }),
            ),
            
            // Popular items section
            // Cập nhật phần "Món theo danh mục"
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
                child: _buildSectionHeader('Món theo danh mục', 'Xem tất cả'),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.isLoadingCategoryDishes.value) {
                  return SizedBox(
                    height: 240.h,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF7043),
                      ),
                    ),
                  );
                }

                // Lấy 5 món đầu tiên từ danh sách món ăn theo danh mục
                final displayDishes = controller.categoryDishes.take(5).toList();

                if (displayDishes.isEmpty) {
                  return SizedBox(
                    height: 240.h,
                    child: Center(
                      child: Text(
                        'Không có món ăn trong danh mục này',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 240.h,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: displayDishes.length,
                    itemBuilder: (context, index) {
                      final dish = displayDishes[index];
                      return FoodItemCard(
                        icon: dish.image ?? '',
                        name: dish.name ?? 'Không tên',
                        price: dish.price != null ? double.tryParse(dish.price.toString()) ?? 0.0 : 0.0,
                        rating: dish.rating ?? 4.5,
                        onTap: () {
                          Get.toNamed(RouterName.foodDetail, arguments: dish.id);
                        },
                        useNetworkImage: true,
                      );
                    },
                  ),
                );
              }),
            ),

// Cập nhật phần "Thực đơn trưa/tối"
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
                child: _buildSectionHeader(
                    'Thực đơn ${controller.menuTime}', 'Xem thêm'),
              ),
            ),
            Obx(() => controller.isLoadingMenuDishes.value
                ? const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFF7043),
                ),
              ),
            )
                : SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final dish = controller.menuDishes[index];
                  return RecommendedCard(
                    dish: dish,
                    onTap: () {
                      print('Tapped on dish: ${dish.id} - ${dish.name}');
                      Get.toNamed(RouterName.foodDetail, arguments: dish.id);
                    },
                  );
                },
                childCount: controller.menuDishes.length,
              ),
            )),

          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        controller.greeting.value,
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF303030),
                        ),
                      )),
                  SizedBox(height: 4.h),
                  Obx(() => Text(
                        controller.subGreeting.value.isEmpty
                            ? 'Bạn đang đói phải không?'
                            : controller.subGreeting.value,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
              const Spacer(),
              _buildHeaderButton(Icons.notifications_none_rounded, true),
              SizedBox(width: 12.w),
              _buildHeaderButton(Icons.shopping_cart_outlined, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, bool hasNotification) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: const Color(0xFF303030),
          ),
        ),
        if (hasNotification)
          Positioned(
            right: 8.r,
            top: 8.r,
            child: Container(
              width: 8.r,
              height: 8.r,
              decoration: const BoxDecoration(
                color: Color(0xFFFF5252),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 55.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded,
                      color: Colors.grey[500], size: 22.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: 'Tìm món ăn, nhà hàng...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => controller.searchText.value = value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? viewAllText) {
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
        if (viewAllText != null)
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50.w, 30.h),
            ),
            child: Row(
              children: [
                Text(
                  viewAllText,
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

  // Cập nhật phương thức setSelectedCategory trong HomeController để gọi đúng hàm
}
