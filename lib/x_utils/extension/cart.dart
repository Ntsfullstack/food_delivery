// Extension methods for CartItem
import '../../models/cart/cart.dart';

extension CartItemExtension on CartItem {
  String get formattedPrice {
    return price != null ? price!.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]}.'
    ) : "0";
  }

  String? get variant {
    return size?.sizeName;
  }
}