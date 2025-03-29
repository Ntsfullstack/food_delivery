// To parse this JSON data, do
//
//     final dishes = dishesFromJson(jsonString);

import 'dart:convert';

List<Dishes> dishesFromJson(String str) => List<Dishes>.from(json.decode(str).map((x) => Dishes.fromJson(x)));

String dishesToJson(List<Dishes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dishes {
  int? id;
  String? name;
  String? description;
  String? category;
  String? price;
  int? preparationTime;
  String? image;
  dynamic createdAt; // Can be String or DateTime
  dynamic updatedAt; // Can be String or DateTime
  bool? available;
  List<Size>? sizes;
  List<dynamic>? toppings;
  List<Rating>? ratings;
  double? rating; // Calculated average rating

  Dishes({
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.preparationTime,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.available,
    this.sizes,
    this.toppings,
    this.ratings,
    this.rating,
  });

  Dishes copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
    String? price,
    int? preparationTime,
    String? image,
    dynamic createdAt,
    dynamic updatedAt,
    bool? available,
    List<Size>? sizes,
    List<dynamic>? toppings,
    List<Rating>? ratings,
    double? rating,
  }) =>
      Dishes(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        category: category ?? this.category,
        price: price ?? this.price,
        preparationTime: preparationTime ?? this.preparationTime,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        available: available ?? this.available,
        sizes: sizes ?? this.sizes,
        toppings: toppings ?? this.toppings,
        ratings: ratings ?? this.ratings,
        rating: rating ?? this.rating,
      );

  factory Dishes.fromJson(Map<String, dynamic> json) {
    // Calculate average rating if available
    double? avgRating;
    if (json["ratings"] != null && json["ratings"] is List && json["ratings"].isNotEmpty) {
      final ratings = List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x)));
      if (ratings.isNotEmpty) {
        int sum = 0;
        int count = 0;
        for (var r in ratings) {
          if (r.rating != null) {
            sum += r.rating!;
            count++;
          }
        }
        if (count > 0) {
          avgRating = sum / count;
        }
      }
    }

    return Dishes(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      category: json["category"],
      price: json["price"],
      preparationTime: json["preparation_time"],
      image: json["image"],
      createdAt: json["created_at"] is String ? json["created_at"] :
      (json["created_at"] != null ? DateTime.parse(json["created_at"]) : null),
      updatedAt: json["updated_at"] is String ? json["updated_at"] :
      (json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null),
      available: json["available"],
      sizes: json["sizes"] == null ? null : List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
      toppings: json["toppings"] == null ? null : List<dynamic>.from(json["toppings"].map((x) => x)),
      ratings: json["ratings"] == null ? null : List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
      rating: avgRating,
    );
  }

  // Convert from simple list to detail format
  factory Dishes.fromListDishes(Map<String, dynamic> json) => Dishes(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    category: json["category"],
    price: json["price"],
    preparationTime: json["preparation_time"],
    image: json["image"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    available: json["available"],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "name": name,
      "description": description,
      "category": category,
      "price": price,
      "preparation_time": preparationTime,
      "image": image,
      "available": available,
    };

    // Handle different date formats
    if (createdAt != null) {
      data["created_at"] = createdAt is DateTime ? createdAt.toIso8601String() : createdAt;
    }

    if (updatedAt != null) {
      data["updated_at"] = updatedAt is DateTime ? updatedAt.toIso8601String() : updatedAt;
    }

    // Add the optional fields if they exist
    if (sizes != null) {
      data["sizes"] = List<dynamic>.from(sizes!.map((x) => x.toJson()));
    }

    if (toppings != null) {
      data["toppings"] = List<dynamic>.from(toppings!.map((x) => x));
    }

    if (ratings != null) {
      data["ratings"] = List<dynamic>.from(ratings!.map((x) => x.toJson()));
    }

    return data;
  }

  // Helper to get the numeric price
  double getNumericPrice() {
    if (price == null) return 0.0;

    try {
      return double.parse(price!);
    } catch (e) {
      return 0.0;
    }
  }

  // Helper to get default size price or base price
  double getDefaultPrice() {
    if (sizes != null && sizes!.isNotEmpty) {
      // Try to find default size or use first size
      for (var size in sizes!) {
        if (size.isDefault == true) {
          return size.getNumericPrice();
        }
      }
      // If no default, use first size
      return sizes!.first.getNumericPrice();
    }

    // If no sizes, use base price
    return getNumericPrice();
  }

  // Helper to format the price for display
  String getFormattedPrice() {
    double price = getDefaultPrice();
    if (price == 0) return "Price N/A";

    // Format as xxK
    return "${(price / 1000).toStringAsFixed(0)}K";
  }
}

class Rating {
  int? id;
  int? rating;
  dynamic createdAt; // Can be String or DateTime
  String? username;
  String? fullName;

  Rating({
    this.id,
    this.rating,
    this.createdAt,
    this.username,
    this.fullName,
  });

  Rating copyWith({
    int? id,
    int? rating,
    dynamic createdAt,
    String? username,
    String? fullName,
  }) =>
      Rating(
        id: id ?? this.id,
        rating: rating ?? this.rating,
        createdAt: createdAt ?? this.createdAt,
        username: username ?? this.username,
        fullName: fullName ?? this.fullName,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    rating: json["rating"],
    createdAt: json["created_at"] is String ? json["created_at"] :
    (json["created_at"] != null ? DateTime.parse(json["created_at"]) : null),
    username: json["username"],
    fullName: json["full_name"],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "rating": rating,
      "username": username,
      "full_name": fullName,
    };

    if (createdAt != null) {
      data["created_at"] = createdAt is DateTime ? createdAt.toIso8601String() : createdAt;
    }

    return data;
  }
}

class Size {
  int? id;
  String? sizeName;
  String? priceAdjustment;
  bool? isDefault;

  Size({
    this.id,
    this.sizeName,
    this.priceAdjustment,
    this.isDefault,
  });

  Size copyWith({
    int? id,
    String? sizeName,
    String? priceAdjustment,
    bool? isDefault,
  }) =>
      Size(
        id: id ?? this.id,
        sizeName: sizeName ?? this.sizeName,
        priceAdjustment: priceAdjustment ?? this.priceAdjustment,
        isDefault: isDefault ?? this.isDefault,
      );

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    id: json["id"],
    sizeName: json["size_name"],
    priceAdjustment: json["price_adjustment"],
    isDefault: json["is_default"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "size_name": sizeName,
    "price_adjustment": priceAdjustment,
    "is_default": isDefault,
  };

  // Helper to get the numeric price
  double getNumericPrice() {
    if (priceAdjustment == null) return 0.0;

    try {
      return double.parse(priceAdjustment!);
    } catch (e) {
      return 0.0;
    }
  }
}