import 'cart.dart';

class CartDeleteResponse {
  final int statusCode;
  final String message;
  final CartItemDetail data;
  final List<CartItem> cart;
  final double totalAmount;
  final int totalItems;

  CartDeleteResponse({
    required this.statusCode,
    required this.message,
    required this.data,
    required this.cart,
    required this.totalAmount,
    required this.totalItems,
  });

  factory CartDeleteResponse.fromJson(Map<String, dynamic> json) {
    return CartDeleteResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: CartItemDetail.fromJson(json['data']),
      cart: List<CartItem>.from(json['cart'].map((x) => CartItem.fromJson(x))),
      totalAmount: json['totalAmount']?.toDouble() ?? 0.0,
      totalItems: json['totalItems'] ?? 0,
    );
  }
}

class CartItemDetail {
  final int cartId;
  final String userId;
  final int dishId;
  final int sizeId;
  final int quantity;
  final String createdAt;
  final String updatedAt;

  CartItemDetail({
    required this.cartId,
    required this.userId,
    required this.dishId,
    required this.sizeId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItemDetail.fromJson(Map<String, dynamic> json) {
    return CartItemDetail(
      cartId: json['cart_id'],
      userId: json['user_id'],
      dishId: json['dish_id'],
      sizeId: json['size_id'],
      quantity: json['quantity'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}