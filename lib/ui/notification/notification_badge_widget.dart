// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../service/sse_notification_service.dart';
//
// class NotificationBadgeWidget extends StatelessWidget {
//   final Widget child;
//   final VoidCallback? onTap;
//
//   const NotificationBadgeWidget({
//     Key? key,
//     required this.child,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SSENotificationService>(
//       init: SSENotificationService.instance,
//       builder: (sseService) {
//         return Obx(() {
//           final unreadCount = sseService.unreadCount;
//
//           return Stack(
//             children: [
//               InkWell(
//                 onTap: onTap,
//                 borderRadius: BorderRadius.circular(8),
//                 child: child,
//               ),
//               if (unreadCount > 0)
//                 Positioned(
//                   right: 0,
//                   top: 0,
//                   child: Container(
//                     padding: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.white, width: 1),
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 16,
//                       minHeight: 16,
//                     ),
//                     child: Text(
//                       unreadCount > 99 ? '99+' : unreadCount.toString(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         });
//       },
//     );
//   }
// }
//
// class NotificationIconButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final Color? iconColor;
//   final double? iconSize;
//
//   const NotificationIconButton({
//     Key? key,
//     this.onPressed,
//     this.iconColor,
//     this.iconSize,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationBadgeWidget(
//       onTap: onPressed,
//       child: IconButton(
//         onPressed: onPressed,
//         icon: Icon(
//           Icons.notifications,
//           color: iconColor,
//           size: iconSize,
//         ),
//       ),
//     );
//   }
// }
//
// class NotificationBottomNavItem extends StatelessWidget {
//   final bool isSelected;
//   final VoidCallback? onTap;
//   final String label;
//
//   const NotificationBottomNavItem({
//     Key? key,
//     required this.isSelected,
//     this.onTap,
//     this.label = 'Thông báo',
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationBadgeWidget(
//       onTap: onTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             Icons.notifications,
//             color: isSelected ? Colors.blue : Colors.grey,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: isSelected ? Colors.blue : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
