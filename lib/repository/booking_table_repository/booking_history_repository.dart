import 'package:food_delivery_app/base/networking/api_response.dart';

import 'package:food_delivery_app/base/networking/constants/endpoint.dart';
import 'package:food_delivery_app/models/order/booking_table.dart';

import '../../base/networking/api.dart';

class BookingHistoryRepository {
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
      rethrow;
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
      rethrow;
    }
  }

  Future<APIResponse<List<TableBooking>>> getPendingBookings() async {
    try {
      var res =
          await _service.get('${Endpoints.listReservations}?status=pending');

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
      print('Error fetching pending bookings: $e');
      rethrow;
    }
  }

  Future<APIResponse<List<TableBooking>>> getBookingsByStatus(
      String status) async {
    try {
      dynamic res;
      if (status.toLowerCase() == 'completed') {
        res = await _service
            .get('${Endpoints.adminAllReservations}?status=completed');
      } else {
        res =
            await _service.get('${Endpoints.listReservations}?status=$status');
      }

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
      print('Error fetching bookings by status: $e');
      rethrow;
    }
  }

  Future<APIResponse<dynamic>> cancelBooking(int bookingId) async {
    try {
      var res = await _service.post(
        '${Endpoints.cancelBooking}/$bookingId/cancel',
        data: {},
      );

      return APIResponse.fromJson(res, (json) => json);
    } catch (e) {
      print('Error cancelling booking: $e');
      rethrow;
    }
  }

  Future<APIResponse<dynamic>> confirmBooking(
      int bookingId, int tableId) async {
    try {
      var res = await _service.post(
        '${Endpoints.confirmReservation}/$bookingId/update-status',
        data: {
          'status': 'confirmed',
          'tableId': tableId,
        },
      );

      return APIResponse.fromJson(res, (json) => json);
    } catch (e) {
      print('Error cancelling booking: $e');
      rethrow;
    }
  }

  Future<APIResponse<dynamic>> completeBooking(int bookingId) async {
    try {
      var res = await _service.post(
        '${Endpoints.confirmReservation}/$bookingId/update-status',
        data: {
          'status': 'completed',
        },
      );
      return APIResponse.fromJson(res, (json) => json);
    } catch (e) {
      rethrow;
    }
  }
}
