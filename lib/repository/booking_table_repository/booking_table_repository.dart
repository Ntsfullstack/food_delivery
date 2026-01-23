import '../../base/networking/api.dart';
import '../../base/networking/api_response.dart';
import '../../base/networking/constants/endpoint.dart';
import '../../models/order/booking_table.dart';

class BookingTableRepository {
  late ApiService _service;
  BookingTableRepository({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponse<TableBooking>> tableBooking({
    required String customerName,
    required String phoneNumber,
    required DateTime reservationTime,
    required int partySize,
    String? specialRequests,
    List<int>? dishID,
    List<Map<String, dynamic>>? orderedItems,
  }) async {
    try {
      final items = orderedItems ??
          (dishID ?? [])
              .map((id) => {
                    'dishId': id,
                    'quantity': 1,
                  })
              .toList();

      final body = {
        "customerName": customerName,
        "phoneNumber": phoneNumber,
        "reservationTime": reservationTime.toIso8601String(),
        "partySize": partySize,
        "specialRequests": specialRequests ?? "",
        "orderedItems": items,
      };

      var res = await _service.post(Endpoints.createReservation, data: body);
      return APIResponse.fromJson(
          res, (dynamic json) => TableBooking.fromJson(json));
    } catch (e) {
      print('Error booking table: $e');
      throw Exception('Failed to book table: $e');
    }
  }
}
