import 'package:dio/dio.dart';
import 'package:food_delivery_app/models/users/users.dart';
import 'package:food_delivery_app/base/networking/api.dart';
import 'package:food_delivery_app/base/networking/constants/endpoint.dart';

class UsersRepository {
  final ApiService _apiService;

  UsersRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  // Lấy danh sách tất cả người dùng
  Future<List<Users>> getAllUsers() async {
    try {
      final response = await _apiService.get(
        Endpoints.getAllUsers,
      );

      // Kiểm tra cấu trúc response
      if (response != null && response is Map) {
        if (response.containsKey('data')) {
          final List<dynamic> usersData = response['data'];
          return usersData.map((user) =>
              Users.fromJson(user as Map<String, dynamic>)
          ).toList();
        }
      } else if (response != null && response is List) {
        return response.map((user) =>
            Users.fromJson(user as Map<String, dynamic>)
        ).toList();
      }
      throw Exception('Invalid response format');
    } catch (e) {
      print('Get all users error: ${e.toString()}');
      rethrow;
    }
  }

  // Lấy danh sách khách hàng (role = customer)
  Future<List<Users>> getCustomers() async {
    try {
      final response = await _apiService.get(
        '${Endpoints.getAllUsers}?role=customer',
      );

      // Kiểm tra cấu trúc response
      if (response != null && response is Map) {
        if (response.containsKey('data')) {
          final List<dynamic> usersData = response['data'];
          return usersData.map((user) =>
              Users.fromJson(user as Map<String, dynamic>)
          ).toList();
        }
      } else if (response != null && response is List) {
        return response.map((user) =>
            Users.fromJson(user as Map<String, dynamic>)
        ).toList();
      }
      throw Exception('Invalid response format');
    } catch (e) {
      print('Get customers error: ${e.toString()}');
      rethrow;
    }
  }

  // Lấy chi tiết người dùng theo ID
  Future<Users> getUserById(String userId) async {
    try {
      final response = await _apiService.get(
        '${Endpoints.getAllUsers}/$userId',
      );

      // Kiểm tra cấu trúc response
      if (response != null && response is Map) {
        if (response.containsKey('data')) {
          return Users.fromJson(response['data'] as Map<String, dynamic>);
        } else {
          return Users.fromJson(response as Map<String, dynamic>);
        }
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Get user by ID error: ${e.toString()}');
      rethrow;
    }
  }


  // Cập nhật thông tin người dùng
  Future<Users> updateUser(String userId, Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.put(
        '${Endpoints.updateUsers}/$userId/role',
        data: userData,
      );

      // Kiểm tra cấu trúc response
      if (response != null && response is Map) {
        if (response.containsKey('data')) {
          return Users.fromJson(response['data'] as Map<String, dynamic>);
        } else {
          return Users.fromJson(response as Map<String, dynamic>);
        }
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Update user error: ${e.toString()}');
      rethrow;
    }
  }

  // Xóa người dùng
  Future<bool> deleteUser(String userId) async {
    try {
      await _apiService.delete(
        '${Endpoints.deleteUser}/$userId',
      );

      // Một số API trả về thông báo thành công hoặc status code 204 (No Content)
      return true;
    } catch (e) {
      print('Delete user error: ${e.toString()}');
      rethrow;
    }
  }
}