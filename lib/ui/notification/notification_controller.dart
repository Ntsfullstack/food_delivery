// import 'package:get/get.dart';
// import '../../base/base_controller.dart';
// import '../../models/notification/notification.dart';
// import '../../repository/notification_repository/notification_repository.dart';
// import '../../service/sse_notification_service.dart';
//
// class NotificationController extends BaseController {
//   final NotificationRepository _notificationRepository;
//   final SSENotificationService _sseService = SSENotificationService.instance;
//
//   NotificationController(this._notificationRepository);
//
//   // Observable variables
//   final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxBool isLoadingMore = false.obs;
//   final RxInt currentPage = 1.obs;
//   final RxBool hasMoreData = true.obs;
//   final RxInt unreadCount = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeNotifications();
//     _listenToSSENotifications();
//   }
//
//   /// Initialize notifications
//   void _initializeNotifications() {
//     fetchNotifications();
//     _updateUnreadCount();
//   }
//
//   /// Listen to SSE notifications
//   void _listenToSSENotifications() {
//     // Listen to new notifications from SSE
//     _sseService.notificationsStream.listen((sseNotifications) {
//       // Convert SSE notifications to NotificationModel
//       final newNotifications = sseNotifications
//           .map((data) => NotificationModel.fromJson(data))
//           .toList();
//
//       // Update notifications list
//       _mergeNotifications(newNotifications);
//       _updateUnreadCount();
//     });
//   }
//
//   /// Merge new notifications with existing ones
//   void _mergeNotifications(List<NotificationModel> newNotifications) {
//     for (final newNotification in newNotifications) {
//       // Check if notification already exists
//       final existingIndex = notifications.indexWhere(
//         (notification) => notification.notificationId == newNotification.notificationId,
//       );
//
//       if (existingIndex == -1) {
//         // Add new notification at the beginning
//         notifications.insert(0, newNotification);
//       } else {
//         // Update existing notification
//         notifications[existingIndex] = newNotification;
//       }
//     }
//
//     // Sort by timestamp (newest first)
//     notifications.sort((a, b) {
//       final aTime = a.createdAt ?? DateTime.now();
//       final bTime = b.createdAt ?? DateTime.now();
//       return bTime.compareTo(aTime);
//     });
//   }
//
//   /// Fetch notifications from API
//   Future<void> fetchNotifications({bool isRefresh = false}) async {
//     if (isRefresh) {
//       currentPage.value = 1;
//       hasMoreData.value = true;
//     }
//
//     if (isLoading.value || (!hasMoreData.value && !isRefresh)) return;
//
//     try {
//       isLoading.value = true;
//
//       final response = await _notificationRepository.getNotifications(
//         page: currentPage.value,
//         limit: 20,
//       );
//
//       if (response.data != null) {
//         if (isRefresh) {
//           notifications.clear();
//         }
//
//         final newNotifications = response.data!;
//         notifications.addAll(newNotifications);
//
//         // Check if there's more data
//         hasMoreData.value = newNotifications.length >= 20;
//         currentPage.value++;
//
//         _updateUnreadCount();
//       }
//     } catch (e) {
//       showError(message: 'Không thể tải thông báo: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Load more notifications
//   Future<void> loadMoreNotifications() async {
//     if (isLoadingMore.value || !hasMoreData.value) return;
//
//     try {
//       isLoadingMore.value = true;
//
//       final response = await _notificationRepository.getNotifications(
//         page: currentPage.value,
//         limit: 20,
//       );
//
//       if (response.data != null) {
//         final newNotifications = response.data!;
//         notifications.addAll(newNotifications);
//
//         // Check if there's more data
//         hasMoreData.value = newNotifications.length >= 20;
//         currentPage.value++;
//       }
//     } catch (e) {
//       showError(message: 'Không thể tải thêm thông báo: $e');
//     } finally {
//       isLoadingMore.value = false;
//     }
//   }
//
//   /// Mark notification as read
//   Future<void> markAsRead(NotificationModel notification) async {
//     if (notification.isRead || notification.notificationId == null) return;
//
//     try {
//       // Update local state immediately
//       final index = notifications.indexWhere(
//         (n) => n.notificationId == notification.notificationId,
//       );
//       if (index != -1) {
//         notifications[index] = notification.copyWith(isRead: true);
//         _updateUnreadCount();
//       }
//
//       // Update on server
//       await _notificationRepository.markAsRead(notification.notificationId!);
//
//       // Also mark as read in SSE service
//       await _sseService.markAsRead(notification.notificationId!);
//     } catch (e) {
//       // Revert local state if API call fails
//       final index = notifications.indexWhere(
//         (n) => n.notificationId == notification.notificationId,
//       );
//       if (index != -1) {
//         notifications[index] = notification.copyWith(isRead: false);
//         _updateUnreadCount();
//       }
//       showError(message: 'Không thể đánh dấu đã đọc: $e');
//     }
//   }
//
//   /// Mark all notifications as read
//   Future<void> markAllAsRead() async {
//     try {
//       showLoading(message: 'Đang đánh dấu tất cả đã đọc...');
//
//       // Update local state
//       for (int i = 0; i < notifications.length; i++) {
//         notifications[i] = notifications[i].copyWith(isRead: true);
//       }
//       _updateUnreadCount();
//
//       // Update on server
//       await _notificationRepository.markAllAsRead();
//
//       showSuccess(message: 'Đã đánh dấu tất cả thông báo đã đọc');
//     } catch (e) {
//       // Revert local state if API call fails
//       fetchNotifications(isRefresh: true);
//       showError(message: 'Không thể đánh dấu tất cả đã đọc: $e');
//     } finally {
//       hideLoading();
//     }
//   }
//
//   /// Update unread count
//   void _updateUnreadCount() {
//     unreadCount.value = notifications.where((n) => !n.isRead).length;
//   }
//
//   /// Get notifications by type
//   List<NotificationModel> getNotificationsByType(NotificationType type) {
//     return notifications.where((n) => n.type == type.value).toList();
//   }
//
//   /// Get unread notifications
//   List<NotificationModel> get unreadNotifications {
//     return notifications.where((n) => !n.isRead).toList();
//   }
//
//   /// Get order notifications
//   List<NotificationModel> get orderNotifications {
//     return notifications.where((n) => n.isOrderNotification).toList();
//   }
//
//   /// Get reservation notifications
//   List<NotificationModel> get reservationNotifications {
//     return notifications.where((n) => n.isReservationNotification).toList();
//   }
//
//   /// Clear all notifications
//   void clearAllNotifications() {
//     notifications.clear();
//     _sseService.clearNotifications();
//     _updateUnreadCount();
//   }
//
//   /// Refresh notifications
//   Future<void> refreshNotifications() async {
//     await fetchNotifications(isRefresh: true);
//   }
//
//   /// Handle notification tap
//   void onNotificationTap(NotificationModel notification) {
//     // Mark as read
//     markAsRead(notification);
//
//     // Navigate based on notification type
//     _navigateBasedOnType(notification);
//   }
//
//   /// Navigate based on notification type
//   void _navigateBasedOnType(NotificationModel notification) {
//     switch (notification.type) {
//       case 'order_created':
//       case 'order_status_changed':
//         if (notification.referenceId != null) {
//           // Navigate to order detail
//           Get.toNamed('/order-detail', arguments: notification.referenceId);
//         }
//         break;
//       case 'reservation_created':
//       case 'reservation_confirmed':
//       case 'reservation_canceled':
//         if (notification.referenceId != null) {
//           // Navigate to reservation detail
//           Get.toNamed('/reservation-detail', arguments: notification.referenceId);
//         }
//         break;
//       default:
//         // Default action or no navigation
//         break;
//     }
//   }
//
//   /// Check SSE connection status
//   bool get isSSEConnected => _sseService.isConnected;
//
//   /// Reconnect SSE
//   void reconnectSSE() {
//     _sseService.reconnect();
//   }
//
//   /// Get SSE connection stream
//   Stream<bool> get sseConnectionStream => _sseService.connectionStream;
// }
