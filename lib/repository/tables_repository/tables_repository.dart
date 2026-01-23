import 'package:food_delivery_app/base/networking/api_response.dart';
import 'package:food_delivery_app/base/networking/constants/endpoint.dart';
import 'package:food_delivery_app/models/table/admin_table.dart';

import '../../base/networking/api.dart';

class TablesRepository {
  late ApiService _service;
  TablesRepository({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponse<List<AdminTable>>> getAvailableTables() async {
    try {
      final res =
          await _service.get('${Endpoints.adminTables}?status=available');
      return APIResponse.fromJson(
        res,
        (json) {
          if (json is Map && json['data'] is List) {
            return (json['data'] as List)
                .map((e) => AdminTable.fromJson(e))
                .toList();
          }
          if (json is List) {
            return json.map((e) => AdminTable.fromJson(e)).toList();
          }
          return <AdminTable>[];
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<APIResponse<dynamic>> createTable({
    required int tableNumber,
    required int capacity,
    String status = 'available',
  }) async {
    try {
      final res = await _service.post(
        Endpoints.adminTables,
        data: {
          'tableNumber': tableNumber,
          'capacity': capacity,
          'status': status,
        },
      );
      return APIResponse.fromJson(res, (json) => json);
    } catch (e) {
      rethrow;
    }
  }
}
