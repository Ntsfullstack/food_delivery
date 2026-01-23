import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/models/food/dishes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/router_name.dart';
import 'dish_management_controller.dart';

class DishManagementScreen extends GetView<DishManagementController> {
  const DishManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7043),
        elevation: 0,
        title: Text(
          'Quản lý món ăn',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          try {
            await controller.refreshDishes();
          } catch (e) {
            print('Lỗi khi làm mới: $e');
          }
        },
        child: Column(
          children: [
            _buildSearchBar(),
            // _buildCategoryFilter(),
            Expanded(
              child: Obx(() {
                // Thay thế isLoading với kiểm tra dishes.isEmpty khi đang tải
                final dishes = controller.filteredDishes;
                final isLoading = controller.dishes.isEmpty && dishes.isEmpty;

                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (dishes.isEmpty) {
                  return Center(
                    child: Text(
                      'Không tìm thấy món ăn nào',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: dishes.length,
                  itemBuilder: (context, index) {
                    return _buildDishItem(dishes[index]);
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF7043),
        child: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed(RouterName.adminDishDetail, arguments: {
            'isEdit': false,
          });
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.white,
      child: TextField(
        onChanged: controller.setSearchQuery,
        decoration: InputDecoration(
          hintText: 'Tìm kiếm món ăn...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: const Color(0xFFFF7043), width: 1.w),
          ),
        ),
      ),
    );
  }

  // Widget _buildCategoryFilter() {
  //   return Container(
  //     height: 50.h,
  //     color: Colors.white,
  //     padding: EdgeInsets.symmetric(horizontal: 16.w),
  //     child: GetBuilder<DishManagementController>(
  //       builder: (controller) {
  //         return ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: controller.categories.length,
  //           itemBuilder: (context, index) {
  //             final category = controller.categories[index];
  //             final isSelected = category == controller.selectedCategory.value;
  //
  //             return GestureDetector(
  //               onTap: () => controller.setCategory(category),
  //               child: Container(
  //                 margin: EdgeInsets.only(right: 10.w),
  //                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //                 decoration: BoxDecoration(
  //                   color: isSelected ? const Color(0xFFFF7043) : Colors.grey[100],
  //                   borderRadius: BorderRadius.circular(20.r),
  //                   border: Border.all(
  //                     color: isSelected ? const Color(0xFFFF7043) : Colors.grey[300]!,
  //                     width: 1.w,
  //                   ),
  //                 ),
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   category,
  //                   style: GoogleFonts.poppins(
  //                     color: isSelected ? Colors.white : Colors.grey[800],
  //                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
  //                     fontSize: 14.sp,
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildDishItem(Dishes dish) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
            child: Image.network(
              dish.image ?? 'https://via.placeholder.com/100',
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100.w,
                  height: 100.h,
                  color: Colors.grey[300],
                  child:
                      Icon(Icons.image_not_supported, color: Colors.grey[600]),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name ?? 'Không có tên',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    dish.categoryName ?? 'Không có danh mục',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${dish.price ?? "0"} VNĐ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFF7043),
                            fontSize: 14.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: (dish.available ?? true)
                                  ? Colors.green.withOpacity(0.12)
                                  : Colors.red.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              (dish.available ?? true) ? 'Còn món' : 'Hết món',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: (dish.available ?? true)
                                    ? Colors.green[700]
                                    : Colors.red[700],
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Switch(
                            value: dish.available ?? true,
                            onChanged: (_) =>
                                controller.toggleAvailability(dish),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue[700]),
                onPressed: () {
                  Get.toNamed(RouterName.adminDishDetail, arguments: {
                    'isEdit': true,
                    'dishId': dish.id,
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _showDeleteConfirmation(dish);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Dishes dish) {
    // Sử dụng WidgetsBinding để đảm bảo hiển thị dialog sau khi build hoàn tất
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AlertDialog(
          title: Text(
            'Xác nhận xóa',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Bạn có chắc chắn muốn xóa món "${dish.name}" không?',
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Hủy',
                style: GoogleFonts.poppins(color: Colors.grey[800]),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                // Bọc trong try-catch để tránh lỗi
                try {
                  controller.deleteDish(dish.id?.toString() ?? '');
                } catch (e) {
                  print('Lỗi khi xóa món ăn: $e');
                }
              },
              child: Text(
                'Xóa',
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    });
  }
}
