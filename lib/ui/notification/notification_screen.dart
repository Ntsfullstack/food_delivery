// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../models/notification/notification.dart';
// import '../../x_res/my_res.dart';
// import 'notification_controller.dart';
//
// class NotificationScreen extends GetView<NotificationController> {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Thông báo'),
//         backgroundColor: R.colors.primary,
//         foregroundColor: Colors.white,
//         actions: [
//           // SSE connection status
//           Obx(() => IconButton(
//             icon: Icon(
//               controller.isSSEConnected
//                   ? Icons.wifi
//                   : Icons.wifi_off,
//               color: controller.isSSEConnected
//                   ? Colors.green
//                   : Colors.red,
//             ),
//             onPressed: () {
//               if (!controller.isSSEConnected) {
//                 controller.reconnectSSE();
//               }
//             },
//             tooltip: controller.isSSEConnected
//                 ? 'Đã kết nối'
//                 : 'Mất kết nối - Nhấn để kết nối lại',
//           )),
//           // Mark all as read
//           Obx(() => controller.unreadCount.value > 0
//               ? IconButton(
//                   icon: const Icon(Icons.mark_email_read),
//                   onPressed: controller.markAllAsRead,
//                   tooltip: 'Đánh dấu tất cả đã đọc',
//                 )
//               : const SizedBox.shrink()),
//           // Refresh
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: controller.refreshNotifications,
//             tooltip: 'Làm mới',
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Connection status banner
//           Obx(() => !controller.isSSEConnected
//               ? Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(8),
//                   color: Colors.orange,
//                   child: Row(
//                     children: [
//                       const Icon(Icons.warning, color: Colors.white, size: 16),
//                       const SizedBox(width: 8),
//                       const Expanded(
//                         child: Text(
//                           'Mất kết nối thông báo real-time',
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: controller.reconnectSSE,
//                         child: const Text(
//                           'Kết nối lại',
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : const SizedBox.shrink()),
//
//           // Unread count
//           Obx(() => controller.unreadCount.value > 0
//               ? Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   color: Colors.blue.shade50,
//                   child: Text(
//                     'Bạn có ${controller.unreadCount.value} thông báo chưa đọc',
//                     style: TextStyle(
//                       color: Colors.blue.shade700,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 )
//               : const SizedBox.shrink()),
//
//           // Notifications list
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value && controller.notifications.isEmpty) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (controller.notifications.isEmpty) {
//                 return _buildEmptyState();
//               }
//
//               return RefreshIndicator(
//                 onRefresh: controller.refreshNotifications,
//                 child: ListView.builder(
//                   itemCount: controller.notifications.length +
//                       (controller.hasMoreData.value ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     if (index == controller.notifications.length) {
//                       // Load more indicator
//                       if (controller.hasMoreData.value) {
//                         controller.loadMoreNotifications();
//                         return const Padding(
//                           padding: EdgeInsets.all(16),
//                           child: Center(child: CircularProgressIndicator()),
//                         );
//                       }
//                       return const SizedBox.shrink();
//                     }
//
//                     final notification = controller.notifications[index];
//                     return _buildNotificationItem(notification);
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.notifications_none,
//             size: 64,
//             color: Colors.grey.shade400,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Chưa có thông báo nào',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Các thông báo mới sẽ xuất hiện ở đây',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade500,
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: controller.refreshNotifications,
//             child: const Text('Làm mới'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNotificationItem(NotificationModel notification) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       elevation: notification.isRead ? 1 : 3,
//       child: InkWell(
//         onTap: () => controller.onNotificationTap(notification),
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: notification.isRead ? null : Colors.blue.shade50,
//             border: notification.isHighPriority
//                 ? Border.all(color: Colors.red.shade300, width: 1)
//                 : null,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Row(
//                 children: [
//                   // Type icon
//                   _buildTypeIcon(notification),
//                   const SizedBox(width: 8),
//                   // Title
//                   Expanded(
//                     child: Text(
//                       notification.title,
//                       style: TextStyle(
//                         fontWeight: notification.isRead
//                             ? FontWeight.w500
//                             : FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   // Priority indicator
//                   if (notification.isHighPriority)
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: Colors.red.shade100,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         'Quan trọng',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.red.shade700,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   // Unread indicator
//                   if (!notification.isRead)
//                     Container(
//                       margin: const EdgeInsets.only(left: 8),
//                       width: 8,
//                       height: 8,
//                       decoration: const BoxDecoration(
//                         color: Colors.blue,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//
//               // Content
//               Text(
//                 notification.content,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey.shade700,
//                   height: 1.4,
//                 ),
//               ),
//
//               // Footer
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   // Type label
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: _getTypeColor(notification).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Text(
//                       notification.typeDisplayName,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: _getTypeColor(notification),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   // Time
//                   Text(
//                     notification.displayTime,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey.shade500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTypeIcon(NotificationModel notification) {
//     IconData icon;
//     Color color;
//
//     switch (notification.type) {
//       case 'order_created':
//       case 'order_status_changed':
//         icon = Icons.shopping_cart;
//         color = Colors.green;
//         break;
//       case 'reservation_created':
//       case 'reservation_confirmed':
//       case 'reservation_canceled':
//         icon = Icons.table_restaurant;
//         color = Colors.orange;
//         break;
//       case 'admin_alert':
//         icon = Icons.admin_panel_settings;
//         color = Colors.red;
//         break;
//       case 'announcement':
//         icon = Icons.campaign;
//         color = Colors.purple;
//         break;
//       default:
//         icon = Icons.notifications;
//         color = Colors.blue;
//     }
//
//     return Container(
//       padding: const EdgeInsets.all(6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         icon,
//         size: 16,
//         color: color,
//       ),
//     );
//   }
//
//   Color _getTypeColor(NotificationModel notification) {
//     switch (notification.type) {
//       case 'order_created':
//       case 'order_status_changed':
//         return Colors.green;
//       case 'reservation_created':
//       case 'reservation_confirmed':
//       case 'reservation_canceled':
//         return Colors.orange;
//       case 'admin_alert':
//         return Colors.red;
//       case 'announcement':
//         return Colors.purple;
//       default:
//         return Colors.blue;
//     }
//   }
// }
