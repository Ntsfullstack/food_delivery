// cart.dart - Updated Model
import 'dart:convert';

class CartResponse {
  final List<CartItem> items;
  final double totalAmount;
  final int totalItems;

  CartResponse({
    required this.items,
    required this.totalAmount,
    required this.totalItems,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      items: json["data"] != null
          ? List<CartItem>.from(json["data"].map((x) => CartItem.fromJson(x)))
          : [],
      totalAmount: json["totalAmount"]?.toDouble() ?? 0.0,
      totalItems: json["totalItems"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(items.map((x) => x.toJson())),
    "totalAmount": totalAmount,
    "totalItems": totalItems,
  };
}

class CartItem {
  int? cartId;
  int? dishId;
  String? name;
  String? description;
  String? imageUrl;
  int? categoryId;
  bool? isAvailable;
  Size? size;
  double? subtotal;
  double? price;
  int? quantity;

  CartItem({
    this.cartId,
    this.dishId,
    this.name,
    this.description,
    this.imageUrl,
    this.categoryId,
    this.isAvailable,
    this.size,
    this.subtotal,
    this.price,
    this.quantity,
  });

  CartItem copyWith({
    int? cartId,
    int? dishId,
    String? name,
    String? description,
    String? imageUrl,
    int? categoryId,
    bool? isAvailable,
    Size? size,
    double? subtotal,
    double? price,
    int? quantity,
  }) =>
      CartItem(
        cartId: cartId ?? this.cartId,
        dishId: dishId ?? this.dishId,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        categoryId: categoryId ?? this.categoryId,
        isAvailable: isAvailable ?? this.isAvailable,
        size: size ?? this.size,
        subtotal: subtotal ?? this.subtotal,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
      );

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    cartId: json["cartId"],
    dishId: json["dishId"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    categoryId: json["categoryId"],
    isAvailable: json["isAvailable"],
    size: json["size"] == null ? null : Size.fromJson(json["size"]),
    subtotal: json["subtotal"]?.toDouble(),
    price: json["price"]?.toDouble(),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "cartId": cartId,
    "dishId": dishId,
    "name": name,
    "description": description,
    "imageUrl": imageUrl,
    "categoryId": categoryId,
    "isAvailable": isAvailable,
    "size": size?.toJson(),
    "subtotal": subtotal,
    "price": price,
    "quantity": quantity,
  };
}

class Size {
  int? sizeId;
  String? sizeName;

  Size({
    this.sizeId,
    this.sizeName,
  });

  Size copyWith({
    int? sizeId,
    String? sizeName,
  }) =>
      Size(
        sizeId: sizeId ?? this.sizeId,
        sizeName: sizeName ?? this.sizeName,
      );

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    sizeId: json["sizeId"],
    sizeName: json["sizeName"],
  );

  Map<String, dynamic> toJson() => {
    "sizeId": sizeId,
    "sizeName": sizeName,
  };
}