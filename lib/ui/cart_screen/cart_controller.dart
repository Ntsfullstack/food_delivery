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
      // Kiểm tra cartId không null
      if (item.cartId == null) {
        throw Exception("Không thể xóa món ăn có cartId null");
      }

      _isLoading.value = true;
      showLoading(message: 'Đang xóa khỏi giỏ hàng...');

      // Gọi API để xóa item
      await cartRepository.removeFromCart(item.cartId!);

      // Cập nhật UI sau khi API thành công
      final index = cartItems.indexWhere((element) => element.cartId == item.cartId);
      if (index != -1) {
        cartItems.removeAt(index);
        _calculateTotal();  // Cập nhật tổng tiền ngay lập tức
        cartItems.refresh(); // Thông báo UI cập nhật
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Lỗi khi xóa món ăn: ${e.toString()}';

      Get.snackbar(
        'Lỗi',
        'Không thể xóa món ăn khỏi giỏ hàng',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Refresh lại giỏ hàng để đồng bộ với server
      await fetchCartItems();
    } finally {
      _isLoading.value = false;
      hideLoading();
    }
  }

  Future<void> changeQuantity(CartItem item, int newQuantity) async {
    try {
      // Kiểm tra cartId không null
      if (item.cartId == null) {
        throw Exception("Không thể cập nhật món ăn có cartId null");
      }

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
      final response = await cartRepository.clearCart();
      if (response.statusCode == 200) {
        cartItems.clear();
        Get.snackbar(
          'Thành công',
          'Đã xóa toàn bộ giỏ hàng',
          backgroundColor: Colors.green[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        throw Exception(response.message ?? 'Lỗi khi xóa giỏ hàng');
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Lỗi khi xóa giỏ hàng: ${e.toString()}';

      Get.snackbar(
        'Lỗi',
        'Không thể xóa giỏ hàng',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      await fetchCartItems();
    } finally {
      _isLoading.value = false;
      hideLoading();
    }
  }

  Future<void> proceedToCheckout() async {
    try {
      _isLoading.value = true;
      showLoading(message: 'Đang xử lý đơn hàng...');

      // Kiểm tra giỏ hàng trống
      if (cartItems.isEmpty) {
        throw Exception("Giỏ hàng trống, không thể đặt hàng");
      }

      // Chuẩn bị dữ liệu đơn hàng
      List<Map<String, dynamic>> orderItems = cartItems
          .where((item) => item.dishId != null && item.quantity != null)
          .map((item) => {
        "dishId": item.dishId,
        "quantity": item.quantity
      })
          .toList();

      if (orderItems.isEmpty) {
        throw Exception("Không có món hàng hợp lệ trong giỏ hàng");
      }

      // Đặt hàng
      final response = await orderRepositories.placeOrder(
        items: orderItems,
      );

      // ĐẢM BẢO ĐÓNG DIALOG LOADING TRƯỚC KHI XỬ LÝ KẾT QUẢ
      _isLoading.value = false;
      hideLoading();

      if (response.success == 200) {
        // Xóa dữ liệu giỏ hàng cục bộ trước
        cartItems.clear();
        _calculateTotal();

        // Hiển thị thông báo thành công
        Get.snackbar(
          'Thành công',
          'Đơn hàng của bạn đã được đặt thành công',
          backgroundColor: Colors.green[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );

        // Xóa giỏ hàng trên server một cách riêng biệt trong background
        // mà không ảnh hưởng đến luồng chính
        Future.microtask(() {
          try {
            // Gọi API xóa giỏ hàng thông qua repository nhưng không đợi kết quả
            // và không quan tâm đến lỗi
            cartRepository.clearCart().then((_) {
              print("Đã xóa giỏ hàng trên server sau khi đặt hàng");
            }).catchError((error) {
              // Chỉ ghi log lỗi, không làm gì thêm
              print("Lỗi khi xóa giỏ hàng trên server (bỏ qua): $error");
            });
          } catch (_) {
            // Bỏ qua mọi lỗi
          }
        });

        // Quay lại màn hình trước đó ngay lập tức
        Get.back();
      } else {
        throw Exception(response.message ?? 'Đặt hàng thất bại');
      }
    } catch (e) {
      // ĐẢM BẢO ĐÓNG DIALOG LOADING TRONG TRƯỜNG HỢP LỖI
      _isLoading.value = false;
      hideLoading();

      hasError.value = true;
      errorMessage.value = 'Lỗi khi đặt hàng: ${e.toString()}';

      Get.snackbar(
        'Lỗi',
        'Không thể đặt hàng: ${e.toString()}',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
    // BỎ PHẦN FINALLY VÌ ĐÃ XỬ LÝ ĐÓNG DIALOG TRONG TRY VÀ CATCH
  }
}