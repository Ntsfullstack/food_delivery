import '../../base/networking/api.dart';
import '../../base/networking/api_response.dart';
import '../../base/networking/api_response_paging.dart';
import '../../base/networking/constants/endpoint.dart';
import '../../models/food/dishes.dart';

class ProductRepositories {
  late ApiService _service;

  ProductRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponsePaging<List<Dishes>>> getListDishes({
    String page = "1",
    String limit = "10",
    String sortBy = "Price",
    String sortOrder = "DESC",
    String category = "",
    String search = ""
  }) async {
    try {
      var data = {
        "page": page,
        "limit": limit,
        "sortBy": sortBy,
        "sortOrder": sortOrder,
        "category": category,
        "search": search
      };

      var res = await _service.get(Endpoints.getListDishes, queryParameters: data);

      return APIResponsePaging.fromList(
          res,
              (json) => APIResponse.fromLJsonListT(
              json,
                  (json2) => Dishes.fromJson(json2 as Map<String, dynamic>)
          )
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}