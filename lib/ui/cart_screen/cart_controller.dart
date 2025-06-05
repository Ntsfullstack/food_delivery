// cart_controller.dart
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_controller.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_controller.dart';
import 'package:food_delivery_app/models/cart/cart.dart';
import '../../models/profile/profile.dart';
import '../home_screen/home_controller.dart';
import 'package:food_delivery_app/models/order/send_order.dart';
import 'package:get/get.dart';
import '../profile_screen/profile_controller.dart';

class CartController extends BaseController {
  // Các thuộc tính hiện có
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxInt totalItems = 0.obs;
  late final RxBool _isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<Profile?> profile = Rx<Profile?>(null);

  // Thêm biến cho việc sử dụng xu
  final RxBool useCoin = false.obs;
  final RxInt availableCoins = 0.obs;
  final RxInt coinsToUse = 0.obs;

  // Truy cập HomeController
  HomeController get homeController => Get.find<HomeController>();
  SettingsController settingsController = Get.find<SettingsController>();
  ProfileController get profileController => Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();
    // Ensure ProfileController is initialized
    if (!Get.isRegistered<ProfileController>()) {
      Get.put(ProfileController(), permanent: true);
    }
    ever(Get.find<ProfileController>().profile, (_) {
      loadUserCoins();
    });
  }

  @override
  void onReady() {
    super.onReady();
    fetchCartItems();
    loadProfile();
    loadUserCoins();
  }

  Future<void> loadProfile() async {
    try {
      final response = await authRepositories.getProfile();
      profile.value = response;
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showError(message: 'Không thể tải thông tin: ${e.toString()}');
      });
    }
  }

  Future<void> fetchCartItems() async {
    try {
      _isLoading.value = true;
      hasError.value = false;

      await Future.delayed(const Duration(milliseconds: 300));

      final response = await cartRepository.getCart();

      if (response.success == 200) {
        cartItems.clear();

        if (response.data != null) {
          cartItems.addAll(response.data as List<CartItem>);
          calculateTotal();
        }
      } else {
        hasError.value = true;
        errorMessage.value = response.message ?? 'Error fetching cart items';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
      hideLoading();
    }
  }

  void calculateTotal() {
    double sum = 0;
    for (var item in cartItems) {
      sum += (item.price ?? 0) * (item.quantity ?? 1);
    }
    
    // Trừ đi số xu sử dụng (1 xu = 1 VNĐ)
    if (useCoin.value) {
      sum = sum - coinsToUse.value;
    }
    
    totalAmount.value = sum;
    totalItems.value = cartItems.length;
  }

  Future<void> removeItem(CartItem item) async {
    try {
      if (item.cartId == null) {
        throw Exception("Không thể xóa món ăn có cartId null");
      }

      _isLoading.value = true;
      showLoading(message: 'Đang xóa khỏi giỏ hàng...');

      await cartRepository.removeFromCart(item.cartId!);

      final index = cartItems.indexWhere((element) => element.cartId == item.cartId);
      if (index != -1) {
        cartItems.removeAt(index);
        calculateTotal();
        cartItems.refresh();
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

      await fetchCartItems();
    } finally {
      _isLoading.value = false;
      hideLoading();
    }
  }

  Future<void> changeQuantity(CartItem item, int newQuantity) async {
    try {
      if (item.cartId == null) {
        throw Exception("Không thể cập nhật món ăn có cartId null");
      }

      if (newQuantity <= 0) {
        removeItem(item);
        return;
      }

      final index = cartItems.indexWhere((element) => element.cartId == item.cartId);
      if (index != -1) {
        final oldQuantity = cartItems[index].quantity;

        cartItems[index].quantity = newQuantity;
        cartItems[index].subtotal = (cartItems[index].price ?? 0) * newQuantity;
        calculateTotal();
        cartItems.refresh();
      }

      _isLoading.value = true;
    } catch (e) {
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
        calculateTotal();
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

  // Future<void> proceedToCheckout() async {
  //   try {
  //     _isLoading.value = true;
  //     showLoading(message: 'Đang xử lý đơn hàng...');
  //
  //     // Kiểm tra giỏ hàng trống
  //     if (cartItems.isEmpty) {
  //       throw Exception("Giỏ hàng trống, không thể đặt hàng");
  //     }
  //
  //     // Chuẩn bị dữ liệu đơn hàng
  //     List<Map<String, dynamic>> orderItems = cartItems
  //         .where((item) => item.dishId != null && item.quantity != null)
  //         .map((item) => {
  //       "dishId": item.dishId,
  //       "quantity": item.quantity
  //     })
  //         .toList();
  //
  //     if (orderItems.isEmpty) {
  //       throw Exception("Không có món hàng hợp lệ trong giỏ hàng");
  //     }
  //
  //     // Đặt hàng
  //     final response = await orderRepositories.placeOrder(
  //       items: orderItems,
  //     );
  //
  //     // ĐẢM BẢO ĐÓNG DIALOG LOADING TRƯỚC KHI XỬ LÝ KẾT QUẢ
  //     _isLoading.value = false;
  //     hideLoading();
  //
  //     if (response.success == 200) {
  //       // Xóa dữ liệu giỏ hàng cục bộ trước
  //       cartItems.clear();
  //       calculateTotal();
  //
  //       // Hiển thị thông báo thành công
  //       Get.snackbar(
  //         'Thành công',
  //         'Đơn hàng của bạn đã được đặt thành công',
  //         backgroundColor: Colors.green[400],
  //         colorText: Colors.white,
  //         snackPosition: SnackPosition.TOP,
  //         duration: const Duration(seconds: 3),
  //       );
  //
  //       // Xóa giỏ hàng trên server một cách riêng biệt trong background
  //       // mà không ảnh hưởng đến luồng chính
  //       Future.microtask(() {
  //         try {
  //           // Gọi API xóa giỏ hàng thông qua repository nhưng không đợi kết quả
  //           // và không quan tâm đến lỗi
  //           cartRepository.clearCart().then((_) {
  //             print("Đã xóa giỏ hàng trên server sau khi đặt hàng");
  //           }).catchError((error) {
  //             // Chỉ ghi log lỗi, không làm gì thêm
  //             print("Lỗi khi xóa giỏ hàng trên server (bỏ qua): $error");
  //           });
  //         } catch (_) {
  //           // Bỏ qua mọi lỗi
  //         }
  //       });
  //
  //       // Quay lại màn hình trước đó ngay lập tức
  //       Get.back();
  //     } else {
  //       throw Exception(response.message ?? 'Đặt hàng thất bại');
  //     }
  //   } catch (e) {
  //     // ĐẢM BẢO ĐÓNG DIALOG LOADING TRONG TRƯỜNG HỢP LỖI
  //     _isLoading.value = false;
  //     hideLoading();
  //
  //     hasError.value = true;
  //     errorMessage.value = 'Lỗi khi đặt hàng: ${e.toString()}';
  //
  //     Get.snackbar(
  //       'Lỗi',
  //       'Không thể đặt hàng: ${e.toString()}',
  //       backgroundColor: Colors.red[400],
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  //   // BỎ PHẦN FINALLY VÌ ĐÃ XỬ LÝ ĐÓNG DIALOG TRONG TRY VÀ CATCH
  // }

  void loadUserCoins() {
    try {
      final profileController = Get.find<ProfileController>();
      if (profileController.profile.value != null) {
        final walletBalance = profileController.profile.value?.walletBalance;
        print('Raw wallet balance: $walletBalance');
        print('Wallet balance type: ${walletBalance.runtimeType}');
        
        if (walletBalance != null) {
          num balance;
          balance = double.tryParse(walletBalance) ?? 0;

          availableCoins.value = balance.toInt();
          print('Available coins set to: ${availableCoins.value}');
        }
      }
    } catch (e) {
      print('Error loading user coins: $e');
      print('Error details: ${e.toString()}');
      availableCoins.value = 0;
    }
  }
  void toggleUseCoin(bool value) {
    useCoin.value = value;
    if (value) {
      final maxCoinsAllowed = (totalAmount.value * 0.5).floor();
      coinsToUse.value = availableCoins.value < maxCoinsAllowed 
          ? availableCoins.value 
          : maxCoinsAllowed;
    } else {
      coinsToUse.value = 0;
    }
    calculateTotal();
  }

  Future<void> placeOrder() async {
    if (cartItems.isEmpty) {
      showError(message: 'Giỏ hàng trống');
      return;
    }

    try {
      _isLoading.value = true;
      showLoading(message: 'Đang đặt hàng...');

      // Validate cart items and filter out invalid ones
      final List<Map<String, dynamic>> orderItems = cartItems
          .where((item) => item.dishId != null && item.quantity != null && item.quantity! > 0)
          .map((item) => {
        "dishId": item.dishId,
        "quantity": item.quantity,
      }).toList();

      if (orderItems.isEmpty) {
        throw Exception('Không có món ăn hợp lệ trong giỏ hàng');
      }

      print('Sending order items: $orderItems');

      final orderResponse = await orderRepositories.placeOrder(items: orderItems);
      print('Order response: $orderResponse');

      // Validate response data
      if (orderResponse.data == null || orderResponse.data!.isEmpty) {
        throw Exception('Không nhận được dữ liệu đơn hàng từ server');
      }

      // Extract orderId with proper type checking
      dynamic firstOrderData = orderResponse.data![0];
      String? orderId;


      if (firstOrderData is Map<String, dynamic> && firstOrderData.containsKey('orderId')) {
        orderId = firstOrderData['orderId']?.toString();
      }

      if (orderId == null || orderId.isEmpty) {
        throw Exception('Không tìm thấy orderId trong phản hồi từ server');
      }

      print('Processing order with ID: $orderId');

      // Use coins if enabled
      bool coinUsageSuccessful = true;
      if (useCoin.value && coinsToUse.value > 0) {
        print('Attempting to use ${coinsToUse.value} coins for order $orderId');
        try {
          final coinResponse = await orderRepositories.useCoin(
            orderId,
            coinsToUse.value,


          );
          print('Coin usage response: $coinResponse');

          if (coinResponse.success != 200) {
            coinUsageSuccessful = false;
            print('Server returned non-success status for coin usage: ${coinResponse.success}');
          }
        } catch (e) {
          coinUsageSuccessful = false;
          print('Error using coins: $e');
          print('Stack trace: ${e is Error ? e.stackTrace : ''}');
        }
      }

      // Xóa giỏ hàng và cập nhật UI
      cartItems.clear();
      calculateTotal();

      hideLoading();

      // Show appropriate message based on coin usage result
      if (useCoin.value && coinsToUse.value > 0 && !coinUsageSuccessful) {
        showSuccess(message: 'Đặt hàng thành công nhưng không thể sử dụng xu');
      } else {
        showSuccess(message: 'Đặt hàng thành công');
      }

      // Update profile to reflect any coin changes
      await loadProfile();
      loadUserCoins();
    } catch (e) {
      print('Error in placeOrder: $e');
      print('Stack trace: ${e is Error ? e.stackTrace : ''}');
      hideLoading();
      showError(message: 'Không thể đặt hàng: ${e.toString()}');
    } finally {
      _isLoading.value = false;
    }
  }
}