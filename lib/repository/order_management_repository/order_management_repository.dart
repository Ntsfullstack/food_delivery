import 'package:dio/dio.dart';
import 'package:food_delivery_app/base/networking/api_response_paging.dart';
import 'package:food_delivery_app/models/users/users.dart';
import 'package:food_delivery_app/base/networking/api.dart';
import 'package:food_delivery_app/base/networking/constants/endpoint.dart';

import '../../models/order_managerment/order_managerment.dart';

class OrderManagementRepository {
  late ApiService _service;
  OrderManagementRepository({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponsePaging<List<OrderManagement>>> getListOrder({
    String page = "1",
    String limit = "10",

  }) async {
    try {
      var data = {
        "page": page,
        "limit": limit,

      };

      var res = await _service.get(
          Endpoints.listOrders, queryParameters: data);

      return APIResponsePaging.fromList(
          res,
              (json) =>
              APIResponsePaging.fromLJsonListT(
                  json, (json2) =>
                  OrderManagement.fromJson(json2 as Map<String, dynamic>)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}