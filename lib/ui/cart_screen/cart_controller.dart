// cart_controller.dart
import 'package:get/get.dart';
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  String get formattedPrice {
    return price.toStringAsFixed(0);
  }
}
class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxDouble totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Load cart items from storage or API
    _calculateTotal();
  }

  void addItem(Product product, {int quantity = 1}) {
    final existingItem = cartItems.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      cartItems.add(CartItem(product: product, quantity: quantity));
    } else {
      existingItem.quantity += quantity;
    }
    _calculateTotal();
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
    _calculateTotal();
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    _calculateTotal();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      cartItems.remove(item);
    }
    _calculateTotal();
  }

  void clearCart() {
    cartItems.clear();
    _calculateTotal();
  }

  void _calculateTotal() {
    totalAmount.value = cartItems.fold(
      0,
          (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  void proceedToCheckout() {
    // Implement checkout logic
    Get.toNamed('/checkout');
  }
}