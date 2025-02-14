// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
//
// import 'notification_controller.dart';
//
// class FirebaseNotification {
//   FirebaseMessaging? _messaging;
//   final AppController _notificationController = Get.find();
//
//   Future<void> setupFirebase() async {
//     _messaging = FirebaseMessaging.instance;
//     NotificationHandler.initNotification();
//     FlutterAppBadger.removeBadge();
//     firebaseCloudMessengerListener();
//   }
//
//   void firebaseCloudMessengerListener() async {
//     NotificationSettings setting = await _messaging!.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: false,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     _messaging!.getToken().then((value) {
//       print('FCM token 321 : $value');
//       _notificationController.tokenFCM = value ?? '';
//     });
//
//     FirebaseMessaging.onMessage.listen((event) {
//       print('onMessage');
//       showNotification(event.notification!.title, event.notification!.body);
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       print('open app');
//       showNotification(event.notification!.title, event.notification!.body);
//       ///TODO: navigate
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (event.data['type'] == "1") {
//           Get.until((route) => route.isFirst);
//         } else
//           _showDialog(event);
//       });
//     });
//   }
//
//   void _showDialog(RemoteMessage event) {
//     Get.dialog(CupertinoAlertDialog(
//       title: Text(event.notification?.title ?? ''),
//       content: Text(event.notification?.body ?? ''),
//       actions: [
//         CupertinoDialogAction(
//           child: Text('Ok'),
//           isDefaultAction: true,
//           onPressed: () {
//             Get.back();
//           },
//         )
//       ],
//     ));
//   }
//
//   void showNotification(String? title, String? body) async {
//     var androidChannel = AndroidNotificationDetails(
//         'com.staron.senpos', // id
//         'High Importance Notifications', // title
//         autoCancel: false,
//         ongoing: false,
//         importance: Importance.max,
//         playSound: true,
//         priority: Priority.max);
//     var iosChannel = DarwinNotificationDetails();
//     var platForm =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);
//     await NotificationHandler.flutterLocalNotificationPlugin
//         .show(0, title, body, platForm, payload: "may palyload");
//   }
// }
//
// class NotificationHandler {
//   static final flutterLocalNotificationPlugin =
//       FlutterLocalNotificationsPlugin();
//   static BuildContext? context;
//
//   static void initNotification() {
//
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = DarwinInitializationSettings();
//     final InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//
//     // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     // var initIOS = DarwinNotificationDetails(
//     //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     // var initSetting =
//     //     InitializationSettings(android: initAndroid, iOS: initIOS);
//     flutterLocalNotificationPlugin.initialize(initializationSettings);
//   }
//
//   static Future onSelectNotification(String? payload) async {
//     if (payload != null) print('Get payload $payload');
//   }
//
//   static Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     Get.dialog(CupertinoAlertDialog(
//       title: Text(title!),
//       content: Text(body!),
//       actions: [
//         CupertinoDialogAction(
//           child: Text('Ok'),
//           isDefaultAction: true,
//           onPressed: () {},
//         )
//       ],
//     ));
//   }
// }
