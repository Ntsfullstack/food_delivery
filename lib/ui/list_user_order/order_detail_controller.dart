import 'package:flutter/material.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import '../../models/order/order_detail.dart';

class OrderDetailController extends BaseController {
  final RxBool _isLoading = false.obs;
  final Rx<OrderDetail?> orderDetail = Rx<OrderDetail?>(null);
  final RxString orderId = ''.obs;


  bool get isLoading => _isLoading.value;

  final Map<String, String> statusDisplayNames = {
    'confirmed': 'Đã xác nhận',
    'completed': 'Hoàn thành',
    'pending': 'Chờ xử lý',
    'cancelled': 'Đã hủy',
  };

  @override
  void onInit() {
    super.onInit();
    // Get the order ID from parameters without showing error during initialization
    orderId.value = Get.parameters['orderId'] ?? '';
    print('OrderDetailController initialized with orderId: ${orderId.value}');

    // Use Future.microtask to delay the API call until after the build is complete
    Future.microtask(() {
      if (orderId.value.isNotEmpty) {
        fetchOrderDetail();
      } else {
        // Use a safer way to show error and navigate back
        Future.delayed(Duration(milliseconds: 100), () {
          showError(message: 'Không tìm thấy mã đơn hàng');
          Get.back();
        });
      }
    });
  }

  String getStatusDisplayName(String? status) {
    if (status == null) return 'Chờ xử lý';
    return statusDisplayNames[status] ?? status;
  }

  Future<void> fetchOrderDetail() async {
    try {
      print('Fetching order detail for orderId: ${orderId.value}');
      _isLoading.value = true;

      final response = await orderRepositories.getOrderDetail(orderId.value);
      print('API response received: ${response.data != null}');

      if (response.data != null) {
        orderDetail.value = response.data;
        print('Order detail loaded successfully');
      } else {
        print('Order detail not found');
        // Use a safer way to show error
        Future.delayed(Duration(milliseconds: 100), () {
          showError(message: 'Không tìm thấy thông tin đơn hàng');
        });
      }
    } catch (e) {
      print('Error fetching order detail: $e');
      // Use a safer way to show error
      Future.delayed(Duration(milliseconds: 100), () {
        showError(message: 'Đã xảy ra lỗi khi tải thông tin đơn hàng');
      });
    } finally {
      _isLoading.value = false;
    }
  }
  Future<void> cancelOrder() async {
    try {
      _isLoading.value = true;

      final response = await orderRepositories.cancelOrder(orderId.value);
      if (response.success == 200) {
        // Show success message
        Get.snackbar(
          'Thành công',
          'Đã hủy đơn hàng thành công',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Reload order detail
        await fetchOrderDetail();
      } else {
        // Show error message
        Get.snackbar(
          'Lỗi',
          response.message ?? 'Không thể hủy đơn hàng',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error cancelling order: $e');
      // Show error message
      Get.snackbar(
        'Lỗi',
        'Không thể hủy đơn hàng: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }
  // Trong OrderDetailController, thêm phương thức này
  void goBack() {
    // Truyền kết quả true để thông báo cần làm mới dữ liệu
    Get.back(result: true);
  }
}