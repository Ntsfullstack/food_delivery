import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/users/users.dart';



class CustomerController extends BaseController {
  // Observable properties
  final users = <Users>[].obs;
  final filteredUsers = <Users>[].obs;
  final allUsers = <Users>[]; // Backup of all users for filtering
  final sortOption = 'Mới nhất'.obs;
  final searchQuery = ''.obs;
  final selectedRole = Rxn<String>();

  @override
  void onInit() {
    print("CustomerController onInit - START");
    print("Is logged in: ${_isUserLoggedIn()}");

    if (_isUserLoggedIn()) {
      super.onInit();
      loadUsers();
    } else {
      print("Chưa đăng nhập - không thể tải danh sách người dùng");
    }

    print("CustomerController onInit - END");
  }

  bool _isUserLoggedIn() {
    final prefs = Get.find<SharedPreferences>();
    final token = prefs.getString('accessToken');
    return token != null;
  }

  Future<void> loadUsers() async {
    try {
      if (!_isUserLoggedIn()) {
        showError(message: 'Vui lòng đăng nhập');
        return;
      }

      print("Bắt đầu tải danh sách người dùng");
      final customers = await usersRepositories.getCustomers();

      print("Số lượng khách hàng: ${customers.length}");

      allUsers.clear();
      allUsers.addAll(customers);

      filterUsers();
    } catch (e) {
      print("Lỗi tải danh sách người dùng: $e");
      showError(message: 'Không thể tải danh sách khách hàng');
    }
  }

  void showEditUserDialog(Users user) {
    final formKey = GlobalKey<FormState>();
    final fullNameController = TextEditingController(text: user.fullName);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phoneNumber);

    Get.dialog(
      AlertDialog(
        title: Text(
          'Chỉnh sửa thông tin khách hàng',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Họ và tên',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ tên';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(),
                  ),
                  enabled: false, // Email không thể thay đổi
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: GoogleFonts.poppins(),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  // Hiển thị loading
                  showLoading(message: 'Đang cập nhật thông tin...');

                  // Tạo dữ liệu cập nhật
                  final userData = {
                    'fullName': fullNameController.text,
                    'phoneNumber': phoneController.text,
                  };

                  // Gọi API để cập nhật thông tin người dùng
                  final updatedUser = await usersRepositories.updateUser(user.userId, userData);

                  // Cập nhật thông tin trong danh sách
                  final index = allUsers.indexWhere((u) => u.userId == user.userId);
                  if (index != -1) {
                    allUsers[index] = updatedUser;
                    filterUsers();
                  }

                  // Ẩn loading và đóng dialog
                  hideLoading();
                  Get.back();

                  // Hiển thị thông báo thành công
                  showSuccess(message: 'Cập nhật thông tin khách hàng thành công');
                } catch (e) {
                  // Ẩn loading và hiển thị lỗi
                  hideLoading();
                  showError(message: 'Không thể cập nhật thông tin: ${e.toString()}');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7043),
            ),
            child: Text(
              'Lưu',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

// Cập nhật phương thức showDeleteConfirmation() để sử dụng API
  void showDeleteConfirmation(Users user) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Xác nhận xóa',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: Text(
          'Bạn có chắc chắn muốn xóa khách hàng "${user.fullName}" không?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: GoogleFonts.poppins(),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                // Hiển thị loading
                showLoading(message: 'Đang xóa khách hàng...');

                // Gọi API để xóa người dùng
                final success = await usersRepositories.deleteUser(user.userId);

                if (success) {
                  // Xóa người dùng khỏi danh sách
                  final index = allUsers.indexWhere((u) => u.userId == user.userId);
                  if (index != -1) {
                    allUsers.removeAt(index);
                    filterUsers();
                  }

                  // Ẩn loading và đóng dialog
                  hideLoading();
                  Get.back();

                  // Hiển thị thông báo thành công
                  showSuccess(message: 'Xóa khách hàng thành công');
                } else {
                  // Ẩn loading và hiển thị lỗi
                  hideLoading();
                  Get.back();
                  showError(message: 'Không thể xóa khách hàng');
                }
              } catch (e) {
                // Ẩn loading và hiển thị lỗi
                hideLoading();
                Get.back();
                showError(message: 'Không thể xóa khách hàng: ${e.toString()}');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Xóa',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Filter users based on search query and role
  void filterUsers() {
    List<Users> result = List.from(allUsers);

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      result = result.where((user) {
        return user.fullName.toLowerCase().contains(query) ||
            user.email.toLowerCase().contains(query) ||
            user.phoneNumber.contains(query);
      }).toList();
    }

    // Apply role filter
    if (selectedRole.value != null) {
      result = result.where((user) =>
      user.role.toLowerCase() == selectedRole.value!.toLowerCase()
      ).toList();
    }

    // Update filtered users
    users.value = result;

    // Apply sort
    sortUsers();
  }

  // Sort users based on selected option
  void sortUsers() {
    final List<Users> sortedList = List.from(users);

    switch (sortOption.value) {
      case 'Mới nhất':
      // Assuming userId is incrementing with newer users having larger IDs
        sortedList.sort((a, b) => b.userId.compareTo(a.userId));
        break;
      case 'Cũ nhất':
        sortedList.sort((a, b) => a.userId.compareTo(b.userId));
        break;
      case 'A-Z':
        sortedList.sort((a, b) => a.fullName.compareTo(b.fullName));
        break;
      case 'Z-A':
        sortedList.sort((a, b) => b.fullName.compareTo(a.fullName));
        break;
    }

    users.value = sortedList;
  }

  // View user details
  void viewUserDetails(Users user) {
    // Navigate to user details screen
    // Get.toNamed('/user-details', arguments: {'user': user});

    // For demo, show a simple dialog
    Get.dialog(
      AlertDialog(
        title: Text(
          'Thông tin người dùng',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailItem('ID', user.userId),
              _buildDetailItem('Họ tên', user.fullName),
              _buildDetailItem('Email', user.email),
              _buildDetailItem('SĐT', user.phoneNumber),
              _buildDetailItem('Vai trò', user.role.toUpperCase()),
              if (user.referralCode != null)
                _buildDetailItem('Mã giới thiệu', user.referralCode!),
              if (user.walletBalance != null)
                _buildDetailItem('Số dư ví', '${user.walletBalance!.toStringAsFixed(0)} VNĐ'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Đóng',
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build detail item
  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  // Show add user dialog
  void showAddUserDialog() {
    final formKey = GlobalKey<FormState>();
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final roleController = 'customer'.obs;

    Get.dialog(
      AlertDialog(
        title: Text(
          'Thêm người dùng mới',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Họ và tên',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ tên';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(() => DropdownButtonFormField<String>(
                  value: roleController.value,
                  decoration: InputDecoration(
                    labelText: 'Vai trò',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: 'customer', child: Text('Khách hàng')),
                    DropdownMenuItem(value: 'restaurant', child: Text('Nhà hàng')),
                    DropdownMenuItem(value: 'driver', child: Text('Tài xế')),
                    DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  ],
                  onChanged: (value) {
                    roleController.value = value!;
                  },
                )),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Hủy',
              style: GoogleFonts.poppins(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // In a real app, call API to create user
                // For demo, add to local list
                final newUserId = (int.parse(allUsers.last.userId) + 1).toString();
                final newUser = Users(
                  userId: newUserId,
                  username: emailController.text.split('@')[0],
                  email: emailController.text,
                  fullName: fullNameController.text,
                  phoneNumber: phoneController.text,
                  role: roleController.value,
                );

                allUsers.add(newUser);
                filterUsers();

                Get.back();
                showSuccess(message: 'Thêm người dùng thành công');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7043),
            ),
            child: Text(
              'Thêm',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Refresh dashboard data
  Future<void> refreshDashboard() async {
    return loadUsers();
  }
}