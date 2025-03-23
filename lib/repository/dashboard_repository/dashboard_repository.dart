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
        // Lấy phần tử đầu tiên trong danh sách (nếu có)
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
}
