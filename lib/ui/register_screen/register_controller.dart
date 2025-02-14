import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RegisterController extends GetxController {
  var fullName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var mobileNumber = ''.obs;
  var dateOfBirth = ''.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool validateForm() {
    if (fullName.isEmpty || email.isEmpty || password.isEmpty ||
        mobileNumber.isEmpty || dateOfBirth.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (!GetUtils.isEmail(email.value)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }

  void signUp() {
    if (validateForm()) {
      // TODO: Implement sign up logic
      print('Sign up successful');
    }
  }
}