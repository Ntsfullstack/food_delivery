import 'package:food_delivery_app/base/base_controller.dart';

import 'package:get/get.dart';
import 'package:food_delivery_app/models/food/dishes.dart';
class DishManagementController extends BaseController {
  final RxList<Dishes> dishes = <Dishes>[].obs;

  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'Tất cả'.obs;
  final RxList<String> categories = <String>['Tất cả'].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDishes();
  }

  Future<void> fetchDishes() async {
    try {
      showLoading(message: 'Đang tải dữ liệu...');
      // Lấy dữ liệu từ API
      final response = await productRepositories.getListDishes();
      
      if (response.data != null && response.data != null) {
        final res = response.data! ?? [];
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
      showError(message: 'Không thể tải danh sách món ăn: $e');
    } finally {
      hideLoading();
    }
  }

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

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> refreshDishes() async {
    await fetchDishes();
  }

  Future<void> deleteDish(String dishId) async {
    try {
      showLoading(message: 'Đang xóa món ăn...');
      await Future.delayed(const Duration(seconds: 1));
      dishes.removeWhere((dish) => dish.id.toString() == dishId);
      
      showSuccess(message: 'Xóa món ăn thành công');
    } catch (e) {
      showError(message: 'Không thể xóa món ăn: $e');
    } finally {
      hideLoading();
    }
  }
}