import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/ui/booking_screen/booking_status.dart';
import 'package:food_delivery_app/ui/bottom_navigation/bottom_navigation.dart';
import 'package:food_delivery_app/ui/cart_screen/cart_binding.dart';
import 'package:food_delivery_app/ui/cart_screen/cart_screen.dart';
import 'package:food_delivery_app/ui/dashboard/dashboard_binding.dart';
import 'package:food_delivery_app/ui/dashboard/dashboard_screen.dart';
import 'package:food_delivery_app/ui/food_detail/food_detail_screen.dart';
import 'package:food_delivery_app/ui/food_detail/food_detail_binding.dart';
import 'package:food_delivery_app/ui/list_customer/customer_screen.dart';

import 'package:food_delivery_app/ui/login_screen/login_binding.dart';
import 'package:food_delivery_app/ui/login_screen/login_screen.dart';
import 'package:food_delivery_app/ui/otp_screen/otp_binding.dart';
import 'package:food_delivery_app/ui/otp_screen/otp_screen.dart';
import 'package:food_delivery_app/ui/payment_web/payment_web_screen.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_binding.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_screen.dart';
import 'package:food_delivery_app/ui/register_screen/forgot_password_binding.dart';
import 'package:food_delivery_app/ui/register_screen/forgot_password_screen.dart';
import 'package:food_delivery_app/ui/register_screen/register_binding.dart';
import 'package:food_delivery_app/ui/register_screen/register_screen.dart';
import 'package:food_delivery_app/ui/search_page/search_page.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_binding.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/booking_history/booking_history_binding.dart';
import '../ui/booking_history/booking_history_screen.dart';
import '../ui/booking_management/booking_binding.dart';
import '../ui/booking_management/booking_management_screen.dart';
import '../ui/bottom_navigation/bottom_navigation_binding.dart';
import '../ui/dish_management/dish_management_binding.dart';
import '../ui/dish_management/dish_management_screen.dart';
import '../ui/dish_managerment_detail/dish_detail_binding.dart';
import '../ui/dish_managerment_detail/dish_detail_screen.dart';
import '../ui/list_customer/customer_binding.dart';

import '../ui/list_menu/list_menu.dart';
import '../ui/list_menu/list_menu_binding.dart';
import '../ui/list_user_order/list_user_order.dart';
import '../ui/list_user_order/list_user_order_binding.dart';
import '../ui/list_user_order/order_detail_binding.dart';
import '../ui/list_user_order/order_detail_screen.dart';
import '../ui/order_management/admin_order_detail.dart';
import '../ui/order_management/order_management_binding.dart';
import '../ui/order_management/order_management_screen.dart';
import '../ui/search_page/search_binding.dart';
import '../ui/splash/splash_binding.dart';
import '../ui/splash/splash_screen.dart';
import 'router_name.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
        name: RouterName.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding(),
      ),
      GetPage(
        name: RouterName.login,
        page: () => const LoginScreen(),
        binding: AuthBinding(),
      ),
      GetPage(
          name: RouterName.register,
          page: () => const SignUpScreen(),
          binding: RegisterBinding()),
      GetPage(
          name: RouterName.bottomNavigation,
          page: () => BottomNavigation(),
          binding: BottomNavigationBinding()),
      GetPage(
        name: RouterName.setting,
        page: () => const SettingsScreen(),
        binding: SettingsBinding(),
      ),
      GetPage(
        name: RouterName.bookingHistory,
        page: () => const BookingHistoryScreen(),
        binding: BookingHistoryBinding(),
      ),
      GetPage(
        name: RouterName.profile,
        page: () => const ProfileScreen(),
        binding: ProfileBinding(),
      ),
      GetPage(
        name: RouterName.foodDetail,
        page: () => const FoodDetailScreen(),
        binding: FoodDetailBinding(),
      ),
      GetPage(
        name: '/forgot-password',
        page: () => const ForgotPasswordScreen(),
        binding: ForgotPasswordBinding(),
      ),
      GetPage(
        name: RouterName.dashBoard,
        page: () => AdminDashboardScreen(),
        binding: AdminDashboardBinding(),
      ),
      GetPage(
        name: RouterName.verifyOTP,
        page: () => const VerifyEmailScreen(),
        binding: VerifyEmailBinding(),
      ),
      GetPage(
        name: RouterName.listUser,
        page: () => const ListCustomer(),
        binding: CustomerBinding(),
      ),
      GetPage(
        name: RouterName.dishManagement,
        page: () => const DishManagementScreen(),
        binding: DishManagementBinding(),
      ),
      GetPage(
        name: RouterName.orderManagement,
        page: () => const OrderManagementScreen(),
        binding: OrderManagementBinding(),
      ),
// GetPage(
//   name: RouterName.invoiceManagement,
//   page: () => const InvoiceManagementScreen(),
//   binding: InvoiceManagementBinding(),
// ),
      GetPage(
        name: RouterName.cartScreen,
        page: () => const CartScreen(),
        binding: CartBinding(),
      ),
      GetPage(
        name: RouterName.userOrders,
        page: () => const ListUserOrderScreen(),
        binding: ListUserOrderBinding(),
      ),
      GetPage(
        name: RouterName.orderDetail,
        page: () => const OrderDetailScreen(),
        binding: OrderDetailBinding(),
      ),
      GetPage(
          name: RouterName.bookingStatus,
          page: () => const BookingStatusScreen()),
      GetPage(name: RouterName.listMenu, page: () => const ListMenu()
          , binding: ListMenuBinding()),
      GetPage(
        name: RouterName.adminOrderDetail,
        page: () => const AdminOrderDetailScreen(),
        binding: OrderManagementBinding(),
      ),
      GetPage(
        name: RouterName.adminDishDetail,
        page: () => const DishDetailScreen(),
        binding: DishDetailBinding(),
      ),
      GetPage(name: RouterName.search,
          page: () =>  SearchPage(),
          binding: SearchBinding()),
      GetPage(
        name: RouterName.paymentWeb,
        page: () => const PaymentWebScreen(),
      ),
      GetPage(name: RouterName.search, page:()=> const SearchPage() ),
      // GetPage(
      //   name: RouterName.bookingTableManagement,
      //   page: () => const BookingManagementScreen(),
      //   binding: BookingBinding(),
      // ),
      // GetPage(
      //   name: RouterName.bookingTableManagementDetail,
      //   page: () => BookingDetailScreen(
      //     bookingId: int.parse(Get.parameters['id'] ?? '0'),
      //   ),
      //   binding: BookingBinding(),
      // ),

    ];
  }
}
