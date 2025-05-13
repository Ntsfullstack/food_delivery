import 'package:food_delivery_app/base/networking/api_response.dart';

import 'package:food_delivery_app/base/networking/constants/endpoint.dart';
import 'package:food_delivery_app/models/order/booking_table.dart';

import '../../base/networking/api.dart';

class BookingHistoryRepository  {
  late ApiService _service;
  BookingHistoryRepository({required ApiService apiService}) {
    _service = apiService;
  }
  Future<APIResponse<List<TableBooking>>> getBookingHistory() async {
    try {
      var res = await _service.get(Endpoints.bookingHistory);

      return APIResponse.fromJson(
        res,
        (json) {
          if (json is List) {
            return json.map((item) => TableBooking.fromJson(item)).toList();
          }
          return <TableBooking>[];
        },
      );
    } catch (e) {
      print('Error fetching booking history: $e');
      throw e;
    }
  }

  Future<APIResponse<TableBooking>> getBookingDetail(int bookingId) async {
    try {
      var res = await _service.get('${Endpoints.bookingDetail}/$bookingId');

      return APIResponse.fromJson(
        res,
        (json) => TableBooking.fromJson(json),
      );
    } catch (e) {
      print('Error fetching booking detail: $e');
      throw e;
    }
  }

  Future<APIResponse<dynamic>> cancelBooking(int bookingId) async {
    try {
      var res = await _service.put(
        '${Endpoints.cancelBooking}/$bookingId',
        data: {'status': 'cancelled'},
      );

      return APIResponse.fromJson(res, (json) => json);
    } catch (e) {
      print('Error cancelling booking: $e');
      throw e;
    }
  }
}