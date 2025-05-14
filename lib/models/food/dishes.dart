import 'dart:convert';

List<Dishes> dishesFromJson(String str) => List<Dishes>.from(json.decode(str).map((x) => Dishes.fromJson(x)));

String dishesToJson(List<Dishes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dishes {
  int? id;
  String? name;
  String? description;
  double? price;
  int? preparationTime;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? available;
  int? categoryId;
  String? categoryName;
  List<Size>? sizes;
  List<dynamic>? toppings;
  List<Rating>? ratings;
  double? averageRating;

  Dishes({
    this.id,
    this.name,
    this.description,
    this.price,
    this.preparationTime,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.available,
    this.categoryId,
    this.categoryName,
    this.sizes,
    this.toppings,
    this.ratings,
    this.averageRating,
  });

  factory Dishes.fromJson(Map<String, dynamic> json) {
    DateTime? parseDateTime(dynamic value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    double? calculateAverage(List<dynamic>? ratingsJson) {
      if (ratingsJson == null) return null;
      final ratings = ratingsJson.map((r) => Rating.fromJson(r)).where((r) => r.rating != null).toList();
      if (ratings.isEmpty) return null;
      return ratings.map((r) => r.rating!).reduce((a, b) => a + b) / ratings.length;
    }

    return Dishes(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: double.tryParse(json["price"]?.toString() ?? '0'),
      preparationTime: json["preparation_time"],
      image: json["image"],
      createdAt: parseDateTime(json["created_at"]),
      updatedAt: parseDateTime(json["updated_at"]),
      available: json["available"],
      categoryId: json["category_id"],
      categoryName: json["category_name"],
      sizes: json["sizes"]?.map<Size>((s) => Size.fromJson(s)).toList(),
      toppings: json["toppings"],
      ratings: json["ratings"]?.map<Rating>((r) => Rating.fromJson(r)).toList(),
      averageRating: calculateAverage(json["ratings"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price?.toString(),
    "preparation_time": preparationTime,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "available": available,
    "category_id": categoryId,
    "category_name": categoryName,
    "sizes": sizes?.map((s) => s.toJson()).toList(),
    "toppings": toppings,
    "ratings": ratings?.map((r) => r.toJson()).toList(),
  };

  double get numericPrice => price ?? 0.0;
}

class Rating {
  int? id;
  int? rating;
  DateTime? createdAt;
  String? username;
  String? fullName;

  Rating({
    this.id,
    this.rating,
    this.createdAt,
    this.username,
    this.fullName,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    rating: json["rating"],
    createdAt: DateTime.tryParse(json["created_at"] ?? ''),
    username: json["username"],
    fullName: json["full_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "created_at": createdAt?.toIso8601String(),
    "username": username,
    "full_name": fullName,
  };
}

class Size {
  int? id;
  String? sizeName;
  double? priceAdjustment;
  bool? isDefault;

  Size({
    this.id,
    this.sizeName,
    this.priceAdjustment,
    this.isDefault,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    id: json["id"],
    sizeName: json["size_name"],
    priceAdjustment: double.tryParse(json["price_adjustment"]?.toString() ?? '0'),
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "size_name": sizeName,
    "price_adjustment": priceAdjustment?.toString(),
    "is_default": isDefault,
  };
}