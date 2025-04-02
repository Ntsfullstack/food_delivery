// cart_controller.dart
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/models/cart/cart.dart';
import 'package:food_delivery_app/base/networking/api_response.dart';
import '../home_screen/home_controller.dart';

class CartController extends BaseController {
  // Các thuộc tính hiện có
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxInt totalItems = 0.obs;
  late final RxBool _isLoading = false.obs; // Add this if not in BaseController
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  
  // Truy cập HomeController
  HomeController get homeController => Get.find<HomeController>();
  
  @override
  void onInit() {
    super.onInit();
    // Các khởi tạo khác của CartController
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      _isLoading.value = true; // Start loading
      hasError.value = false;

      // Small delay to ensure loading indicator shows
      await Future.delayed(Duration(milliseconds: 300));

      final response = await cartRepository.getCart();

      if (response.success == 200) {
        // Clear current items
        cartItems.clear();

        // Add items from API response
        if (response.data != null) {
          cartItems.addAll(response.data as List<CartItem>);

          // Calculate total amount and items
          _calculateTotal();
        }
      } else {
        hasError.value = true;
        errorMessage.value = response.message ?? 'Error fetching cart items';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      // Make sure isLoading is set to false regardless of success or failure
      _isLoading.value = false;
      hideLoading();
    }
  }

  void _calculateTotal() {
    // Calculate total amount from items
    totalAmount.value = cartItems.fold(
      0,
      (sum, item) => sum + (item.subtotal ?? 0),
    );

    // Count total items
    totalItems.value = cartItems.length;
  }



  Future<void> removeItem(CartItem item) async {
    try {
      _isLoading.value = true;
      showLoading(message: 'Đang xóa khỏi giỏ hàng...');

      // Cập nhật UI trước để phản hồi nhanh
      final index = cartItems.indexWhere((element) => element.cartId == item.cartId);
      if (index != -1) {
        cartItems.removeAt(index);
        _calculateTotal();  // Cập nhật tổng tiền ngay lập tức
        cartItems.refresh(); // Thông báo UI cập nhật
      }

      // Gọi API để xóa item
      await cartRepository.removeFromCart(item.cartId!);
      await fetchCartItems();
    } catch (e) {
      await fetchCartItems();

      hasError.value = true;
      errorMessage.value = 'Lỗi khi xóa món ăn: ${e.toString()}';

      Get.snackbar(
        'Lỗi',
        'Không thể xóa món ăn khỏi giỏ hàng',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      _isLoading.value = false;
      hideLoading();
    }
  }

  Future<void> changeQuantity(CartItem item, int newQuantity) async {
    try {
      // Nếu số lượng mới là 0, xóa item khỏi giỏ hàng
      if (newQuantity <= 0) {
        removeItem(item);
        return;
      }

      // Cập nhật UI trước để phản hồi nhanh
      final index = cartItems.indexWhere((element) => element.cartId == item.cartId);
      if (index != -1) {
        // Lưu lại số lượng cũ để khôi phục nếu có lỗi
        final oldQuantity = cartItems[index].quantity;

        // Cập nhật số lượng và tổng tiền
        cartItems[index].quantity = newQuantity;
        cartItems[index].subtotal = (cartItems[index].price ?? 0) * newQuantity;
        _calculateTotal();  // Cập nhật tổng tiền
        cartItems.refresh(); // Thông báo UI cập nhật
      }

      // Hiển thị loading không chặn UI
      _isLoading.value = true;
      // await cartRepository.updateCartItem(item.cartId!, newQuantity);
      // await fetchCartItems();
    } catch (e) {
      // Nếu có lỗi, cập nhật lại từ server
      await fetchCartItems();

      hasError.value = true;
      errorMessage.value = 'Lỗi khi cập nhật số lượng: ${e.toString()}';

      Get.snackbar(
        'Lỗi',
        'Không thể cập nhật số lượng món ăn',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      _isLoading.value = false;
    }
  }


  Future<void> clearCart() async {
    try {
      _isLoading.value = true;
      showLoading(message: 'Đang xóa giỏ hàng...');

      // API call would go here
      // await cartRepository.clearCart();

      // Refresh cart
      await fetchCartItems();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Error clearing cart: ${e.toString()}';
    } finally {
      _isLoading.value = false;
      hideLoading();
    }
  }

  void proceedToCheckout() {
    // Implement checkout logic
    Get.toNamed('/checkout');
  }
}
