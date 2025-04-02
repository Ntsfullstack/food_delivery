// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

OrderDetail orderDetailFromJson(String str) => OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  int? orderId;
  String? userId;
  String? totalPrice;
  String? status;
  int? tableId;
  DateTime? orderDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? username;
  String? email;
  List<Item>? items;

  OrderDetail({
    this.orderId,
    this.userId,
    this.totalPrice,
    this.status,
    this.tableId,
    this.orderDate,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.email,
    this.items,
  });

  OrderDetail copyWith({
    int? orderId,
    String? userId,
    String? totalPrice,
    String? status,
    int? tableId,
    DateTime? orderDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? username,
    String? email,
    List<Item>? items,
  }) =>
      OrderDetail(
        orderId: orderId ?? this.orderId,
        userId: userId ?? this.userId,
        totalPrice: totalPrice ?? this.totalPrice,
        status: status ?? this.status,
        tableId: tableId ?? this.tableId,
        orderDate: orderDate ?? this.orderDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        username: username ?? this.username,
        email: email ?? this.email,
        items: items ?? this.items,
      );

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    orderId: json["orderId"],
    userId: json["userId"],
    totalPrice: json["totalPrice"],
    status: json["status"],
    tableId: json["tableId"],
    orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    username: json["username"],
    email: json["email"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "userId": userId,
    "totalPrice": totalPrice,
    "status": status,
    "tableId": tableId,
    "orderDate": orderDate?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "username": username,
    "email": email,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  int? id;
  int? dishId;
  String? dishName;
  String? imageUrl;
  int? quantity;
  String? price;
  dynamic specialRequests;
  DateTime? createdAt;

  Item({
    this.id,
    this.dishId,
    this.dishName,
    this.imageUrl,
    this.quantity,
    this.price,
    this.specialRequests,
    this.createdAt,
  });

  Item copyWith({
    int? id,
    int? dishId,
    String? dishName,
    String? imageUrl,
    int? quantity,
    String? price,
    dynamic specialRequests,
    DateTime? createdAt,
  }) =>
      Item(
        id: id ?? this.id,
        dishId: dishId ?? this.dishId,
        dishName: dishName ?? this.dishName,
        imageUrl: imageUrl ?? this.imageUrl,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        specialRequests: specialRequests ?? this.specialRequests,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    dishId: json["dishId"],
    dishName: json["dishName"],
    imageUrl: json["imageUrl"],
    quantity: json["quantity"],
    price: json["price"],
    specialRequests: json["specialRequests"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dishId": dishId,
    "dishName": dishName,
    "imageUrl": imageUrl,
    "quantity": quantity,
    "price": price,
    "specialRequests": specialRequests,
    "createdAt": createdAt?.toIso8601String(),
  };
}
