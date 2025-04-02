import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';

import 'package:food_delivery_app/models/order_managerment/order_managerment.dart';
import 'package:get/get.dart';

class OrderManagementController extends BaseController {
  final RxList<OrderManagement> orders = <OrderManagement>[].obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxBool isLoadingData = false.obs;

  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'Tất cả'.obs;
  final RxList<String> statusList = <String>['Tất cả', 'Đang xử lý', 'Đang giao', 'Hoàn thành', 'Đã hủy'].obs;

  @override
  void onInit() {
    super.onInit();
    // Use a small delay to avoid showing loading during build
    Future.delayed(Duration(milliseconds: 100), () {
      fetchOrders();
    });
  }

  Future<void> fetchOrders({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        orders.clear();
      }
      
      isLoadingData.value = true;
      try {
        final response = await orderManagementRepositories.getListOrder(
          page: currentPage.value.toString(),
          limit: "10",
        );
        
        if (response.data != null) {
          if (currentPage.value == 1) {
            orders.value = response.data!;
          } else {
            orders.addAll(response.data!);
          }

          totalPages.value = response.lastPage?.toInt() ?? 1;
          hasMoreData.value = currentPage.value < totalPages.value;
        }
      } catch (apiError) {
        print("API Error: $apiError");
        // Fallback to mock data for testing
      }
    } catch (e) {
      print("General Error: $e");
      Get.snackbar(
        'Lỗi',
        'Không thể tải danh sách đơn hàng: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingData.value = false;
    }
  }

  List<OrderManagement> get filteredOrders {
    return orders.where((order) {
      // Lọc theo trạng thái
      if (selectedStatus.value != 'Tất cả' && 
          order.status != selectedStatus.value) {
        return false;
      }
      
      // Lọc theo từ khóa tìm kiếm
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        final orderId = (order.orderId?.toString() ?? '').toLowerCase();
        final customerName = (order.username ?? '').toLowerCase();
        return orderId.contains(query) || customerName.contains(query);
      }
      
      return true;
    }).toList();
  }

  void setStatus(String status) {
    selectedStatus.value = status;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> refreshOrders() async {
    await fetchOrders(isRefresh: true);
  }

  Future<void> loadMoreOrders() async {
    if (hasMoreData.value) {
      currentPage.value++;
      await fetchOrders();
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      isLoadingData.value = true;
      
      // TODO: Implement API call to update order status
      await Future.delayed(const Duration(seconds: 1));
      
      // Cập nhật trạng thái đơn hàng
      final index = orders.indexWhere((order) => order.orderId.toString() == orderId);
      if (index != -1) {
        final updatedOrder = orders[index].copyWith(status: newStatus);
        orders[index] = updatedOrder;
      }
      
      Get.snackbar(
        'Thành công',
        'Cập nhật trạng thái thành công',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể cập nhật trạng thái: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    } finally {
      isLoadingData.value = false;
    }
  }

}