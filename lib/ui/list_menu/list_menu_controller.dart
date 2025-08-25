import 'package:get/get.dart';
import '../../base/base_controller.dart';
import '../../models/food/dishes.dart';
import '../../models/food/dish_categories.dart';

class ListMenuController extends BaseController {
  final RxList<Dishes> menuDishes = RxList<Dishes>([]);
  final RxBool isLoadingMenuDishes = false.obs;
  final RxInt menuCurrentPage = 1.obs;
  final RxBool hasMoreMenuDishes = true.obs;
  final Rx<DishesCategory?> selectedCategory = Rx<DishesCategory?>(null);

  @override
  void onInit() {
    super.onInit();
    // Get category from arguments
    final category = Get.arguments as DishesCategory?;
    if (category != null) {
      selectedCategory.value = category;
      getCategoryDishes(categoryId: category.id);
    }
    else {
      getCategoryDishes(categoryId: 1);
    }
  }

  Future<void> getCategoryDishes({bool isLoadMore = false, int? categoryId}) async {
    if (!isLoadMore) {
      menuCurrentPage.value = 1;
      menuDishes.clear();
    }

    if (!hasMoreMenuDishes.value && isLoadMore) return;
    final String categoryIdStr = categoryId?.toString() ?? selectedCategory.value?.id?.toString() ?? '1';
    
    try {
      isLoadingMenuDishes.value = true;
      final response = await categoryRepositories.getDishesByCategory(
        categoryId: categoryIdStr,
      );

      if (response.data?.isNotEmpty == true) {
        menuDishes.addAll(response.data!);
        menuCurrentPage.value++;
        hasMoreMenuDishes.value = response.data!.length >= 10;
      } else {
        hasMoreMenuDishes.value = false;
      }
    } catch (e) {
      print('Error fetching category dishes: $e');
    } finally {
      isLoadingMenuDishes.value = false;
    }
  }
}