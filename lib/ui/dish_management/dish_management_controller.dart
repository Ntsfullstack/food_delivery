import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/food/dishes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DishManagementController extends BaseController {
  final RxList<Dishes> dishes = <Dishes>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'Tất cả'.obs;
  final RxList<String> categories = <String>['Tất cả'].obs;

  @override
  void onInit() {
    super.onInit();
    // Sử dụng WidgetsBinding để đảm bảo rằng build đã hoàn tất trước khi gọi fetchDishes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDishes();
    });
  }

  Future<void> fetchDishes() async {
    try {
      await Future.delayed(Duration.zero);

      // Lấy dữ liệu từ API
      final response = await productRepositories.getListDishes();

      if (response.data != null) {
        final res = response.data ?? [];
        dishes.value = res;

        // Lấy danh sách các danh mục
        final categorySet = <String>{'Tất cả'};
        for (var dish in res) {
          if (dish.categoryName != null) {
            categorySet.add(dish.categoryName!);
          }
        }
        categories.value = categorySet.toList();
      }
    } catch (e) {
      try {
        await Future.delayed(Duration.zero);
        showError(message: 'Không thể tải danh sách món ăn: $e');
      } catch (innerError) {
        print('Không thể hiển thị lỗi: $innerError');
      }
    }
  }

  // Sửa lại getter filteredDishes để so sánh chính xác categoryName thay vì categoryId
  List<Dishes> get filteredDishes {
    return dishes.where((dish) {
      // Lọc theo danh mục
      if (selectedCategory.value != 'Tất cả' &&
          dish.categoryName != selectedCategory.value) {
        return false;
      }

      // Lọc theo từ khóa tìm kiếm
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        final name = (dish.name ?? '').toLowerCase();
        final category = (dish.categoryName ?? '').toLowerCase();
        return name.contains(query) || category.contains(query);
      }

      return true;
    }).toList();
  }

  // Phương thức setCategory để cập nhật danh mục được chọn
  void setCategory(String category) {
    selectedCategory.value = category;
  }

  // Phương thức setSearchQuery để cập nhật từ khóa tìm kiếm
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Phương thức refreshDishes để làm mới danh sách món ăn
  Future<void> refreshDishes() async {
    await fetchDishes();
  }

  Future<void> deleteDish(String dishId) async {
    try {
      dishes.removeWhere((dish) => dish.id.toString() == dishId);
      Get.snackbar(
        'Thành công',
        'Xóa món ăn thành công',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      try {
        Get.snackbar(
          'Lỗi',
          'Không thể xóa món ăn: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } catch (innerError) {
        print('Không thể hiển thị lỗi: $innerError');
      }
    }
  }
}