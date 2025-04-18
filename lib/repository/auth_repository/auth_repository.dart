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
      await prefs.setString('userId', loginResponse.user.userId);
      await prefs.setString('userEmail', loginResponse.user.email);
      await prefs.setString('userName', loginResponse.user.username);
      await prefs.setString('fullName', loginResponse.user.fullName);
      if (loginResponse.user.role != null) {
        await prefs.setString('userRole', loginResponse.user.role!);
      }

      return loginResponse;
    } catch (e) {
      print('Login error: ${e.toString()}');
      rethrow;
    }
  }

  Future<RegisterResponse> register({
    required String username,
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    String? referralCode, // Thêm tham số này
  }) async {
    try {
      final registerRequest = RegisterRequest(
        username: username,
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
        referralCode: referralCode, // Truyền mã giới thiệu
      );

      final response = await _apiService.post(
        Endpoints.register,
        data: registerRequest.toJson(),
        options: _options,
      );

      final registerResponse = RegisterResponse.fromJson(response);

      return registerResponse;
    } catch (e) {
      print('Registration error: ${e.toString()}');
      rethrow;
    }
  }

  Future<Profile> getProfile() async {
    try {
      final response = await _apiService.get(
        Endpoints.profile,
      );
      print("Profile API response: $response");
      if (response != null && response is Map) {
        if (response.containsKey('data')) {
          final data = response['data'];
          if (data is List && data.isNotEmpty) {
            return Profile.fromJson(data[0]);
          } else if (data is Map) {
            return Profile.fromJson(data.cast<String, dynamic>());
          }
        }
      }
      // Fallback - try to parse the entire response as a Profile
      return Profile.fromJson(response);
    } catch (e) {
      print('Get profile error: ${e.toString()}');
      rethrow;
    }
  }

  Future<Profile> updateProfile({
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      // Tạo body request
      final updateData = {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
      };

      // Call API với token từ header
      final response = await _apiService.put(
        Endpoints.updateProfile,
        data: updateData,
      );
      print('Update profile response: $response');
      if (response != null && response is Map) {
        Profile updatedProfile;
        if (response.containsKey('data')) {
          updatedProfile = Profile.fromJson(
              (response['data'] as Map).cast<String, dynamic>());
        } else {
          updatedProfile = Profile.fromJson((response).cast<String, dynamic>());
        }
        final prefs = Get.find<SharedPreferences>();
        await prefs.setString('fullName', updatedProfile.fullName);
        return updatedProfile;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Update profile error: ${e.toString()}');
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

  // Phương thức xác thực email sau đăng ký
  Future<void> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    try {
      // In ra thông tin debug
      print('Verifying email: $email with code: $verificationCode');

      final response = await _apiService.post(
        Endpoints.verifyEmail,
        data: {
          'email': email,
          'code': verificationCode,
        },
        options: _options, // Sử dụng options không yêu cầu token
      );

      // In ra phản hồi để debug
      print('Verification response: $response');

      // Kiểm tra phản hồi
      if (response != null && response is Map) {
        int statusCode = response['statusCode'] ?? 0;

        // Nếu xác thực thành công, có thể lưu thông tin người dùng nếu có
        if (statusCode == 200 || statusCode == 201) {
          return;
        } else {
          String errorMessage =
              response['message'] ?? 'Xác thực không thành công';
          throw Exception(errorMessage);
        }
      } else {
        throw Exception('Định dạng phản hồi không hợp lệ');
      }
    } catch (e) {
      print('Email verification error: ${e.toString()}');
      rethrow; // Ném lỗi để xử lý ở tầng Controller
    }
  }

// Add a function to resend verification code
  Future<void> resendEmailVerification({
    required String email,
  }) async {
    try {
      await _apiService.post(
        Endpoints.resendEmailVerification,
        data: {
          'email': email,
        },
        options: _options,
      );
    } catch (e) {
      print('Resend verification error: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      // Xóa dữ liệu lưu trữ
      final prefs = Get.find<SharedPreferences>();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
      await prefs.remove('userId');
      await prefs.remove('userEmail');
      await prefs.remove('userName');
      await prefs.remove('fullName');
      await prefs.remove('userRole');
      await prefs.remove('registerToken');
      await prefs.remove('pendingVerificationEmail');

      // Tùy chọn: Gọi API logout nếu cần
      try {
        await _apiService.post(Endpoints.logout);
      } catch (e) {
        // Không làm gì nếu API logout thất bại
        print('API logout failed, but local logout succeeded');
      }
    } catch (e) {
      print('Logout error: ${e.toString()}');
      rethrow;
    }
  }
}
