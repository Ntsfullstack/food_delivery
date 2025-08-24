// import 'package:get/get.dart';
// import '../../repository/notification_repository/notification_repository.dart';
// import '../../service/sse_notification_service.dart';
// import 'notification_controller.dart';
//
// class NotificationBinding extends Bindings {
//   @override
//   void dependencies() {
//     // Register SSE service as singleton if not already registered
//     if (!Get.isRegistered<SSENotificationService>()) {
//       Get.put<SSENotificationService>(SSENotificationService(), permanent: true);
//     }
//
//     // Register notification repository
//     Get.lazyPut<NotificationRepository>(
//       () => NotificationRepository(Get.find()),
//     );
//
//     // Register notification controller
//     Get.lazyPut<NotificationController>(
//       () => NotificationController(Get.find<NotificationRepository>()),
//     );
//   }
// }
