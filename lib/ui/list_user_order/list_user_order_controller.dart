import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/base/base_controller.dart';

import '../../models/order/order.dart';

class ListUserOrderController extends BaseController {
  final RxList<ListOrder> orders = <ListOrder>[].obs;
  final RxList<ListOrder> allOrders = <ListOrder>[].obs; // Store all orders
  final RxBool _isLoadingOrders = false.obs;
  final RxBool hasMoreData = true.obs;
  final RxInt currentPage = 1.obs;
  final RxString selectedStatus = 'Tất cả'.obs;
  
  bool get isLoadingOrders => _isLoadingOrders.value;
  
  final statusList = ['Tất cả', 'confirmed', 'completed', 'pending', 'cancelled'];
  
  final Map<String, String> statusDisplayNames = {
    'confirmed': 'Đã xác nhận',
    'completed': 'Hoàn thành',
    'pending': 'Chờ xử lý',
    'cancelled': 'Đã hủy',
  };

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      currentPage.value = 1;
      allOrders.clear();
    }

    if (!hasMoreData.value && isLoadMore) return;

    try {
      _isLoadingOrders.value = true;
      
      // Fetch all orders without status filter
      final response = await orderRepositories.getUserOrders(
        page: currentPage.value.toString(),
      );

      if (response.data != null && response.data!.isNotEmpty) {
        allOrders.addAll(response.data!);
        currentPage.value++;
        hasMoreData.value = response.data!.length >= 10;
      } else {
        hasMoreData.value = false;
      }
      
      // Apply filter
      applyStatusFilter();
      
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      _isLoadingOrders.value = false;
    }
  }

  // Apply status filter locally
  void applyStatusFilter() {
    if (selectedStatus.value == 'Tất cả') {
      orders.assignAll(allOrders);
    } else {
      orders.assignAll(allOrders.where(
        (order) => order.status == selectedStatus.value
      ).toList());
    }
  }

  String getStatusDisplayName(String? status) {
    if (status == null) return 'Chờ xử lý';
    return statusDisplayNames[status] ?? status;
  }

  void setStatus(String status) {
    if (selectedStatus.value != status) {
      selectedStatus.value = status;
      applyStatusFilter(); // Just filter locally, don't fetch again
    }
  }

  void loadMoreOrders() {
    fetchOrders(isLoadMore: true);
  }

  void viewOrderDetail(String orderId) {
    Get.toNamed(RouterName.orderDetail,
      parameters: {'orderId': orderId},
    );
  }
}