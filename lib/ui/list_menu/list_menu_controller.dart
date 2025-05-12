import '../../base/base_controller.dart';
import '../../models/food/dishes.dart';
class ListMenuController extends BaseController {

  final RxList<Dishes> menuDishes = RxList<Dishes>([]);
  final RxBool isLoadingMenuDishes = false.obs;
  final RxInt menuCurrentPage = 1.obs;
  final RxBool hasMoreMenuDishes = true.obs;




  @override
  void onInit() {
    super.onInit();
    getMenuDishes();
  }

  Future<void> getMenuDishes({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      menuCurrentPage.value = 1;
      menuDishes.clear();
    }

    if (!hasMoreMenuDishes.value && isLoadMore) return;

    try {
      isLoadingMenuDishes.value = true;
      final response = await productRepositories.getListDishes(
        page: menuCurrentPage.value.toString(),
      );

      if (response.data?.isNotEmpty == true) {
        menuDishes.addAll(response.data!);
        menuCurrentPage.value++;
        hasMoreMenuDishes.value = response.data!.length >= 10;
      } else {
        hasMoreMenuDishes.value = false;
      }
    } catch (e) {
      print('Error fetching menu dishes: $e');
    } finally {
      isLoadingMenuDishes.value = false;
    }
  }

}