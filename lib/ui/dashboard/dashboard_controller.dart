import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/dashboard/dashboard.dart';

class AdminDashboardController extends BaseController {
  // Dashboard data
  final Rx<DashBoard> dashboard = DashBoard().obs;
  
  // Additional data for charts
  final RxList<Map<String, dynamic>> salesByDay = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> topDishes = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> recentOrders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 100), () {
      fetchDashboardData();
      fetchSalesByDay();
      fetchTopDishes();
      fetchRecentOrders();
    });
  }

  Future<void> fetchDashboardData() async {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    try {
      showLoading(message: 'Đang tải dữ liệu...');

      final response = await dashboardRepositories.getDashboard();

      if (response.data != null) {
        dashboard.value = response.data!;
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      showError(message: 'Không thể tải dữ liệu: $e');
    } finally {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }
  // Fetch sales data by day for charts
  Future<void> fetchSalesByDay() async {
    try {
      final now = DateTime.now();
      final response = await dashboardRepositories.getSalesByDay(now.month, now.year);
      
      if (response.data != null) {
        salesByDay.value = response.data!;
      }
    } catch (e) {
      print('Error fetching sales by day: $e');
    }
  }

  // Fetch top dishes data
  Future<void> fetchTopDishes() async {
    try {
      final response = await dashboardRepositories.getTopDishes();
      
      if (response.data != null) {
        topDishes.value = response.data!;
      }
    } catch (e) {
      print('Error fetching top dishes: $e');
    }
  }

  // Fetch recent orders
  Future<void> fetchRecentOrders() async {
    try {
      final response = await orderManagementRepositories.getListOrder(page: "1", limit: "5");
      
      if (response.data != null) {
        recentOrders.value = response.data!.map((order) => {
          'orderId': order.orderId,
          'customerName': order.username,
          'orderDate': order.orderDate?.toString(),
          'status': order.status,
          'totalPrice': order.totalPrice,
        }).toList();
      }
    } catch (e) {
      print('Error fetching recent orders: $e');
    }
  }

  int getTotalOrdersToday() {
    return dashboard.value.orders?.total ?? 0;
  }

  double getTotalRevenueToday() {
    return dashboard.value.revenue?.total ?? 0.0;
  }

  List<PopularDish> getPopularDishes() {
    return dashboard.value.popularDishes ?? [];
  }

  int getAvailableTables() {
    return dashboard.value.tables?.available ?? 0;
  }

  int getTodayReservations() {
    return dashboard.value.reservations?.today ?? 0;
  }

  // Get sales data for charts
  List<Map<String, dynamic>> getSalesByDay() {
    return salesByDay;
  }

  // Get top dishes data
  List<Map<String, dynamic>> getTopDishesData() {
    return topDishes;
  }

  // Get recent orders
  List<Map<String, dynamic>> getRecentOrders() {
    return recentOrders;
  }

  // Export orders report to CSV
  Future<void> exportOrdersReport() async {
    try {
      showLoading(message: 'Đang xuất báo cáo...');
      
      final now = DateTime.now();
      final from = DateTime(now.year, now.month, 1);
      final to = now;
      
      final response = await orderManagementRepositories.exportOrdersReport(from, to);
      
      // TODO: Handle file download from bytes response
      // For now, just show success message
      Get.back(); // Close loading
      showSuccess(message: 'Báo cáo đã được xuất thành công');
      
    } catch (e) {
      Get.back(); // Close loading
      showError(message: 'Không thể xuất báo cáo: $e');
    }
  }

  Future<void> refreshDashboard() async {
    await Future.wait([
      fetchDashboardData(),
      fetchSalesByDay(),
      fetchTopDishes(),
      fetchRecentOrders(),
    ]);
  }
}