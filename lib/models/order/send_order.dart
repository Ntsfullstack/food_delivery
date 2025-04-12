// To parse this JSON data, do
//
//     final createOrder = createOrderFromJson(jsonString);

import 'dart:convert';

List<CreateOrder> createOrderFromJson(String str) => List<CreateOrder>.from(json.decode(str).map((x) => CreateOrder.fromJson(x)));

String createOrderToJson(List<CreateOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreateOrder {
  int? dishId;
  int? quantity;

  CreateOrder({
    this.dishId,
    this.quantity,
  });

  CreateOrder copyWith({
    int? dishId,
    int? quantity,
  }) =>
      CreateOrder(
        dishId: dishId ?? this.dishId,
        quantity: quantity ?? this.quantity,
      );

  factory CreateOrder.fromJson(Map<String, dynamic> json) => CreateOrder(
    dishId: json["dishId"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "dishId": dishId,
    "quantity": quantity,
  };
}
