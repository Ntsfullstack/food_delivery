// To parse this JSON data, do
//
//     final orderManagerment = orderManagermentFromJson(jsonString);

import 'dart:convert';

List<OrderManagement> orderManagermentFromJson(String str) => List<OrderManagement>.from(json.decode(str).map((x) => OrderManagement.fromJson(x)));

String orderManagermentToJson(List<OrderManagement> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderManagement {
  int? orderId;
  String? userId;
  String? username;
  String? totalPrice;
  String? status;
  DateTime? orderDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderManagement({
    this.orderId,
    this.userId,
    this.username,
    this.totalPrice,
    this.status,
    this.orderDate,
    this.createdAt,
    this.updatedAt,
  });

  OrderManagement copyWith({
    int? orderId,
    String? userId,
    String? username,
    String? totalPrice,
    String? status,
    DateTime? orderDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      OrderManagement(
        orderId: orderId ?? this.orderId,
        userId: userId ?? this.userId,
        username: username ?? this.username,
        totalPrice: totalPrice ?? this.totalPrice,
        status: status ?? this.status,
        orderDate: orderDate ?? this.orderDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderManagement.fromJson(Map<String, dynamic> json) => OrderManagement(
    orderId: json["orderId"],
    userId: json["userId"],
    username: json["username"],
    totalPrice: json["totalPrice"],
    status: json["status"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "userId": userId,
    "username": username,
    "totalPrice": totalPrice,
    "status": status,
    "orderDate": orderDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
