import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/profile/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';


class ProfileController extends BaseController {
  static const String PROFILE_CACHE_KEY = 'profile_cache';
  
  // Static instance để có thể truy cập từ bất kỳ đâu
  static ProfileController? _instance;
  static ProfileController get instance {
    _instance ??= Get.find<ProfileController>();
    return _instance!;
  }

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
    _instance = this;
    // Luôn load profile mới khi vào màn hình
    loadProfile();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    _instance = null;
    super.onClose();
  }

  void _updateControllers() {
    if (profile.value != null) {
      fullNameController.text = profile.value!.fullName;
      usernameController.text = profile.value!.username;
      emailController.text = profile.value!.email;
      phoneController.text = profile.value!.phoneNumber;
      addressController.text = profile.value!.address;

      // Cache profile data
      final box = GetStorage();
      box.write(PROFILE_CACHE_KEY, profile.value!.toJson());
    }
  }

  Future<void> loadProfile() async {
    try {
      // Lấy dữ liệu mới từ API
      final response = await authRepositories.getProfile();
      
      // Cập nhật state và cache
      profile.value = response;
      _updateControllers();
    } catch (e) {
      // Sử dụng addPostFrameCallback để hiển thị lỗi sau khi build hoàn tất
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showError(message: 'Không thể tải thông tin: ${e.toString()}');
      });
    }
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      _updateControllers();
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
      
      // Validation
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

      // Cập nhật profile
      final updatedProfile = await authRepositories.updateProfile(
        fullName: fullNameController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
      );

      // Cập nhật state và cache
      profile.value = updatedProfile;
      _updateControllers();
      isEditing.value = false;
      hideLoading();
      showSuccess(message: 'Cập nhật thông tin thành công');

      // Reload để đảm bảo dữ liệu đồng bộ
      await loadProfile();
    } catch (e) {
      hideLoading();
      showError(message: 'Không thể cập nhật thông tin: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      showLoading(message: 'Đang đăng xuất...');
      await authRepositories.logout();
      
      // Clear cache when logging out
      final box = GetStorage();
      await box.remove(PROFILE_CACHE_KEY);
      
      hideLoading();
      Get.offAllNamed('/login');
    } catch (e) {
      hideLoading();
      showError(message: 'Không thể đăng xuất: ${e.toString()}');
    }
  }

  // Method để các màn hình khác có thể cập nhật profile
  void updateProfileData(Profile newProfile) {
    profile.value = newProfile;
    _updateControllers();
  }
}