import 'package:food_delivery_app/base/networking/api.dart';
import 'package:food_delivery_app/base/networking/api_response.dart';
import 'package:food_delivery_app/base/networking/constants/endpoint.dart';
import 'package:food_delivery_app/models/dashboard/dashboard.dart';

class DashboardRepositories {
  late ApiService _service;
  DashboardRepositories({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponse<DashBoard>> getDashboard() async {
    try {
      var res = await _service.get(Endpoints.dashBoard);

      // Sử dụng fromList thay vì fromJson vì data là một mảng
      return APIResponse.fromList(res, (List<dynamic>? jsonList) {
        if (jsonList != null && jsonList.isNotEmpty) {
          return DashBoard.fromJson(jsonList[0]);
        }
        // Trả về DashBoard trống nếu danh sách rỗng
        return DashBoard();
      });

    } catch (e) {
      print('Error loading dashboard: $e');
      throw Exception('Failed to load dashboard: $e');
    }
  }

  // Get sales data by day for charts
  Future<APIResponse<List<Map<String, dynamic>>>> getSalesByDay(int month, int year) async {
    try {
      var res = await _service.get(
        '/admin/dashboard/sales-by-day',
        queryParameters: {'month': month.toString(), 'year': year.toString()}
      );

      return APIResponse.fromList(res, (List<dynamic>? jsonList) {
        if (jsonList != null) {
          return jsonList.map((item) => Map<String, dynamic>.from(item)).toList();
        }
        return <Map<String, dynamic>>[];
      });

    } catch (e) {
      print('Error loading sales by day: $e');
      throw Exception('Failed to load sales by day: $e');
    }
  }

  // Get top dishes data
  Future<APIResponse<List<Map<String, dynamic>>>> getTopDishes() async {
    try {
      var res = await _service.get('/admin/dashboard/top-dishes');

      return APIResponse.fromList(res, (List<dynamic>? jsonList) {
        if (jsonList != null) {
          return jsonList.map((item) => Map<String, dynamic>.from(item)).toList();
        }
        return <Map<String, dynamic>>[];
      });

    } catch (e) {
      print('Error loading top dishes: $e');
      throw Exception('Failed to load top dishes: $e');
    }
  }
}
