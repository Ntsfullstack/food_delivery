import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/ui/category_food_items/category_food_items.dart';
import 'package:food_delivery_app/ui/home_screen/widget/category.dart';
import 'package:food_delivery_app/ui/home_screen/widget/food_card.dart';
import 'package:food_delivery_app/ui/home_screen/widget/promo_banner.dart';
import 'package:food_delivery_app/ui/home_screen/widget/recomment_card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
            SliverToBoxAdapter(
              child: CategoriesList(
                categories: controller.categories,
                selectedCategory: controller.selectedCategory,
                onCategorySelected: controller.setSelectedCategory,
              ),
            ),
            SliverToBoxAdapter(
              child: CategoryFoodItems(controller: controller),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
                child: _buildSectionHeader('Món bán chạy', 'Xem tất cả'),
              ),
            ),
            SliverToBoxAdapter(child: _buildPopularItems()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
                child: _buildSectionHeader(
                    'Thực đơn ${controller.menuTime} nay', 'Xem thêm'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = controller.recommended[index];
                  return RecommendedCard(
                    name: item['name']!.toString(),
                    imageUrl: item['image']!.toString(),
                    price: item['price'] as double,
                    rating: item['rating'] as double,
                    onOrderNow: () {
                      Get.toNamed('/food-detail', arguments: item);
                    },
                    onTap: () {
                      Get.toNamed('/food-detail', arguments: item);
                    },
                  );
                },
                childCount: controller.recommended.length,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
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

  Widget _buildPopularItems() {
    return SizedBox(
      height: 240.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.bestSellers.length,
        itemBuilder: (context, index) {
          final item = controller.bestSellers[index];
          return FoodItemCard(
            icon: item['image']!.toString(),
            name: item['name']!.toString(),
            price: (item['price'] as double),
            rating: 4.8,
            onTap: () {},
            isFavorite: index == 0,
            useNetworkImage: true,
          );
        },
      ),
    );
  }
}
