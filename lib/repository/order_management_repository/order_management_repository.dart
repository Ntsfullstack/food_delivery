import 'package:food_delivery_app/base/networking/api_response_paging.dart';
import 'package:food_delivery_app/models/order/order_detail.dart';
import 'package:food_delivery_app/base/networking/api.dart';
import 'package:food_delivery_app/base/networking/constants/endpoint.dart';
import 'package:dio/dio.dart';

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
          (json) => APIResponsePaging.fromLJsonListT(
              json, (json2) => OrderManagement.fromJson(json2 as Map<String, dynamic>)));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<OrderDetail> getOrderDetail(String orderId) async {
    try {
      final response = await _service.get('${Endpoints.adminOrderDetail}/$orderId');
      // API returns an array with one order object, so we take the first element
      if (response['data'] is List && (response['data'] as List).isNotEmpty) {
        return OrderDetail.fromJson((response['data'] as List).first);
      }
      throw Exception('Order not found');
    } catch (e) {
      print('Error getting order detail: $e');
      rethrow;
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _service.patch(
        '${Endpoints.adminOrderDetail}/$orderId/status',
        data: {'status': status},
      );
    } catch (e) {
      print('Error updating order status to $status: $e');
      rethrow;
    }
  }

  // Export orders report to CSV
  Future<void> exportOrdersReport(DateTime from, DateTime to) async {
    try {
      await _service.get(
        '/admin/reports/orders',
        queryParameters: {
          'from': from.toIso8601String(),
          'to': to.toIso8601String(),
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Accept': 'text/csv',
          },
        ),
      );
    } catch (e) {
      print('Error exporting orders report: $e');
      rethrow;
    }
  }

  Future<void> pendingOrder(String orderId) => updateOrderStatus(orderId, 'pending');
  Future<void> processOrder(String orderId) => updateOrderStatus(orderId, 'processing');
  Future<void> confirmOrder(String orderId) => updateOrderStatus(orderId, 'confirmed');
  Future<void> completeOrder(String orderId) => updateOrderStatus(orderId, 'completed');
  Future<void> cancelOrder(String orderId) => updateOrderStatus(orderId, 'cancelled');
}