// To parse this JSON data, do
//
//     final dishesCategory = dishesCategoryFromJson(jsonString);

import 'dart:convert';

List<DishesCategory> dishesCategoryFromJson(String str) => List<DishesCategory>.from(json.decode(str).map((x) => DishesCategory.fromJson(x)));

String dishesCategoryToJson(List<DishesCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DishesCategory {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  DishesCategory({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  DishesCategory copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DishesCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DishesCategory.fromJson(Map<String, dynamic> json) => DishesCategory(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
