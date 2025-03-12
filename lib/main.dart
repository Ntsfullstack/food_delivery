// main.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/routes/pages.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/notification/app_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs, permanent: true);

  // Check if user is logged in
  final accessToken = prefs.getString('accessToken');
  final initialRoute = accessToken != null ? RouterName.bottomNavigation : RouterName.login;

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(YumQuickApp(initialRoute: initialRoute));
}

class YumQuickApp extends StatelessWidget {
  final String initialRoute;

  const YumQuickApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) {
          return GetMaterialApp(
            initialBinding: AppBinding(),
            debugShowCheckedModeBanner: false,
            title: 'YumQuick',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: initialRoute,
            getPages: Pages.pages(),
          );
        },
      ),
    );
  }
}

// LogoPainter class remains the same
class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final Path path = Path();

    // Draw heart shape
    path.moveTo(size.width * 0.5, size.height * 0.3);
    path.cubicTo(
        size.width * 0.2, size.height * 0.1,
        size.width * 0.1, size.height * 0.4,
        size.width * 0.5, size.height * 0.7
    );
    path.cubicTo(
        size.width * 0.9, size.height * 0.4,
        size.width * 0.8, size.height * 0.1,
        size.width * 0.5, size.height * 0.3
    );

    // Draw fork handle
    path.moveTo(size.width * 0.7, size.height * 0.4);
    path.lineTo(size.width * 0.8, size.height * 0.5);

    // Draw spoon handle
    path.moveTo(size.width * 0.3, size.height * 0.4);
    path.lineTo(size.width * 0.2, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}