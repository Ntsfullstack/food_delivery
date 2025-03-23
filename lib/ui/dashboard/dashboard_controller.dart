import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/dashboard/dashboard.dart';
import 'package:get/get.dart';

class AdminDashboardController extends BaseController {
  // Users statistics
  final Rx<Users> users = Users().obs;
  final Rx<Revenue> revenue = Revenue().obs;
  final Rx<Orders> orders = Orders().obs;
  final Rx<Dishes> dishes = Dishes().obs;
  final Rx<Tables> tables = Tables().obs;
  final Rx<Reservations> reservations = Reservations().obs;
  final Rx<RecentActivity> recentActivity = RecentActivity().obs;


  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 100), () {
      fetchDashboardData();
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
        final dashboard = response.data!;
        
        // Update values
        users.value = dashboard.users ?? Users();
        revenue.value = dashboard.revenue ?? Revenue();
        orders.value = dashboard.orders ?? Orders();
        dishes.value = dashboard.dishes ?? Dishes();
        tables.value = dashboard.tables ?? Tables();
        reservations.value = dashboard.reservations ?? Reservations();
        recentActivity.value = dashboard.recentActivity ?? RecentActivity();
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

  // Các phương thức helper giữ nguyên
  int getTotalOrdersToday() {
    return orders.value.completedOrders ?? 0;
  }

  double getTotalRevenueToday() {
    return revenue.value.todayRevenue?.toDouble() ?? 0.0;
  }

  double getRevenueGrowth() {
    return revenue.value.revenueGrowth?.toDouble() ?? 0.0;
  }

  int getTotalCustomers() {
    return users.value.totalCustomers ?? 0;
  }

  int getNewUsers30Days() {
    return users.value.newUsersLast30Days ?? 0;
  }

  List<PopularDish> getPopularDishes() {
    return dishes.value.popularDishes ?? [];
  }

  List<RecentOrder> getRecentOrders() {
    return recentActivity.value.recentOrders ?? [];
  }

  // Table statistics
  int getAvailableTables() {
    return tables.value.availableTables ?? 0;
  }

  int getOccupiedTables() {
    return tables.value.occupiedTables ?? 0;
  }

  // Reservation statistics
  int getTodayReservations() {
    return reservations.value.todayReservations ?? 0;
  }

  int getPendingReservations() {
    return reservations.value.pendingReservations ?? 0;
  }
  Future<void> refreshDashboard() async {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    
    try {
      showLoading(message: 'Đang làm mới dữ liệu...');
      await fetchDashboardData();
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      showError(message: 'Không thể làm mới dữ liệu: $e');
    }
  }
}