// To parse this JSON data, do
//
//     final tableBooking = tableBookingFromJson(jsonString);

import 'dart:convert';

TableBooking tableBookingFromJson(String str) => TableBooking.fromJson(json.decode(str));

String tableBookingToJson(TableBooking data) => json.encode(data.toJson());

class TableBooking {
  int? reservationId;
  String? userId;
  dynamic tableId;
  DateTime? reservationTime;
  int? partySize;
  String? status;
  String? specialRequests;
  dynamic orderId;
  DateTime? createdAt;
  DateTime? updatedAt;

  TableBooking({
    this.reservationId,
    this.userId,
    this.tableId,
    this.reservationTime,
    this.partySize,
    this.status,
    this.specialRequests,
    this.orderId,
    this.createdAt,
    this.updatedAt,
  });

  TableBooking copyWith({
    int? reservationId,
    String? userId,
    dynamic tableId,
    DateTime? reservationTime,
    int? partySize,
    String? status,
    String? specialRequests,
    dynamic orderId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TableBooking(
        reservationId: reservationId ?? this.reservationId,
        userId: userId ?? this.userId,
        tableId: tableId ?? this.tableId,
        reservationTime: reservationTime ?? this.reservationTime,
        partySize: partySize ?? this.partySize,
        status: status ?? this.status,
        specialRequests: specialRequests ?? this.specialRequests,
        orderId: orderId ?? this.orderId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory TableBooking.fromJson(Map<String, dynamic> json) => TableBooking(
    reservationId: json["reservationId"],
    userId: json["userId"],
    tableId: json["tableId"],
    reservationTime: json["reservationTime"] == null ? null : DateTime.parse(json["reservationTime"]),
    partySize: json["partySize"],
    status: json["status"],
    specialRequests: json["specialRequests"],
    orderId: json["orderId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "reservationId": reservationId,
    "userId": userId,
    "tableId": tableId,
    "reservationTime": reservationTime?.toIso8601String(),
    "partySize": partySize,
    "status": status,
    "specialRequests": specialRequests,
    "orderId": orderId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
