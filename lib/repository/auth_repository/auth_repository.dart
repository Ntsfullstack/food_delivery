import 'package:dio/dio.dart';
import 'package:food_delivery_app/models/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../base/networking/constants/endpoint.dart';
import '../../models/login/login.dart';
import '../../base/networking/api.dart';
import 'package:get/get.dart';


class AuthRepository {
  final ApiService _apiService;

  AuthRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final _options = Options(
    headers: {
      "requiresToken": false,
    },
  );

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginRequest = LoginRequest(
        email: email,
        password: password,
      );

      final response = await _apiService.post(
        Endpoints.login,
        data: loginRequest.toJson(),
        options: _options,
      );

      final loginResponse = LoginResponse.fromJson(response);

      // Save tokens and user data
      final prefs = Get.find<SharedPreferences>();
      await prefs.setString('accessToken', loginResponse.accessToken);
      await prefs.setString('refreshToken', loginResponse.refreshToken);
      await prefs.setString('user', loginResponse.user.toJson().toString());

      return loginResponse;
    } catch (e) {
      print('Login error: ${e.toString()}');
      rethrow;
    }
  }

  Future<Profile> getProfile() async {
    try {
      final response = await _apiService.get(
        Endpoints.profile,
      );

      return Profile.fromJson(response);
    } catch (e) {
      print('Get profile error: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.post(
        Endpoints.changePassword,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );
    } catch (e) {
      print('Change password error: ${e.toString()}');
      throw e;
    }
  }

  Future<void> refreshToken(String refreshToken) async {
    try {
      final response = await _apiService.post(
        Endpoints.refreshToken,
        data: {
          'refreshToken': refreshToken,
        },
        options: _options,
      );

      // Save new tokens
      final prefs = Get.find<SharedPreferences>();
      await prefs.setString('accessToken', response['accessToken']);
      await prefs.setString('refreshToken', response['refreshToken']);
    } catch (e) {
      print('Refresh token error: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post(Endpoints.logout);
      
      // Clear stored data
      final prefs = Get.find<SharedPreferences>();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
      await prefs.remove('user');
    } catch (e) {
      print('Logout error: ${e.toString()}');
      rethrow;
    }
  }
}
