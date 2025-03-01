// main.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/routes/pages.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'base/notification/app_binding.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();


    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

    runApp(const YumQuickApp());
  } catch (e) {
    print('Error initializing application: $e');
  }
}

class YumQuickApp extends StatelessWidget {
  const YumQuickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) {
          return GetMaterialApp(
            title: 'YumQuick',
            initialRoute: '/splash',
            debugShowCheckedModeBanner: false,
            initialBinding: AppBinding(),
            getPages: Pages.pages(),
            // theme: ThemeData(
            //   primaryColor: const Color(0xFFFFD700),
            //   scaffoldBackgroundColor: const Color(0xFFFFD700),
            // ),
          );
        },
      ),
    );
  }
}

// splash_controller.dart

// splash_binding.dart

// splash_screen.dart


// logo_painter.dart
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