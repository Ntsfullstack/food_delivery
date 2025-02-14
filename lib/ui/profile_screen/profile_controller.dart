// profile_controller.dart
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxString userName = 'John Doe'.obs;
  final RxString email = 'john.doe@example.com'.obs;
  final RxString phoneNumber = '+84 123 456 789'.obs;
  final RxString address = '123 Street Name, City'.obs;
  final RxBool isEditing = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Temporary variables for editing
  String tempName = '';
  String tempEmail = '';
  String tempPhone = '';
  String tempAddress = '';

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    // TODO: Load user data from your storage/API
    // For now using dummy data
    userName.value = 'John Doe';
    email.value = 'john.doe@example.com';
    phoneNumber.value = '+84 123 456 789';
    address.value = '123 Street Name, City';
  }

  void startEditing() {
    tempName = userName.value;
    tempEmail = email.value;
    tempPhone = phoneNumber.value;
    tempAddress = address.value;
    isEditing.value = true;
  }

  void cancelEditing() {
    isEditing.value = false;
  }

  Future<void> saveChanges() async {
    // TODO: Implement API call to save changes
    userName.value = tempName;
    email.value = tempEmail;
    phoneNumber.value = tempPhone;
    address.value = tempAddress;

    isEditing.value = false;

    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = File(image.path);
      // TODO: Implement image upload to your backend
    }
  }

  Future<void> logout() async {
    // TODO: Implement logout logic
    Get.offAllNamed('/login'); // Navigate to login screen
  }
}



