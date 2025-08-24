// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../x_utils/get_storage_util.dart';
// import '../x_res/my_config.dart';
//
// class SSENotificationService extends GetxService {
//   static SSENotificationService get instance => Get.find<SSENotificationService>();
//
//   StreamSubscription<Map<String, dynamic>>? _sseSubscription;
//   final RxBool _isConnected = false.obs;
//   final RxList<Map<String, dynamic>> _notifications = <Map<String, dynamic>>[].obs;
//   Timer? _reconnectTimer;
//   int _reconnectAttempts = 0;
//   static const int _maxReconnectAttempts = 5;
//   static const Duration _reconnectDelay = Duration(seconds: 5);
//
//   // Getters
//   bool get isConnected => _isConnected.value;
//   List<Map<String, dynamic>> get notifications => _notifications;
//   Stream<bool> get connectionStream => _isConnected.stream;
//   Stream<List<Map<String, dynamic>>> get notificationsStream => _notifications.stream;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Auto connect when service is initialized
//     _autoConnect();
//   }
//
//   @override
//   void onClose() {
//     disconnect();
//     super.onClose();
//   }
//
//   /// Auto connect if user is logged in
//   void _autoConnect() {
//     final token = GetStorageUtil.getToken();
//     if (token != null && token.isNotEmpty) {
//       connectToSSE();
//     }
//   }
//
//   /// Connect to SSE endpoint
//   Future<void> connectToSSE() async {
//     if (_isConnected.value) {
//       debugPrint('SSE: Already connected');
//       return;
//     }
//
//     final token = GetStorageUtil.getToken();
//     if (token == null || token.isEmpty) {
//       debugPrint('SSE: No auth token available');
//       return;
//     }
//
//     try {
//       debugPrint('SSE: Connecting to ${MyConfig.baseUrl}/api/sse/connect');
//
//       final client = http.Client();
//       final request = http.Request('GET', Uri.parse('${MyConfig.baseUrl}/api/sse/connect'));
//       request.headers['Authorization'] = 'Bearer $token';
//       request.headers['Accept'] = 'text/event-stream';
//       request.headers['Cache-Control'] = 'no-cache';
//
//       final response = await client.send(request);
//
//       if (response.statusCode == 200) {
//         _isConnected.value = true;
//         _reconnectAttempts = 0;
//         debugPrint('SSE: Connected successfully');
//
//         _sseSubscription = response.stream
//             .transform(utf8.decoder)
//             .transform(const LineSplitter())
//             .map(_parseSSEData)
//             .where((data) => data != null)
//             .cast<Map<String, dynamic>>()
//             .listen(
//           _handleSSEData,
//           onError: _handleSSEError,
//           onDone: _handleSSEDone,
//         );
//       } else {
//         debugPrint('SSE: Connection failed with status ${response.statusCode}');
//         _scheduleReconnect();
//       }
//     } catch (e) {
//       debugPrint('SSE: Connection error: $e');
//       _handleSSEError(e);
//     }
//   }
//
//   /// Parse SSE data from stream
//   Map<String, dynamic>? _parseSSEData(String line) {
//     if (line.startsWith('data: ')) {
//       final data = line.substring(6).trim();
//       if (data.isNotEmpty && data != 'null') {
//         try {
//           return json.decode(data) as Map<String, dynamic>;
//         } catch (e) {
//           debugPrint('SSE: Error parsing data: $e');
//         }
//       }
//     }
//     return null;
//   }
//
//   /// Handle incoming SSE data
//   void _handleSSEData(Map<String, dynamic> data) {
//     debugPrint('SSE: Received data: $data');
//
//     // Add to notifications list
//     _notifications.insert(0, data);
//
//     // Keep only last 100 notifications
//     if (_notifications.length > 100) {
//       _notifications.removeRange(100, _notifications.length);
//     }
//
//     // Handle different notification types
//     _handleNotificationByType(data);
//   }
//
//   /// Handle notifications based on type
//   void _handleNotificationByType(Map<String, dynamic> data) {
//     final type = data['type'] as String?;
//
//     switch (type) {
//       case 'connection':
//         debugPrint('SSE: Connection established');
//         break;
//       case 'notification':
//         _showLocalNotification(data);
//         break;
//       case 'admin_notification':
//         _showLocalNotification(data);
//         break;
//       case 'order_created':
//         _handleOrderNotification(data);
//         break;
//       case 'order_status_changed':
//         _handleOrderStatusNotification(data);
//         break;
//       case 'reservation_created':
//         _handleReservationNotification(data);
//         break;
//       default:
//         debugPrint('SSE: Unknown notification type: $type');
//     }
//   }
//
//   /// Show local notification
//   void _showLocalNotification(Map<String, dynamic> data) {
//     final title = data['title'] as String? ?? 'Thông báo';
//     final content = data['content'] as String? ?? '';
//
//     // Show snackbar notification
//     Get.snackbar(
//       title,
//       content,
//       duration: const Duration(seconds: 4),
//       snackPosition: SnackPosition.TOP,
//     );
//   }
//
//   /// Handle order notifications
//   void _handleOrderNotification(Map<String, dynamic> data) {
//     _showLocalNotification(data);
//     // You can add specific order handling logic here
//     // For example, refresh order list, navigate to order detail, etc.
//   }
//
//   /// Handle order status change notifications
//   void _handleOrderStatusNotification(Map<String, dynamic> data) {
//     _showLocalNotification(data);
//     // You can add specific order status handling logic here
//   }
//
//   /// Handle reservation notifications
//   void _handleReservationNotification(Map<String, dynamic> data) {
//     _showLocalNotification(data);
//     // You can add specific reservation handling logic here
//   }
//
//   /// Handle SSE errors
//   void _handleSSEError(dynamic error) {
//     debugPrint('SSE: Error occurred: $error');
//     _isConnected.value = false;
//     _scheduleReconnect();
//   }
//
//   /// Handle SSE connection done
//   void _handleSSEDone() {
//     debugPrint('SSE: Connection closed');
//     _isConnected.value = false;
//     _scheduleReconnect();
//   }
//
//   /// Schedule reconnection
//   void _scheduleReconnect() {
//     if (_reconnectAttempts >= _maxReconnectAttempts) {
//       debugPrint('SSE: Max reconnect attempts reached');
//       return;
//     }
//
//     _reconnectTimer?.cancel();
//     _reconnectTimer = Timer(_reconnectDelay, () {
//       _reconnectAttempts++;
//       debugPrint('SSE: Reconnecting... Attempt $_reconnectAttempts');
//       connectToSSE();
//     });
//   }
//
//   /// Disconnect from SSE
//   void disconnect() {
//     debugPrint('SSE: Disconnecting...');
//     _sseSubscription?.cancel();
//     _reconnectTimer?.cancel();
//     _isConnected.value = false;
//     _reconnectAttempts = 0;
//   }
//
//   /// Reconnect manually
//   void reconnect() {
//     disconnect();
//     Future.delayed(const Duration(milliseconds: 500), () {
//       connectToSSE();
//     });
//   }
//
//   /// Clear all notifications
//   void clearNotifications() {
//     _notifications.clear();
//   }
//
//   /// Mark notification as read (you can implement API call here)
//   Future<void> markAsRead(String notificationId) async {
//     try {
//       final token = GetStorageUtil.getToken();
//       if (token == null) return;
//
//       // You can implement API call to mark notification as read
//       // await http.put(
//       //   Uri.parse('${MyConfig.baseUrl}/api/notifications/$notificationId/read'),
//       //   headers: {'Authorization': 'Bearer $token'},
//       // );
//
//       // Update local notification
//       final index = _notifications.indexWhere(
//         (notification) => notification['notificationId'] == notificationId,
//       );
//       if (index != -1) {
//         _notifications[index]['isRead'] = true;
//         _notifications.refresh();
//       }
//     } catch (e) {
//       debugPrint('Error marking notification as read: $e');
//     }
//   }
//
//   /// Get unread notifications count
//   int get unreadCount {
//     return _notifications.where((notification) =>
//       notification['isRead'] != true
//     ).length;
//   }
//
//   /// Get notifications by type
//   List<Map<String, dynamic>> getNotificationsByType(String type) {
//     return _notifications.where((notification) =>
//       notification['type'] == type
//     ).toList();
//   }
// }
