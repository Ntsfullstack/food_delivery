// To parse this JSON data, do
//
//     final listOrder = listOrderFromJson(jsonString);

import 'dart:convert';

List<ListOrder> listOrderFromJson(String str) => List<ListOrder>.from(json.decode(str).map((x) => ListOrder.fromJson(x)));

String listOrderToJson(List<ListOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListOrder {
  int? orderId;
  String? userId;
  String? totalPrice;
  String? status;
  DateTime? orderDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  ListOrder({
    this.orderId,
    this.userId,
    this.totalPrice,
    this.status,
    this.orderDate,
    this.createdAt,
    this.updatedAt,
  });

  ListOrder copyWith({
    int? orderId,
    String? userId,
    String? totalPrice,
    String? status,
    DateTime? orderDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ListOrder(
        orderId: orderId ?? this.orderId,
        userId: userId ?? this.userId,
        totalPrice: totalPrice ?? this.totalPrice,
        status: status ?? this.status,
        orderDate: orderDate ?? this.orderDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ListOrder.fromJson(Map<String, dynamic> json) => ListOrder(
    orderId: json["orderId"],
    userId: json["userId"],
    totalPrice: json["totalPrice"],
    status: json["status"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "userId": userId,
    "totalPrice": totalPrice,
    "status": status,
    "orderDate": orderDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
