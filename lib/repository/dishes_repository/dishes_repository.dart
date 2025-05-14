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

  }) async {
    try {
      var data = {
        "page": page,
        "limit": limit,

      };

      var res = await _service.get(Endpoints.getListDishes, queryParameters: data);

      return APIResponsePaging.fromList(
          res,
              (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => Dishes.fromJson(json2 as Map<String, dynamic>)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  Future<APIResponse<Dishes>> getDetailDishes({required String dishId}) async {
    try {
      var res = await _service.get("${Endpoints.getListDishes}/$dishId");

      print('Raw dish response: $res');

      return APIResponse.fromJson(
          res,
              (json) {
            print('Parsing dish data in repository: $json');
            if (json is List && json.isNotEmpty) {
              return Dishes.fromJson(json[0] as Map<String, dynamic>);
            }
            return Dishes.fromJson(json as Map<String, dynamic>);
          }
      );
    } catch (e) {
      print('Error fetching dish details: $e');
      throw e;
    }
  }
  Future<APIResponse<Dishes>> createDish({required Dishes dish}) async {
    try {
      var data = dish.toJson();
      var res = await _service.post(
        Endpoints.createDish,
        data: data,
      );
      return APIResponse.fromJson(res, (json) => Dishes.fromJson(json));
    } catch (e) {
      print('Error creating dish: $e');
      throw e;
    }
  }
  Future <APIResponse<Dishes>> updateDish({required Dishes dish, String? imagePath}) async {
    try {
      var data = dish.toJson();
      if (imagePath != null) {
        data['image'] = imagePath;
      }
      var res = await _service.put(
        "${Endpoints.getListDishes}/${dish.id}",
        data: data,
      );
      return APIResponse.fromJson(res, (json) => Dishes.fromJson(json));
    } catch (e) {
      print('Error updating dish: $e');
      throw e;
    }
  }
}