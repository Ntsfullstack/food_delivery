// To parse this JSON data, do
//
//     final dishes = dishesFromJson(jsonString);

import 'dart:convert';

List<Dishes> dishesFromJson(String str) => List<Dishes>.from(json.decode(str).map((x) => Dishes.fromJson(x)));

String dishesToJson(List<Dishes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dishes {
  int? dishId;
  String? name;
  String? description;
  String? price;
  String? imageUrl;
  String? rating;
  String? category;
  DateTime? createdAt;
  DateTime? updatedAt;

  Dishes({
    this.dishId,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.rating,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  Dishes copyWith({
    int? dishId,
    String? name,
    String? description,
    String? price,
    String? imageUrl,
    String? rating,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Dishes(
        dishId: dishId ?? this.dishId,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        rating: rating ?? this.rating,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Dishes.fromJson(Map<String, dynamic> json) => Dishes(
    dishId: json["dishId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    rating: json["rating"],
    category: json["category"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "dishId": dishId,
    "name": name,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "rating": rating,
    "category": category,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
