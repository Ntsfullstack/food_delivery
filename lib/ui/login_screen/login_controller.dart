// lib/controllers/auth_controller.dart
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login/login.dart';
import '../../routes/router_name.dart';

class AuthController extends BaseController {
  final _prefs = Get.find<SharedPreferences>();

  final email = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;
  final errorMessage = ''.obs;
  final currentUser = Rxn<User>();
  final userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Delay để đảm bảo widget đã được build xong
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginState();
    });
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> checkLoginState() async {
    try {
      final token = _prefs.getString('accessToken');
      if (token == null) {
        // Check if we're already on the login page to avoid loops
        if (Get.currentRoute != RouterName.login) {
          await Get.offAllNamed(RouterName.login);
        }
        return;
      }

      // Kiểm tra token hết hạn
      if (JwtDecoder.isExpired(token)) {
        final refreshToken = _prefs.getString('refreshToken');
        if (refreshToken == null) {
          await clearUserData();
          // Check if we're already on the login page to avoid loops
          if (Get.currentRoute != RouterName.login) {
            await Get.offAllNamed(RouterName.login);
          }
          return;
        }

        // Thử refresh token
        await refreshUserToken(refreshToken);
      }

      // Load thông tin user
      await loadCurrentUser();

      // Kiểm tra role và điều hướng nếu cần
      checkRoleAndRedirect();

    } catch (e) {
      print('Error checking login state: $e');
      await clearUserData();
      // Check if we're already on the login page to avoid loops
      if (Get.currentRoute != RouterName.login) {
        await Get.offAllNamed(RouterName.login);
      }
    }
  }

  // Phương thức kiểm tra role và điều hướng người dùng
  void checkRoleAndRedirect() {
    if (currentUser.value == null) return;

    final role = currentUser.value?.role ?? 'customer';
    userRole.value = role;

    // Kiểm tra role để điều hướng đến màn hình phù hợp
    switch (role) {
      case 'admin':
      // Nếu là admin và đang ở trang không phải dành cho admin
        if (!Get.currentRoute.startsWith('/admin')) {
          Get.offAllNamed(RouterName.dashBoard);
        }
        break;
      case 'customer':
      default:
        if (Get.currentRoute != RouterName.bottomNavigation &&
            Get.currentRoute != RouterName.login) {
          Get.offAllNamed(RouterName.bottomNavigation);
        }
        break;
    }
  }

  Future<void> loadCurrentUser() async {
    try {
      final userID = _prefs.getString('userId');
      final email = _prefs.getString('userEmail');
      final username = _prefs.getString('userName');
      final fullName = _prefs.getString('fullName');
      final role = _prefs.getString('userRole');

      if (userID == null) return;

      currentUser.value = User(
        userId: userID,
        email: email!,
        username: username!,
        fullName: fullName!,
        role: role ?? 'customer', // Mặc định là customer nếu không có role
      );

      // Cập nhật biến userRole
      userRole.value = role ?? 'customer';
    } catch (e) {
      print('Error loading user: $e');
    }
  }

  Future<void> refreshUserToken(String refreshToken) async {
    try {
      await authRepositories.refreshToken(refreshToken);
      // Sau khi refresh token thành công, load lại thông tin user
      await loadCurrentUser();
    } catch (e) {
      print('Error refreshing token: $e');
      await clearUserData();
      await Get.offAllNamed(RouterName.login);
    }
  }

  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      showError(message: 'Vui lòng nhập đầy đủ thông tin');
      return;
    }

    showLoading(message: 'Đang đăng nhập...');
    try {
      final response = await authRepositories.login(
        email: email.value,
        password: password.value,
      );

      // Kiểm tra status từ response
      if (response.statusCode != 200) {
        hideLoading();
        showError(message: response.message);
        return;
      }
      await saveUserData(response);
      currentUser.value = response.user;
      userRole.value = response.user.role ?? 'customer';

      hideLoading();

      // Điều hướng dựa trên role
      if (userRole.value == 'admin') {
        await Get.offAllNamed(RouterName.dashBoard);
      } else if (userRole.value == 'customer') {
        await Get.offAllNamed(RouterName.bottomNavigation);
      } else {
        await Get.offAllNamed(RouterName.bottomNavigation);
      }
    } catch (e) {
      hideLoading();
      showError(message: 'Đăng nhập thất bại: ${e.toString()}');
    }
  }

  Future<void> saveUserData(LoginResponse response) async {
    try {
      // Lưu tokens
      await _prefs.setString('accessToken', response.accessToken);
      await _prefs.setString('refreshToken', response.refreshToken);

      // Lưu thông tin user
      await _prefs.setString('userId', response.user.userId);
      await _prefs.setString('userEmail', response.user.email);
      await _prefs.setString('userName', response.user.username);
      await _prefs.setString('fullName', response.user.fullName);

      // Lưu role
      if (response.user.role != null) {
        await _prefs.setString('userRole', response.user.role!);
      }
    } catch (e) {
      print('Error saving user data: $e');
      throw Exception('Không thể lưu thông tin đăng nhập');
    }
  }

  Future<void> clearUserData() async {
    try {
      await _prefs.remove('accessToken');
      await _prefs.remove('refreshToken');
      await _prefs.remove('userId');
      await _prefs.remove('userEmail');
      await _prefs.remove('userName');
      await _prefs.remove('fullName');
      await _prefs.remove('userRole');
      currentUser.value = null;
      userRole.value = '';
    } catch (e) {
      print('Error clearing user data: $e');
    }
  }

  void showError({required String message}) {
    errorMessage.value = message;
    Get.snackbar(
      'Thông báo',
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  // Hàm kiểm tra quyền truy cập
  bool hasRole(String requiredRole) {
    return userRole.value == requiredRole;
  }

  // Hàm kiểm tra quyền admin
  bool isAdmin() {
    return userRole.value == 'admin';
  }

  // Hàm kiểm tra quyền nhà hàng
  bool isRestaurant() {
    return userRole.value == 'restaurant';
  }

  // Hàm kiểm tra quyền khách hàng
  bool isCustomer() {
    return userRole.value == 'customer' || userRole.value.isEmpty;
  }

  Future<void> loginWithGoogle() async {
    showLoading(message: 'Đang đăng nhập với Google...');
    try {
      // TODO: Implement Google login
      print('Login with Google');
    } catch (e) {
      showError(message: 'Đăng nhập Google thất bại: ${e.toString()}');
    } finally {
      hideLoading();
    }
  }

  Future<void> loginWithMicrosoft() async {
    showLoading(message: 'Đang đăng nhập với Microsoft...');
    try {
      // TODO: Implement Microsoft login
      print('Login with Microsoft');
    } catch (e) {
      showError(message: 'Đăng nhập Microsoft thất bại: ${e.toString()}');
    } finally {
      hideLoading();
    }
  }

  Future<void> logout() async {
    showLoading(message: 'Đang đăng xuất...');
    try {
      await clearUserData();
      hideLoading();
      await Get.offAllNamed(RouterName.login);
    } catch (e) {
      hideLoading();
      showError(message: 'Đăng xuất thất bại: ${e.toString()}');
    }
  }
}