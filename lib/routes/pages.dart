import 'package:food_delivery_app/ui/bottom_navigation/bottom_navigation.dart';
import 'package:food_delivery_app/ui/login_screen/login_binding.dart';
import 'package:food_delivery_app/ui/login_screen/login_screen.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_binding.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_screen.dart';
import 'package:food_delivery_app/ui/register_screen/register_binding.dart';
import 'package:food_delivery_app/ui/register_screen/register_screen.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_binding.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/bottom_navigation/bottom_navigation_binding.dart';
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
          binding: BottomNavigationBinding()
      ),
      GetPage(
        name: RouterName.setting,
          page: ()=> const SettingsScreen(),
          binding: SettingsBinding(),
      ),
      GetPage(name: RouterName.profile,
          page: ()=> const ProfileScreen(),
        binding: ProfileBinding(),
      )
    ];
  }
}
