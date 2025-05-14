import 'package:food_delivery_app/base/base_controller.dart';

import 'package:food_delivery_app/models/order_managerment/order_managerment.dart';
import 'package:food_delivery_app/routes/router_name.dart';

import '../../models/order/order_detail.dart';

class OrderManagementController extends BaseController {
  final RxList<OrderManagement> orders = <OrderManagement>[].obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxBool isLoadingData = false.obs;
  final RxBool _isLoading = false.obs;

  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'Tất cả'.obs;
  final RxList<String> statusList = <String>['Tất cả', 'Đang xử lý', 'Đang giao', 'Hoàn thành', 'Đã hủy'].obs;
  final selectedOrder = Rxn<OrderDetail>();

  // Map Vietnamese status to English status
  String _mapStatusToEnglish(String vietnameseStatus) {
    switch (vietnameseStatus) {
      case 'Đang xử lý':
        return 'processing';
      case 'Đang giao':
        return 'confirmed';
      case 'Hoàn thành':
        return 'completed';
      case 'Đã hủy':
        return 'cancelled';
      default:
        throw Exception('Invalid Vietnamese status: $vietnameseStatus');
    }
  }

  // Map English status to Vietnamese status
  String _mapStatusToVietnamese(String englishStatus) {
    switch (englishStatus.toLowerCase()) {
      case 'processing':
        return 'Đang xử lý';
      case 'confirmed':
        return 'Đang giao';
      case 'completed':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return englishStatus;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Use a small delay to avoid showing loading during build
    Future.delayed(const Duration(milliseconds: 100), () {
      loadOrders();
    });
  }

  Future<void> loadOrders({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      currentPage.value = 1;
      orders.clear();
    }

    if (!hasMoreData.value && isLoadMore) return;

    try {
      isLoadingData.value = true;
      final response = await orderManagementRepositories.getListOrder(
        page: currentPage.value.toString(),
        limit: "10",
      );

      if (response.data?.isNotEmpty == true) {
        if (isLoadMore) {
          orders.addAll(response.data!);
        } else {
          orders.value = response.data!;
        }
        currentPage.value++;
        hasMoreData.value = response.data!.length >= 10;
      } else {
        hasMoreData.value = false;
      }
    } catch (e) {
      print('Error loading orders: $e');
      showError(message: 'Không thể tải danh sách đơn hàng');
    } finally {
      isLoadingData.value = false;
    }
  }

  void navigateToOrderDetail(String orderId) {
    _isLoading.value = true;
    selectedOrder.value = null; // Reset selected order
    Get.toNamed(RouterName.adminOrderDetail, arguments: orderId);
    loadOrderDetail(orderId);
  }

  Future<void> loadOrderDetail(String orderId) async {
    try {
      _isLoading.value = true;
      final response = await orderManagementRepositories.getOrderDetail(orderId);
      selectedOrder.value = response;
      print('Order detail loaded: ${response.orderId}'); // Debug print
    } catch (e) {
      print('Error loading order detail: $e');
      showError(message: 'Không thể tải thông tin đơn hàng');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> updateOrderStatus(String orderId, String vietnameseStatus) async {
    try {
      _isLoading.value = true;
      final englishStatus = _mapStatusToEnglish(vietnameseStatus);
      await orderManagementRepositories.updateOrderStatus(orderId, englishStatus);
      
      // Update the order in the list
      final index = orders.indexWhere((order) => order.orderId.toString() == orderId);
      if (index != -1) {
        final updatedOrder = orders[index].copyWith(status: vietnameseStatus);
        orders[index] = updatedOrder;
      }
      
      // Reload order detail
      await loadOrderDetail(orderId);
      
      // Reload orders list to ensure consistency
      await loadOrders();
      
      showSuccess(message: 'Đã cập nhật trạng thái đơn hàng');
    } catch (e) {
      print('Error updating order status: $e');
      showError(message: 'Không thể cập nhật trạng thái đơn hàng');
    } finally {
      _isLoading.value = false;
    }
  }

  // Convenience methods for specific status updates
  Future<void> processOrder(String orderId) => updateOrderStatus(orderId, 'Đang xử lý');
  Future<void> confirmOrder(String orderId) => updateOrderStatus(orderId, 'Đang giao');
  Future<void> completeOrder(String orderId) => updateOrderStatus(orderId, 'Hoàn thành');
  Future<void> cancelOrder(String orderId) => updateOrderStatus(orderId, 'Đã hủy');

  void refreshOrders() {
    loadOrders();
  }

  List<OrderManagement> get filteredOrders {
    return orders.where((order) {
      // Lọc theo trạng thái
      if (selectedStatus.value != 'Tất cả') {
        final orderStatus = _mapStatusToVietnamese(order.status ?? '');
        if (orderStatus != selectedStatus.value) {
          return false;
        }
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
    // Force UI update by triggering a rebuild
    orders.refresh();
    // Reload orders to ensure we have the latest data
    loadOrders();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    // Force UI update
    orders.refresh();
  }
}