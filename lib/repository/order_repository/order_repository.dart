import 'package:food_delivery_app/base/networking/api.dart';
import 'package:food_delivery_app/base/networking/api_response.dart';
import 'package:food_delivery_app/base/networking/api_response_paging.dart';
import 'package:food_delivery_app/base/networking/constants/endpoint.dart';
import 'package:food_delivery_app/models/order/order.dart';
import 'package:food_delivery_app/models/order/send_order.dart';

import '../../models/order/order_detail.dart';


class OrderRepository {
  late ApiService _service;
  
  OrderRepository({required ApiService apiService}) {
    _service = apiService;
  }

  // Lấy danh sách đơn hàng của người dùng
  Future<APIResponsePaging<List<ListOrder>>> getUserOrders({
    String page = "1",
    String limit = "10",
    String status = "",
  }) async {
    try {
      var queryParams = {
        "page": page,
        "limit": limit,
      };
      
      if (status.isNotEmpty) {
        queryParams["status"] = status;
      }

      var res = await _service.get(
        Endpoints.userOrders,
        queryParameters: queryParams,
      );

      return APIResponsePaging.fromList(
        res,
        (json) => APIResponsePaging.fromLJsonListT(
          json, (json2) => ListOrder.fromJson(json2 as Map<String, dynamic>)
        )
      );
    } catch (e) {
      print('Error fetching user orders: $e');
      throw e;
    }
  }

  // Lấy chi tiết đơn hàng
  // Add this method to your OrderRepository class if it doesn't exist
  
  Future<APIResponse<OrderDetail>> getOrderDetail(String orderId) async {
    try {
      print('Calling API to get order detail for orderId: $orderId');
      var res = await _service.get(
        '${Endpoints.orderDetail}/$orderId', // Adjust this endpoint as needed
      );
      
      print('API response for order detail: $res');
      return APIResponse.fromJson(
        res,
        (json) => OrderDetail.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      print('Error in getOrderDetail: $e');
      throw e;
    }
  }

  // Tạo đơn hàng mới
  Future<APIResponse<ListOrder>> createOrder({
    required List<Map<String, dynamic>> items,
    required String address,
    required String phoneNumber,
    String? note,
    String paymentMethod = "COD",
  }) async {
    try {
      final data = {
        "items": items,
        "address": address,
        "phoneNumber": phoneNumber,
        "paymentMethod": paymentMethod,
      };
      
      if (note != null && note.isNotEmpty) {
        data["note"] = note;
      }

      var res = await _service.post(
        Endpoints.createOrder,
        data: data,
      );

      return APIResponse.fromJson(
        res,
        (json) => ListOrder.fromJson(json as Map<String, dynamic>)
      );
    } catch (e) {
      print('Error creating order: $e');
      throw e;
    }
  }

  // Hủy đơn hàng
  Future<APIResponse<dynamic>> cancelOrder(String orderId, {String? reason}) async {
    try {
      print('/api/orders/$orderId/cancel');

      // Tạo dữ liệu gửi đi (nếu có lý do hủy)
      final data = reason != null && reason.isNotEmpty ? {"reason": reason} : null;

      var res = await _service.patch(
        '/api/orders/$orderId/cancel',
        data: data,
      );

      print(res);

      // Chỉ chuyển đổi response, không cần chuyển đổi dữ liệu thành kiểu boolean
      return APIResponse.fromJson(
          res,
              (json) => json // Giữ nguyên dữ liệu gốc thay vì chuyển thành true
      );
    } catch (e) {
      print('Error cancelling order: $e');
      throw e;
    }
  }

    // Đặt món ăn
    Future<APIResponse<List<dynamic>>> placeOrder({
      required List<Map<String, dynamic>> items,
    }) async {
      try {
        final data = {
          "data": items,
        };
    
        var res = await _service.post(
          Endpoints.createOrder,
          data: data,
        );
    
        return APIResponse.fromJson(
          res,
          (json) => json as List<dynamic>
        );
      } catch (e) {
        print('Error placing order: $e');
        throw e;
      }
    }
}