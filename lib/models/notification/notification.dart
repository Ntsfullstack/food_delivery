class NotificationModel {
  final String? notificationId;
  final String title;
  final String content;
  final String? type;
  final String? referenceId;
  final bool isRead;
  final String? status;
  final String? userId;
  final String? priority;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? timestamp;
  final Map<String, dynamic>? data;

  NotificationModel({
    this.notificationId,
    required this.title,
    required this.content,
    this.type,
    this.referenceId,
    this.isRead = false,
    this.status,
    this.userId,
    this.priority,
    this.createdAt,
    this.updatedAt,
    this.timestamp,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'] as String?,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      type: json['type'] as String?,
      referenceId: json['referenceId'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      status: json['status'] as String?,
      userId: json['userId'] as String?,
      priority: json['priority'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      timestamp: json['timestamp'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'title': title,
      'content': content,
      'type': type,
      'referenceId': referenceId,
      'isRead': isRead,
      'status': status,
      'userId': userId,
      'priority': priority,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'timestamp': timestamp,
      'data': data,
    };
  }

  NotificationModel copyWith({
    String? notificationId,
    String? title,
    String? content,
    String? type,
    String? referenceId,
    bool? isRead,
    String? status,
    String? userId,
    String? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? timestamp,
    Map<String, dynamic>? data,
  }) {
    return NotificationModel(
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      referenceId: referenceId ?? this.referenceId,
      isRead: isRead ?? this.isRead,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      timestamp: timestamp ?? this.timestamp,
      data: data ?? this.data,
    );
  }

  // Helper methods
  bool get isOrderNotification => type?.contains('order') == true;
  bool get isReservationNotification => type?.contains('reservation') == true;
  bool get isAdminNotification => type?.contains('admin') == true;
  bool get isHighPriority => priority == 'high';
  
  String get displayTime {
    if (timestamp != null) {
      final time = DateTime.tryParse(timestamp!);
      if (time != null) {
        final now = DateTime.now();
        final difference = now.difference(time);
        
        if (difference.inMinutes < 1) {
          return 'Vừa xong';
        } else if (difference.inHours < 1) {
          return '${difference.inMinutes} phút trước';
        } else if (difference.inDays < 1) {
          return '${difference.inHours} giờ trước';
        } else {
          return '${difference.inDays} ngày trước';
        }
      }
    }
    
    if (createdAt != null) {
      final now = DateTime.now();
      final difference = now.difference(createdAt!);
      
      if (difference.inMinutes < 1) {
        return 'Vừa xong';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes} phút trước';
      } else if (difference.inDays < 1) {
        return '${difference.inHours} giờ trước';
      } else {
        return '${difference.inDays} ngày trước';
      }
    }
    
    return '';
  }

  String get typeDisplayName {
    switch (type) {
      case 'order_created':
        return 'Đơn hàng mới';
      case 'order_status_changed':
        return 'Cập nhật đơn hàng';
      case 'reservation_created':
        return 'Đặt bàn';
      case 'reservation_confirmed':
        return 'Xác nhận đặt bàn';
      case 'reservation_canceled':
        return 'Hủy đặt bàn';
      case 'admin_alert':
        return 'Thông báo admin';
      case 'announcement':
        return 'Thông báo chung';
      default:
        return 'Thông báo';
    }
  }
}

// Notification types enum
enum NotificationType {
  orderCreated('order_created'),
  orderStatusChanged('order_status_changed'),
  reservationCreated('reservation_created'),
  reservationConfirmed('reservation_confirmed'),
  reservationCanceled('reservation_canceled'),
  adminAlert('admin_alert'),
  announcement('announcement'),
  general('general');

  const NotificationType(this.value);
  final String value;
}

// Notification priority enum
enum NotificationPriority {
  low('low'),
  normal('normal'),
  high('high');

  const NotificationPriority(this.value);
  final String value;
}
