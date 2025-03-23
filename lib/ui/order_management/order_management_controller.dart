import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/dashboard/dashboard.dart';
import 'package:get/get.dart';

class OrderManagementController extends BaseController {
  final RxList<RecentOrder> orders = <RecentOrder>[].obs;

  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'Tất cả'.obs;
  final RxList<String> statusList = <String>['Tất cả', 'Đang xử lý', 'Đang giao', 'Hoàn thành', 'Đã hủy'].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      showLoading(message: 'Đang tải dữ liệu...');
      
      // Lấy dữ liệu từ API
      final response = await dashboardRepositories.getDashboard();
      
      if (response.data != null && response.data!.recentActivity != null) {
        final allOrders = response.data!.recentActivity!.recentOrders ?? [];
        orders.value = allOrders;
      }
    } catch (e) {
      showError(message: 'Không thể tải danh sách đơn hàng: $e');
    } finally {
      hideLoading();
    }
  }

  List<RecentOrder> get filteredOrders {
    return orders.where((order) {
      // Lọc theo trạng thái
      if (selectedStatus.value != 'Tất cả' && 
          order.status != selectedStatus.value) {
        return false;
      }
      
      // Lọc theo từ khóa tìm kiếm
      // if (searchQuery.value.isNotEmpty) {
      //   final query = searchQuery.value.toLowerCase();
      //   final orderId = (order.orderId ?? '').toLowerCase();
      //   final customerName = (order.customerName ?? '').toLowerCase();
      //   return orderId.contains(query) || customerName.contains(query);
      // }
      
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
    await fetchOrders();
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      showLoading(message: 'Đang cập nhật trạng thái...');
      
      // Giả lập API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Cập nhật trạng thái đơn hàng
      final index = orders.indexWhere((order) => order.orderId == orderId);
      if (index != -1) {
        final updatedOrder = orders[index].copyWith(status: newStatus);
        orders[index] = updatedOrder;
      }
      
      showSuccess(message: 'Cập nhật trạng thái thành công');
    } catch (e) {
      showError(message: 'Không thể cập nhật trạng thái: $e');
    } finally {
      hideLoading();
    }
  }
}

// Thêm phương thức copyWith cho RecentOrder
// extension RecentOrderExtension on RecentOrder {
//   RecentOrder copyWith({
//     String? orderId,
//     String? customerName,
//     DateTime? orderDate,
//     String? status,
//     String? totalPrice,
//   }) {
//     return RecentOrder(
//       orderId: orderId ?? this.orderId,
//       customerName: customerName ?? this.customerName,
//       orderDate: orderDate ?? this.orderDate,
//       status: status ?? this.status,
//       totalPrice: totalPrice ?? this.totalPrice,
//     );
//   }
// }