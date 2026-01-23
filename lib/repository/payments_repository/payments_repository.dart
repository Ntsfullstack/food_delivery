import 'package:food_delivery_app/base/networking/api.dart';
import 'package:food_delivery_app/base/networking/api_response.dart';
import 'package:food_delivery_app/base/networking/constants/endpoint.dart';

class PaymentsRepository {
  late ApiService _service;
  PaymentsRepository({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponse<Map<String, dynamic>>> createDepositPayment({
    required int reservationId,
    required int amount,
    String method = 'zalopay',
    String? redirectUrl,
  }) async {
    final data = {
      'reservation_id': reservationId,
      'amount': amount,
      'description': 'Deposit for reservation #$reservationId',
      if (redirectUrl != null) 'redirect_url': redirectUrl,
      'payment_method': method,
    };
    final res = await _service.post(Endpoints.paymentMethod, data: data);
    return APIResponse.fromJson(res, (json) => Map<String, dynamic>.from(json));
  }
}
