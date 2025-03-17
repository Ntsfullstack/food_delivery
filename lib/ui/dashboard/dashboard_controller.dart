import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';

class AdminDashboardController extends BaseController {
  // Thống kê tổng quan
  final totalDishes = 128.obs;
  final totalRestaurants = 24.obs;
  final totalUsers = 1256.obs;
  final totalOrders = 568.obs;

  // Danh sách đơn hàng gần đây
  final recentOrders = <Map<String, dynamic>>[].obs;

  // Danh sách món ăn phổ biến
  final popularDishes = <Map<String, dynamic>>[].obs;

  // Thống kê doanh thu
  final monthlyRevenue = <Map<String, dynamic>>[].obs;

  // Biến loading riêng cho dashboard
  final dashboardLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      // Sử dụng loading từ BaseController thay vì biến riêng
      showLoading(message: 'Đang tải dữ liệu...');

      // Mô phỏng việc tải dữ liệu từ API
      await Future.delayed(const Duration(seconds: 1));

      // Tải đơn hàng gần đây
      fetchRecentOrders();

      // Tải món ăn phổ biến
      fetchPopularDishes();

      // Tải doanh thu theo tháng
      fetchMonthlyRevenue();

      // Ẩn loading
      hideLoading();
    } catch (e) {
      // Ẩn loading khi có lỗi
      hideLoading();
      showError(message: 'Không thể tải dữ liệu: $e');
    }
  }

  Future<void> fetchRecentOrders() async {
    try {
      // Mô phỏng dữ liệu từ API
      recentOrders.assignAll([
        {
          'orderId': '#ORD-1001',
          'customerName': 'Nguyễn Văn A',
          'time': '30 phút trước',
          'status': 'Đang giao',
          'amount': '152.000 VNĐ',
        },
        {
          'orderId': '#ORD-1002',
          'customerName': 'Trần Thị B',
          'time': '45 phút trước',
          'status': 'Hoàn thành',
          'amount': '187.000 VNĐ',
        },
        {
          'orderId': '#ORD-1003',
          'customerName': 'Lê Văn C',
          'time': '1 giờ trước',
          'status': 'Chờ xác nhận',
          'amount': '235.000 VNĐ',
        },
        {
          'orderId': '#ORD-1004',
          'customerName': 'Phạm Thị D',
          'time': '2 giờ trước',
          'status': 'Hoàn thành',
          'amount': '164.000 VNĐ',
        },
      ]);
    } catch (e) {
      print('Error fetching recent orders: $e');
    }
  }

  Future<void> fetchPopularDishes() async {
    try {
      // Mô phỏng dữ liệu từ API
      popularDishes.assignAll([
        {
          'id': 1,
          'name': 'Cơm rang dưa bò',
          'price': '85.000 VNĐ',
          'image': 'https://via.placeholder.com/150',
          'rating': 4.8,
          'restaurant': 'Nhà hàng Việt'
        },
        {
          'id': 2,
          'name': 'Bún bò Huế',
          'price': '75.000 VNĐ',
          'image': 'https://via.placeholder.com/150',
          'rating': 4.5,
          'restaurant': 'Quán Huế Ngon'
        },
        {
          'id': 3,
          'name': 'Bánh mì thịt nướng',
          'price': '35.000 VNĐ',
          'image': 'https://via.placeholder.com/150',
          'rating': 4.7,
          'restaurant': 'Bánh mì Phương'
        },
        {
          'id': 4,
          'name': 'Phở bò tái nạm',
          'price': '65.000 VNĐ',
          'image': 'https://via.placeholder.com/150',
          'rating': 4.9,
          'restaurant': 'Phở Hà Nội'
        },
        {
          'id': 5,
          'name': 'Gà nướng sốt cay',
          'price': '125.000 VNĐ',
          'image': 'https://via.placeholder.com/150',
          'rating': 4.6,
          'restaurant': 'Gà nướng 5 Sao'
        },
      ]);
    } catch (e) {
      print('Error fetching popular dishes: $e');
    }
  }

  Future<void> fetchMonthlyRevenue() async {
    try {
      // Mô phỏng dữ liệu doanh thu hàng tháng
      monthlyRevenue.assignAll([
        {'month': 'T1', 'revenue': 25000000},
        {'month': 'T2', 'revenue': 30000000},
        {'month': 'T3', 'revenue': 35000000},
        {'month': 'T4', 'revenue': 40000000},
        {'month': 'T5', 'revenue': 38000000},
        {'month': 'T6', 'revenue': 42000000},
      ]);
    } catch (e) {
      print('Error fetching monthly revenue: $e');
    }
  }

  // Tải lại dữ liệu dashboard
  Future<void> refreshDashboard() async {
    fetchDashboardData();
  }

  // Phương thức tính toán thống kê
  int getTotalOrdersToday() {
    // Trong thực tế, cần tính toán dựa trên dữ liệu thực tế từ API
    return 26;
  }

  double getTotalRevenueToday() {
    // Trong thực tế, cần tính toán dựa trên dữ liệu thực tế từ API
    return 4500000;
  }

  double getGrowthRate() {
    // Tỷ lệ tăng trưởng so với ngày hôm qua
    return 8.5;
  }
}