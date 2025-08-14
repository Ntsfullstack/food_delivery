// main.dart
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/routes/pages.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'base/notification/app_binding.dart';
import 'x_res/my_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs, permanent: true);

  final accessToken = prefs.getString('accessToken');
  final userRole = prefs.getString('userRole');

  String initialRoute;
  if (accessToken != null) {
    switch (userRole) {
      case 'admin':
        initialRoute = RouterName.dashBoard;
        break;
      case 'customer':
      default:
        initialRoute = RouterName.bottomNavigation;
        break;
    }
  } else {
    initialRoute = RouterName.login;
  }

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  // Request permission first
  // await FirebaseMessaging.instance.requestPermission();

  String? fcmToken;

  // if (Platform.isIOS) {
  //   // For iOS, wait for APNS token to be available
  //   String? apnsToken;
  //   int retryCount = 0;
  //   const maxRetries = 10;
  //
  //   while (apnsToken == null && retryCount < maxRetries) {
  //     try {
  //       apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  //       if (apnsToken != null) {
  //         print('APNS Token: $apnsToken');
  //         break;
  //       }
  //     } catch (e) {
  //       print('Error getting APNS token: $e');
  //     }
  //
  //     retryCount++;
  //     await Future.delayed(Duration(seconds: 1));
  //   }
  //
  //   if (apnsToken == null) {
  //     print('Warning: Could not get APNS token after $maxRetries attempts');
  //   }
  // }

  // Now get FCM token
  // try {
  //   fcmToken = await FirebaseMessaging.instance.getToken();
  //   print('FCM Token: $fcmToken');
  // } catch (e) {
  //   print('Error getting FCM token: $e');
  //   fcmToken = null;
  // }

  // Resolve saved locale
  final savedLanguage = prefs.getString('selectedLanguage') ?? 'Tiếng Việt';
  Locale initialLocale;
  switch (savedLanguage) {
    case 'English':
      initialLocale = const Locale('en', 'US');
      break;
    case '日本語':
      initialLocale = const Locale('ja', 'JP');
      break;
    case 'Tiếng Việt':
    default:
      initialLocale = const Locale('vi', 'VN');
  }

  runApp(YumQuickApp(initialRoute: initialRoute, fcmToken: fcmToken, initialLocale: initialLocale));
}

class YumQuickApp extends StatelessWidget {
  final String initialRoute;
  final String? fcmToken;
  final Locale initialLocale;

  const YumQuickApp({super.key, required this.initialRoute, this.fcmToken, required this.initialLocale});

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
            translations: MyTranslations(),
            locale: initialLocale,
            fallbackLocale: const Locale('en', 'US'),
            initialRoute: initialRoute,
            getPages: Pages.pages(),
            home: FcmTokenScreen(fcmToken: fcmToken),
          );
        },
      ),
    );
  }
}

class FcmTokenScreen extends StatelessWidget {
  final String? fcmToken;
  const FcmTokenScreen({super.key, this.fcmToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FCM Token')),
      body: Center(
        child: SelectableText(fcmToken ?? 'No token'),
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