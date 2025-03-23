// To parse this JSON data, do
//
//     final listDishes = listDishesFromMap(jsonString);

import 'dart:convert';

List<ListDishes> listDishesFromMap(String str) => List<ListDishes>.from(json.decode(str).map((x) => ListDishes.fromMap(x)));

String listDishesToMap(List<ListDishes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ListDishes {
  int? dishId;
  String? name;
  String? description;
  String? imageUrl;
  String? rating;
  String? category;
  bool? isCombo;
  List<Size>? sizes;
  bool? isAvailable;
  DateTime? createdAt;
  DateTime? updatedAt;

  ListDishes({
    this.dishId,
    this.name,
    this.description,
    this.imageUrl,
    this.rating,
    this.category,
    this.isCombo,
    this.sizes,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  ListDishes copyWith({
    int? dishId,
    String? name,
    String? description,
    String? imageUrl,
    String? rating,
    String? category,
    bool? isCombo,
    List<Size>? sizes,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ListDishes(
        dishId: dishId ?? this.dishId,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        rating: rating ?? this.rating,
        category: category ?? this.category,
        isCombo: isCombo ?? this.isCombo,
        sizes: sizes ?? this.sizes,
        isAvailable: isAvailable ?? this.isAvailable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ListDishes.fromMap(Map<String, dynamic> json) => ListDishes(
    dishId: json["dishId"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    rating: json["rating"],
    category: json["category"],
    isCombo: json["isCombo"],
    sizes: json["sizes"] == null ? [] : List<Size>.from(json["sizes"]!.map((x) => Size.fromMap(x))),
    isAvailable: json["isAvailable"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "dishId": dishId,
    "name": name,
    "description": description,
    "imageUrl": imageUrl,
    "rating": rating,
    "category": category,
    "isCombo": isCombo,
    "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x.toMap())),
    "isAvailable": isAvailable,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Size {
  int? price;
  int? sizeId;
  String? sizeName;
  bool? isDefault;
  bool? isAvailable;

  Size({
    this.price,
    this.sizeId,
    this.sizeName,
    this.isDefault,
    this.isAvailable,
  });

  Size copyWith({
    int? price,
    int? sizeId,
    String? sizeName,
    bool? isDefault,
    bool? isAvailable,
  }) =>
      Size(
        price: price ?? this.price,
        sizeId: sizeId ?? this.sizeId,
        sizeName: sizeName ?? this.sizeName,
        isDefault: isDefault ?? this.isDefault,
        isAvailable: isAvailable ?? this.isAvailable,
      );

  factory Size.fromMap(Map<String, dynamic> json) => Size(
    // Handle different price formats
    price: json["price"] == null
        ? null
        : (json["price"] is String
        ? (double.tryParse(json["price"]) ?? 0.0).toInt()
        : json["price"] is double
        ? json["price"].toInt()
        : json["price"]),
    sizeId: json["sizeId"],
    sizeName: json["sizeName"],
    isDefault: json["isDefault"],
    isAvailable: json["isAvailable"],
  );

  Map<String, dynamic> toMap() => {
    "price": price,
    "sizeId": sizeId,
    "sizeName": sizeName,
    "isDefault": isDefault,
    "isAvailable": isAvailable,
  };
}
