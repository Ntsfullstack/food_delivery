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

  Future<APIResponsePaging<List<ListDishes>>> getListDishes({
    String page = "1",
    String limit = "10",

  }) async {
    try {
      var data = {
        "page": page,
        "limit": limit,

      };

      var res = await _service.get(Endpoints.getListDishes, queryParameters: data);

      return APIResponsePaging.fromList(
          res,
              (json) => APIResponse.fromLJsonListT(
              json,
                  (json2) {
                    // Debug individual dish data
                    print('Parsing dish data: $json2');
                    return ListDishes.fromMap(json2 as Map<String, dynamic>);
                  }
          )
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  Future<APIResponse<ListDishes>> getDetailDishes({required String dishId}) async {
    try {
      // Gọi API để lấy dữ liệu chi tiết món ăn
      var res = await _service.get("${Endpoints.getListDishes}/$dishId");

      // Debug response
      print('Raw dish response: $res');

      // Trả về đối tượng APIResponse chứa ListDishes
      return APIResponse.fromJson(
          res,
              (json) {
            print('Parsing dish data in repository: $json');
            return ListDishes.fromMap(json as Map<String, dynamic>);
          }
      );
    } catch (e) {
      print('Error fetching dish details: $e');
      throw e;
    }
  }
}