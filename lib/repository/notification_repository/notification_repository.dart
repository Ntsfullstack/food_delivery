// import 'package:dio/dio.dart';
// import '../../base/networking/api_response.dart';
// import '../../models/notification/notification.dart';
// import '../../x_res/my_config.dart';
//
// class NotificationRepository {
//   final Dio _dio;
//
//   NotificationRepository(this._dio);
//
//   /// Get notifications for current user
//   Future<ApiResponse<List<NotificationModel>>> getNotifications({
//     int page = 1,
//     int limit = 20,
//   }) async {
//     try {
//       final response = await _dio.get(
//         '${MyConfig.baseUrl}/api/notifications',
//         queryParameters: {
//           'page': page,
//           'limit': limit,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final data = response.data;
//         final items = (data['data']['items'] as List?)
//             ?.map((item) => NotificationModel.fromJson(item))
//             .toList() ?? [];
//
//         return ApiResponse<List<NotificationModel>>(
//           statusCode: response.statusCode!,
//           data: items,
//           message: data['message'] ?? 'Success',
//         );
//       } else {
//         return ApiResponse<List<NotificationModel>>(
//           statusCode: response.statusCode!,
//           message: response.data['message'] ?? 'Failed to get notifications',
//         );
//       }
//     } catch (e) {
//       throw Exception('Failed to get notifications: $e');
//     }
//   }
//
//   /// Mark notification as read
//   Future<ApiResponse<bool>> markAsRead(String notificationId) async {
//     try {
//       final response = await _dio.put(
//         '${MyConfig.baseUrl}/api/notifications/$notificationId/read',
//       );
//
//       return ApiResponse<bool>(
//         statusCode: response.statusCode!,
//         data: response.statusCode == 200,
//         message: response.data['message'] ?? 'Success',
//       );
//     } catch (e) {
//       throw Exception('Failed to mark notification as read: $e');
//     }
//   }
//
//   /// Mark all notifications as read
//   Future<ApiResponse<bool>> markAllAsRead() async {
//     try {
//       final response = await _dio.put(
//         '${MyConfig.baseUrl}/api/notifications/mark-all-read',
//       );
//
//       return ApiResponse<bool>(
//         statusCode: response.statusCode!,
//         data: response.statusCode == 200,
//         message: response.data['message'] ?? 'Success',
//       );
//     } catch (e) {
//       throw Exception('Failed to mark all notifications as read: $e');
//     }
//   }
//
//   /// Send notification to user (admin only)
//   Future<ApiResponse<bool>> sendNotification({
//     required String userId,
//     required String title,
//     required String content,
//     String? type,
//     String? referenceId,
//     String? priority,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '${MyConfig.baseUrl}/api/notifications/notify',
//         data: {
//           'userId': userId,
//           'title': title,
//           'content': content,
//           'data': {
//             if (type != null) 'type': type,
//             if (referenceId != null) 'referenceId': referenceId,
//             if (priority != null) 'priority': priority,
//           },
//         },
//       );
//
//       return ApiResponse<bool>(
//         statusCode: response.statusCode!,
//         data: response.statusCode == 200,
//         message: response.data['message'] ?? 'Success',
//       );
//     } catch (e) {
//       throw Exception('Failed to send notification: $e');
//     }
//   }
//
//   /// Send notification to admins
//   Future<ApiResponse<bool>> sendToAdmins({
//     required String title,
//     required String content,
//     String? type,
//     String? referenceId,
//     String? priority,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '${MyConfig.baseUrl}/api/sse/send-to-admins',
//         data: {
//           'data': {
//             'title': title,
//             'content': content,
//             if (type != null) 'type': type,
//             if (referenceId != null) 'referenceId': referenceId,
//             if (priority != null) 'priority': priority,
//           },
//         },
//       );
//
//       return ApiResponse<bool>(
//         statusCode: response.statusCode!,
//         data: response.statusCode == 200,
//         message: response.data['message'] ?? 'Success',
//       );
//     } catch (e) {
//       throw Exception('Failed to send notification to admins: $e');
//     }
//   }
//
//   /// Broadcast notification to all users
//   Future<ApiResponse<bool>> broadcast({
//     required String title,
//     required String content,
//     String? type,
//     String? referenceId,
//     String? priority,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '${MyConfig.baseUrl}/api/sse/broadcast',
//         data: {
//           'data': {
//             'title': title,
//             'content': content,
//             if (type != null) 'type': type,
//             if (referenceId != null) 'referenceId': referenceId,
//             if (priority != null) 'priority': priority,
//           },
//         },
//       );
//
//       return ApiResponse<bool>(
//         statusCode: response.statusCode!,
//         data: response.statusCode == 200,
//         message: response.data['message'] ?? 'Success',
//       );
//     } catch (e) {
//       throw Exception('Failed to broadcast notification: $e');
//     }
//   }
//
//   /// Get connected clients count (admin only)
//   Future<ApiResponse<Map<String, dynamic>>> getConnectedClientsCount() async {
//     try {
//       final response = await _dio.get(
//         '${MyConfig.baseUrl}/api/sse/clients-count',
//       );
//
//       if (response.statusCode == 200) {
//         return ApiResponse<Map<String, dynamic>>(
//           statusCode: response.statusCode!,
//           data: response.data['data'] ?? {},
//           message: response.data['message'] ?? 'Success',
//         );
//       } else {
//         return ApiResponse<Map<String, dynamic>>(
//           statusCode: response.statusCode!,
//           message: response.data['message'] ?? 'Failed to get clients count',
//         );
//       }
//     } catch (e) {
//       throw Exception('Failed to get connected clients count: $e');
//     }
//   }
// }
