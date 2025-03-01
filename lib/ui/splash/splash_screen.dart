import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/core/config/assets/app_images.dart';
import 'package:food_delivery_app/ui/splash/splash_controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.w,
              height: 200.h,
              child: Image.asset(
                AppImages.logo
              )
            ),
            const SizedBox(height: 20),
            const Text(
              'NHÀ ĂN HUMG',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}