import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/profile/profile.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends BaseController {
  final profile = Rxn<Profile>();
  final isEditing = false.obs;

  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();


  final ImagePicker _picker = ImagePicker();
  final avatarPath = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Kiểm tra xem có dữ liệu profile được truyền từ SettingsController không
    if (Get.arguments != null && Get.arguments['profile'] != null) {
      // Sử dụng profile đã được truyền
      profile.value = Get.arguments['profile'];

      // Hiển thị log để debug
      print("Profile được truyền qua arguments: ${profile.value?.fullName}");

      // Thiết lập text controllers
      if (profile.value != null) {
        fullNameController.text = profile.value!.fullName;
        usernameController.text = profile.value!.username;
        emailController.text = profile.value!.email;
        phoneController.text = profile.value!.phoneNumber;
        addressController.text = profile.value!.address;
      }
    } else {
      // Nếu không có dữ liệu truyền qua, tải profile từ API
      print("Không nhận được profile từ arguments, đang tải từ API...");
      loadProfile();
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> loadProfile() async {
    try {
      showLoading(message: 'Đang tải thông tin...');

      final response = await authRepositories.getProfile();
      print("Tải profile từ API thành công: ${response.fullName}");

      profile.value = response;

      // Thiết lập text controllers
      fullNameController.text = response.fullName;
      usernameController.text = response.username;
      emailController.text = response.email;
      phoneController.text = response.phoneNumber;
      addressController.text = response.address;

      hideLoading();
    } catch (e) {
      hideLoading();
      print("Lỗi khi tải profile: $e");
      showError(message: 'Không thể tải thông tin: ${e.toString()}');
    }
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      if (profile.value != null) {
        fullNameController.text = profile.value!.fullName;
        usernameController.text = profile.value!.username;
        emailController.text = profile.value!.email;
        phoneController.text = profile.value!.phoneNumber;
        addressController.text = profile.value!.address;
      }
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        avatarPath.value = image.path;
        // TODO: Implement avatar upload to server
        print("Đã chọn ảnh: ${image.path}");
      }
    } catch (e) {
      print("Lỗi khi chọn ảnh: $e");
      showError(message: 'Không thể chọn ảnh: ${e.toString()}');
    }
  }

  Future<void> updateProfile() async {
    if (!isEditing.value) return;

    try {
      showLoading(message: 'Đang cập nhật thông tin...');
      if (fullNameController.text.isEmpty) {
        hideLoading();
        showError(message: 'Họ và tên không được để trống');
        return;
      }

      if (phoneController.text.isEmpty) {
        hideLoading();
        showError(message: 'Số điện thoại không được để trống');
        return;
      }

      // Gọi API cập nhật thông tin profile
      final updatedProfile = await authRepositories.updateProfile(
        fullName: fullNameController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
      );
      profile.value = updatedProfile;
      loadProfile();
      hideLoading();
      isEditing.value = false;
      Get.snackbar(
        'Thành công',
        'Cập nhật thông tin thành công',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
      );
    } catch (e) {
      hideLoading();
      print("Lỗi khi cập nhật profile: $e");
      showError(message: 'Không thể cập nhật thông tin: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      showLoading(message: 'Đang đăng xuất...');

      // Gọi API logout và xóa dữ liệu local
      await authRepositories.logout();

      hideLoading();

      // Chuyển về màn hình đăng nhập
      Get.offAllNamed('/login');
    } catch (e) {
      hideLoading();
      showError(message: 'Không thể đăng xuất: ${e.toString()}');
    }
  }
}