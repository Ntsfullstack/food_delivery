import 'package:food_delivery_app/base/networking/api.dart';
import 'package:food_delivery_app/base/networking/api_response.dart';
import 'package:food_delivery_app/base/networking/constants/endpoint.dart';
import 'package:food_delivery_app/models/cart/cart.dart';
import '../../models/cart/delete_cart.dart';
import '../../models/food/dishes.dart';

class CartRepository {
  late ApiService _service;
  CartRepository({required ApiService apiService}) {
    _service = apiService;
  }

  Future<APIResponse<List<CartItem>>> getCart() async {
    try {
      print('Fetching cart data...');
      var res = await _service.get(Endpoints.listCart);
      print('/api/cart');
      print(res);

      return APIResponse.fromJson(res, (dynamic json) {
        if (json is List) {
          return List<CartItem>.from(json.map((x) => CartItem.fromJson(x)));
        } else {
          print('Returning empty cart list due to format mismatch');
          return <CartItem>[];
        }
      });
    } catch (e) {
      print('Error loading cart: $e');
      throw Exception('Failed to load cart: $e');
    }
  }

  Future<APIResponse<dynamic>> addToCart(Dishes dish, {int? sizeId, int quantity = 1}) async {
    try {
      print('Adding dish to cart: ${dish.name}, sizeId=$sizeId, quantity=$quantity');

      // Determine which sizeId to use if not provided
      int? finalSizeId = sizeId;
      if (finalSizeId == null && dish.sizes != null && dish.sizes!.isNotEmpty) {
        // Try to find default size first
        var defaultSize = dish.sizes!.firstWhere(
              (size) => size.isDefault == true,
          orElse: () => dish.sizes!.first, // Use first size if no default
        );
        finalSizeId = defaultSize.id;
      }

      final body = {
        "dishId": dish.id,
        "sizeId": finalSizeId,
        "quantity": quantity
      };
      var res = await _service.post(Endpoints.addToCart, data: body);
      return APIResponse.fromJson(res, (dynamic json) => json);
    } catch (e) {
      print('Error adding to cart: $e');
      throw Exception('Failed to add to cart: $e');
    }
  }
  Future<CartDeleteResponse> removeFromCart(int cartId) async {
    try {
      print('Removing item from cart: cartId=$cartId');

      var res = await _service.delete('${Endpoints.removeFromCart}/$cartId');
      print('Remove from cart response:');
      print(res);

      return CartDeleteResponse.fromJson(res);
    } catch (e) {
      print('Error removing from cart: $e');
      throw Exception('Failed to remove from cart: $e');
    }
  }
}
