// To parse this JSON data, do
//
//     final tableBooking = tableBookingFromJson(jsonString);

import 'dart:convert';

TableBooking tableBookingFromJson(String str) => TableBooking.fromJson(json.decode(str));

String tableBookingToJson(TableBooking data) => json.encode(data.toJson());

class TableBooking {
  int? reservationId;
  String? userId;
  String? userName;
  String? userPhone;
  dynamic tableId;
  dynamic tableNumber;
  DateTime? reservationTime;
  int? partySize;
  String? customerName;
  String? phoneNumber;
  String? specialRequests;
  dynamic orderId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? orderedItems;

  TableBooking({
    this.reservationId,
    this.userId,
    this.userName,
    this.userPhone,
    this.tableId,
    this.tableNumber,
    this.reservationTime,
    this.partySize,
    this.customerName,
    this.phoneNumber,
    this.specialRequests,
    this.orderId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.orderedItems,
  });

  TableBooking copyWith({
    int? reservationId,
    String? userId,
    String? userName,
    String? userPhone,
    dynamic tableId,
    dynamic tableNumber,
    DateTime? reservationTime,
    int? partySize,
    String? customerName,
    String? phoneNumber,
    String? specialRequests,
    dynamic orderId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? orderedItems,
  }) =>
      TableBooking(
        reservationId: reservationId ?? this.reservationId,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userPhone: userPhone ?? this.userPhone,
        tableId: tableId ?? this.tableId,
        tableNumber: tableNumber ?? this.tableNumber,
        reservationTime: reservationTime ?? this.reservationTime,
        partySize: partySize ?? this.partySize,
        customerName: customerName ?? this.customerName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        specialRequests: specialRequests ?? this.specialRequests,
        orderId: orderId ?? this.orderId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        orderedItems: orderedItems ?? this.orderedItems,
      );

  factory TableBooking.fromJson(Map<String, dynamic> json) => TableBooking(
    reservationId: json["reservationId"],
    userId: json["userId"],
    userName: json["userName"],
    userPhone: json["userPhone"],
    tableId: json["tableId"],
    tableNumber: json["tableNumber"],
    reservationTime: json["reservationTime"] == null ? null : DateTime.parse(json["reservationTime"]),
    partySize: json["partySize"],
    customerName: json["customerName"],
    phoneNumber: json["phoneNumber"],
    specialRequests: json["specialRequests"],
    orderId: json["orderId"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    orderedItems: json["orderedItems"] == null ? [] : List<dynamic>.from(json["orderedItems"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "reservationId": reservationId,
    "userId": userId,
    "userName": userName,
    "userPhone": userPhone,
    "tableId": tableId,
    "tableNumber": tableNumber,
    "reservationTime": reservationTime?.toIso8601String(),
    "partySize": partySize,
    "customerName": customerName,
    "phoneNumber": phoneNumber,
    "specialRequests": specialRequests,
    "orderId": orderId,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "orderedItems": orderedItems == null ? [] : List<dynamic>.from(orderedItems!.map((x) => x)),
  };
}