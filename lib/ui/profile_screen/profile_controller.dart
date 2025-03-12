// profile_controller.dart
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
  
  final ImagePicker _picker = ImagePicker();
  final avatarPath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
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
      profile.value = response;
      
      // Set text controllers
      fullNameController.text = response.fullName;
      usernameController.text = response.username;
      emailController.text = response.email;
      phoneController.text = response.phoneNumber;
      
      hideLoading();
    } catch (e) {
      hideLoading();
      showError(message: 'Không thể tải thông tin: ${e.toString()}');
    }
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      // Reset text controllers to original values
      if (profile.value != null) {
        fullNameController.text = profile.value!.fullName;
        usernameController.text = profile.value!.username;
        emailController.text = profile.value!.email;
        phoneController.text = profile.value!.phoneNumber;
      }
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        avatarPath.value = image.path;
        // TODO: Implement avatar upload to server
      }
    } catch (e) {
      showError(message: 'Không thể chọn ảnh: ${e.toString()}');
    }
  }

  Future<void> updateProfile() async {
    if (!isEditing.value) return;

    try {
      showLoading(message: 'Đang cập nhật thông tin...');
      
      // TODO: Implement update profile API call
      // final updatedProfile = Profile(
      //   userID: profile.value!.userID,
      //   username: usernameController.text,
      //   email: emailController.text,
      //   fullName: fullNameController.text,
      //   phoneNumber: phoneController.text,
      // );
      // await authRepositories.updateProfile(updatedProfile);
      
      hideLoading();
      isEditing.value = false;
      Get.snackbar(
        'Thành công',
        'Cập nhật thông tin thành công',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      hideLoading();
      showError(message: 'Không thể cập nhật thông tin: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    // TODO: Implement logout logic
    Get.offAllNamed('/login'); // Navigate to login screen
  }
}



