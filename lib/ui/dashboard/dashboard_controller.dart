import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/dashboard/dashboard.dart';
import 'package:get/get.dart';

class AdminDashboardController extends BaseController {
  // Dashboard data
  final Rx<DashBoard> dashboard = DashBoard().obs;

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

  int getTotalOrdersToday() {
    return dashboard.value.orders?.total ?? 0;
  }

  double getTotalRevenueToday() {
    return dashboard.value.revenue?.total ?? 0.0;
  }


  // int getTotalCustomers() {
  //   return dashboard.value. ?? 0;
  // }

  List<PopularDish> getPopularDishes() {
    return dashboard.value.popularDishes ?? [];
  }

  // List<dynamic> getRecentOrders() {
  //   // Đảm bảo không trả về null
  //   return dashboard.value.recentOrders ?? [];
  // }

  int getAvailableTables() {
    return dashboard.value.tables?.available ?? 0;
  }

  int getTodayReservations() {
    return dashboard.value.reservations?.today ?? 0;
  }

  Future<void> refreshDashboard() async {
    await fetchDashboardData();
  }
}