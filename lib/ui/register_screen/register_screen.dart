import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/core/config/assets/app_images.dart';
import 'package:food_delivery_app/core/config/assets/app_vectors.dart';
import 'package:food_delivery_app/ui/register_screen/register_controller.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<RegisterController> {


  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white, // Light yellow background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'ĐĂNG KÍ TÀI KHOẢN',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              label: 'Full name',
              onChanged: (value) => controller.fullName.value = value,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            _buildPasswordField(),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Email',
              onChanged: (value) => controller.email.value = value,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Mobile Number',
              onChanged: (value) => controller.mobileNumber.value = value,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildDateField(),
            const SizedBox(height: 24),
            _buildTermsAndPrivacy(),
            const SizedBox(height: 16),
            _buildSignUpButton(),
            const SizedBox(height: 16),
            _buildSocialSignUp(),
            const SizedBox(height: 16),
            _buildLoginLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color:  Colors.white70
        , // Light yellow background
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEF0CD),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        obscureText: !controller.isPasswordVisible.value,
        onChanged: (value) => controller.password.value = value,
        decoration: InputDecoration(
          labelText: 'Password',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
        ),
      ),
    ));
  }

  Widget _buildDateField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEF0CD),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: (value) => controller.dateOfBirth.value = value,
        decoration: const InputDecoration(
          labelText: 'Date of birth',
          hintText: 'DD / MM / YYYY',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildTermsAndPrivacy() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          const TextSpan(text: 'By continuing, you agree to '),
          TextSpan(
            text: 'Terms of Use',
            style: const TextStyle(color: Colors.deepOrange),
            recognizer: TapGestureRecognizer()..onTap = () {
              // TODO: Navigate to Terms of Use
            },
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: const TextStyle(color: Colors.deepOrange),
            recognizer: TapGestureRecognizer()..onTap = () {
              // TODO: Navigate to Privacy Policy
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: controller.signUp,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSocialSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          AppVectors.google
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          AppVectors.microsoft
            ),
      ],
    );
  }

  Widget _buildSocialButton(String imagePath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SvgPicture.asset(
        imagePath,
        width: 24,
        height: 24,
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? '),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to login screen
          },
          child: const Text(
            'Log in',
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}