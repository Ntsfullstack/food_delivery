

import '../../base/networking/api.dart';
import '../../base/networking/api_response.dart';
import '../../base/networking/constants/endpoint.dart';
import '../../models/order/booking_table.dart';

class BookingTableRepository {
  late ApiService _service;
  BookingTableRepository({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponse<BookingTable>> bookingTable({
    required String customerName,
    required String phoneNumber,
    required DateTime reservationTime,
    required int partySize,
    String? specialRequests,
    List<int>? dishID,
  }) async {
    try {
      final body = {
        "customerName": customerName,
        "phoneNumber": phoneNumber,
        "reservationTime": reservationTime.toIso8601String(),
        "partySize": partySize,
        "specialRequests": specialRequests ?? "",
        "dishID": dishID ?? [],
      };

      var res = await _service.post(Endpoints.createReservation, data: body);
      return APIResponse.fromJson(res, (dynamic json) => BookingTable.fromJson(json));
    } catch (e) {
      print('Error booking table: $e');
      throw Exception('Failed to book table: $e');
    }
  }
}