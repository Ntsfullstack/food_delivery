
// lib/views/login_screen.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/core/config/assets/app_images.dart';
import 'package:food_delivery_app/core/config/assets/app_vectors.dart';
import 'package:get/get.dart';

import '../../routes/router_name.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light yellow background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                 Text(
                  'NHÀ ĂN ĐẠI HỌC MỎ - ĐỊA CHẤT',
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 20.r,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Mã người dùng',
                  onChanged: (value) => controller.email.value = value,
                  hintText: 'Mã người dùng',
                ),
                const SizedBox(height: 20),
                _buildPasswordField(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implement forget password
                    },
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(
                        color: Color(0xFFE76F51),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => controller.login(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE76F51),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text('or sign up with'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      icon: AppVectors.google,
                      onTap: () => controller.loginWithGoogle(),
                    ),
                    const SizedBox(width: 20),
                    _buildSocialButton(
                      icon: AppVectors.microsoft,
                      onTap: () => controller.loginWithFacebook(),
                    ),

                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: Color(0xFFE76F51),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(RouterName.register);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3D5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mật khẩu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3D5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(
                () => TextField(
              obscureText: !controller.isPasswordVisible.value,
              onChanged: (value) => controller.password.value = value,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () => controller.togglePasswordVisibility(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
      ),
    );
  }




}



