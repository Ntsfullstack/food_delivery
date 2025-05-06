import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/models/food/dishes.dart';
import 'package:flutter/widgets.dart';

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
          if (dish.category != null && dish.category!.isNotEmpty) {
            categorySet.add(dish.category!);
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

  // Thêm getter filteredDishes vì view đang sử dụng nó
  List<Dishes> get filteredDishes {
    return dishes.where((dish) {
      // Lọc theo danh mục
      if (selectedCategory.value != 'Tất cả' &&
          dish.category != selectedCategory.value) {
        return false;
      }

      // Lọc theo từ khóa tìm kiếm
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        final name = (dish.name ?? '').toLowerCase();
        final category = (dish.category ?? '').toLowerCase();
        return name.contains(query) || category.contains(query);
      }

      return true;
    }).toList();
  }

  // Thêm phương thức setCategory vì view đang sử dụng nó
  void setCategory(String category) {
    selectedCategory.value = category;
  }

  // Thêm phương thức setSearchQuery vì view đang sử dụng nó
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Thêm phương thức refreshDishes vì view đang sử dụng nó
  Future<void> refreshDishes() async {
    await fetchDishes();
  }

  Future<void> deleteDish(String dishId) async {
    try {
      await Future.delayed(Duration.zero);
      showLoading(message: 'Đang xóa món ăn...');
      await Future.delayed(const Duration(seconds: 1));
      dishes.removeWhere((dish) => dish.id.toString() == dishId);

      await Future.delayed(Duration.zero);
      showSuccess(message: 'Xóa món ăn thành công');
    } catch (e) {
      try {
        await Future.delayed(Duration.zero);
        showError(message: 'Không thể xóa món ăn: $e');
      } catch (innerError) {
        print('Không thể hiển thị lỗi: $innerError');
      }
    } finally {
      try {
        if (Get.isSnackbarOpen) {
          await Future.delayed(Duration.zero);
          hideLoading();
        }
      } catch (e) {
        print('Lỗi khi ẩn loading: $e');
      }
    }
  }
}