import '../../base/networking/api.dart';
import '../../base/networking/api_response.dart';
import '../../base/networking/api_response_paging.dart';
import '../../base/networking/constants/endpoint.dart';
import '../../models/food/dish_categories.dart';
import '../../models/food/dishes.dart';

class CategoryRepositories {
  late ApiService _service;

  CategoryRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponse<List<DishesCategory>>> getListCategories() async {
    try {
      var res = await _service.get(Endpoints.listCategories);

      return APIResponse.fromList(
          res,
              (List<dynamic>? jsonList) {
            if (jsonList == null) return <DishesCategory>[];
            return jsonList.map((item) => DishesCategory.fromJson(item)).toList();
          }
      );
    } catch (e) {
      print("Error getting categories: ${e.toString()}");
      throw e;
    }
  }

  Future<APIResponsePaging<List<Dishes>>> getDishesByCategory({
    required String categoryId,
  }) async {
    try {
      var res = await _service.get(
          "${Endpoints.listDishesByCategory}/$categoryId",
      );

      return APIResponsePaging.fromJson(
          res,
              (json) => List<Dishes>.from(
              (json as List).map((item) => Dishes.fromJson(item))));
    } catch (e) {
      print("Error getting dishes by category: ${e.toString()}");
      throw e;
    }
  }
}