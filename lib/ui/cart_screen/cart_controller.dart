// cart_controller.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/cart/cart.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_controller.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../routes/router_name.dart';

import '../../base/networking/api.dart';
import '../../models/profile/profile.dart';
import '../home_screen/home_controller.dart';

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

  // Payment related variables
  final RxString selectedPaymentMethod = 'direct'.obs;
  final RxBool isPaymentProcessing = false.obs;
  final RxString currentOrderId = ''.obs;

  // Payment methods available
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'id': 'direct',
      'name': 'Thanh toán trực tiếp',
      'description': 'Thanh toán khi nhận hàng',
      'icon': Icons.payment,
      'color': Colors.green,
    },
    {
      'id': 'zalopay',
      'name': 'ZaloPay',
      'description': 'Thanh toán qua ZaloPay',
      'icon': Icons.qr_code,
      'color': Colors.blue,
    },
    {
      'id': 'wallet',
      'name': 'Ví điện tử',
      'description': 'Sử dụng số dư trong ví',
      'icon': Icons.account_balance_wallet,
      'color': Colors.orange,
    },
  ];

  // Truy cập HomeController
  HomeController get homeController => Get.find<HomeController>();
  SettingsController settingsController = Get.find<SettingsController>();
  ProfileController get profileController => Get.find<ProfileController>();

  // API service for payment
  final ApiService apiService = ApiService();

  // Helper method to decode base64 image data
  Uint8List? _decodeBase64Image(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return null;
    }

    try {
      // Remove data:image/png;base64, prefix if present
      String cleanBase64 = base64String;
      if (base64String.startsWith('data:image/')) {
        final commaIndex = base64String.indexOf(',');
        if (commaIndex != -1) {
          cleanBase64 = base64String.substring(commaIndex + 1);
        }
      }

      return base64Decode(cleanBase64);
    } catch (e) {
      print('Error decoding base64 image: $e');
      return null;
    }
  }

  // Build QR Code widget that handles both base64 images and regular QR data
  Widget _buildQRCodeWidget(dynamic qrData) {
    if (qrData == null) {
      return const Center(
        child: Text(
          'QR Code không khả dụng',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      );
    }

    final qrString = qrData.toString();

    // Check if it's a base64 image
    if (qrString.startsWith('data:image/')) {
      final imageBytes = _decodeBase64Image(qrString);
      if (imageBytes != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            imageBytes,
            width: 180,
            height: 180,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'Không thể hiển thị QR Code',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        );
      }
    }

    // If not base64 or decoding failed, try to generate QR code from text
    if (qrString.isNotEmpty) {
      return QrImageView(
        data: qrString,
        version: QrVersions.auto,
        size: 180.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        errorCorrectionLevel: QrErrorCorrectLevel.M,
      );
    }

    // Fallback if no valid data
    return const Center(
      child: Text(
        'QR Code không khả dụng',
        style: TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }

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

      final index =
      cartItems.indexWhere((element) => element.cartId == item.cartId);
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

      final index =
      cartItems.indexWhere((element) => element.cartId == item.cartId);
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
          .where((item) =>
      item.dishId != null &&
          item.quantity != null &&
          item.quantity! > 0)
          .map((item) => {
        "dishId": item.dishId,
        "quantity": item.quantity,
      })
          .toList();

      if (orderItems.isEmpty) {
        throw Exception('Không có món ăn hợp lệ trong giỏ hàng');
      }

      print('Sending order items: $orderItems');

      final orderResponse =
      await orderRepositories.placeOrder(items: orderItems);
      print('Order response: $orderResponse');

      // Validate response data
      if (orderResponse.data == null || orderResponse.data!.isEmpty) {
        throw Exception('Không nhận được dữ liệu đơn hàng từ server');
      }

      // Extract orderId with proper type checking
      dynamic firstOrderData = orderResponse.data![0];
      String? orderId;

      if (firstOrderData is Map<String, dynamic> &&
          firstOrderData.containsKey('orderId')) {
        orderId = firstOrderData['orderId']?.toString();
      }

      if (orderId == null || orderId.isEmpty) {
        throw Exception('Không tìm thấy orderId trong phản hồi từ server');
      }

      print('Processing order with ID: $orderId');

      // Set current order ID for payment processing
      currentOrderId.value = orderId;

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
            print(
                'Server returned non-success status for coin usage: ${coinResponse.success}');
          }
        } catch (e) {
          coinUsageSuccessful = false;
          print('Error using coins: $e');
          print('Stack trace: ${e is Error ? e.stackTrace : ''}');
        }
      }

      hideLoading();

      // Show appropriate message based on coin usage result
      if (useCoin.value && coinsToUse.value > 0 && !coinUsageSuccessful) {
        showSuccess(message: 'Đặt hàng thành công nhưng không thể sử dụng xu');
      } else {
        showSuccess(message: 'Đặt hàng thành công');
      }

      // If direct payment, no further processing needed
      if (selectedPaymentMethod.value == 'direct') {
        // Clear cart and return
        cartItems.clear();
        calculateTotal();
        await loadProfile();
        loadUserCoins();
        Get.back(); // Return to previous screen
        return;
      }

      // For other payment methods, proceed to payment processing
      await processPayment();
    } catch (e) {
      print('Error in placeOrder: $e');
      print('Stack trace: ${e is Error ? e.stackTrace : ''}');
      hideLoading();
      showError(message: 'Không thể đặt hàng: ${e.toString()}');
    } finally {
      _isLoading.value = false;
    }
  }

  // Payment methods
  void selectPaymentMethod(String methodId) {
    selectedPaymentMethod.value = methodId;
  }

  Future<void> processPayment() async {
    if (currentOrderId.isEmpty) {
      showError(message: 'Vui lòng đặt hàng trước khi thanh toán');
      return;
    }

    try {
      isPaymentProcessing.value = true;
      showLoading(message: 'Đang xử lý thanh toán...');

      if (selectedPaymentMethod.value == 'direct') {
        // Direct payment - no processing needed
        showSuccess(
            message:
            'Đơn hàng đã được xác nhận. Vui lòng thanh toán khi nhận hàng.');
        Get.back(); // Return to previous screen
        return;
      }

      if (selectedPaymentMethod.value == 'wallet') {
        // Wallet payment
        await _processWalletPayment();
        return;
      }

      if (selectedPaymentMethod.value == 'zalopay') {
        // ZaloPay payment
        await _processZaloPayPayment();
        return;
      }
    } catch (e) {
      hideLoading();
      showError(message: 'Lỗi xử lý thanh toán: ${e.toString()}');
    } finally {
      isPaymentProcessing.value = false;
    }
  }

  Future<void> _processWalletPayment() async {
    try {
      // This would call the backend to process wallet payment
      // For now, we'll simulate the process
      await Future.delayed(const Duration(seconds: 2));

      hideLoading();
      showSuccess(message: 'Thanh toán qua ví thành công!');
      Get.back();
    } catch (e) {
      hideLoading();
      showError(message: 'Lỗi thanh toán qua ví: ${e.toString()}');
    }
  }

  Future<void> _processZaloPayPayment() async {
    try {
      // Calculate total amount - totalAmount.value đã được trừ xu rồi
      // Nếu muốn gửi đúng tổng tiền gốc, cần tính lại
      double originalTotal = 0;
      for (var item in cartItems) {
        originalTotal += (item.price ?? 0) * (item.quantity ?? 1);
      }
      
      // Số tiền cần thanh toán = tổng gốc - xu đã sử dụng
      final totalPaymentAmount = originalTotal - (useCoin.value ? coinsToUse.value : 0);

      print('Original total: $originalTotal');
      print('Coins used: ${useCoin.value ? coinsToUse.value : 0}');
      print('Payment amount: $totalPaymentAmount');

      // Call backend to create ZaloPay payment for full amount
      final paymentResponse = await _createZaloPayPayment(totalPaymentAmount);

      hideLoading();

      if (paymentResponse['status'] == 'success') {
        // Show payment options
        _showZaloPayOptions(paymentResponse);
      } else {
        throw Exception(
            paymentResponse['message'] ?? 'Không thể tạo thanh toán ZaloPay');
      }
    } catch (e) {
      hideLoading();
      showError(message: 'Lỗi tạo thanh toán ZaloPay: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> _createZaloPayPayment(double amount) async {
    try {
      // Make actual API call to create ZaloPay payment
      final response = await apiService.post(
        '/api/payments/create-payment',
        data: {
          'order_id': currentOrderId.value,
          'amount': amount.toInt(),
          'description':
          'Thanh toán đơn hàng #${currentOrderId.value}',
          'redirect_url': 'https://food-delivery-app.com/payment-success',
          'payment_method': 'zalopay',
        },
        options: Options(
          headers: {
            'requiresToken': true, // This will add Authorization header
          },
        ),
      );

      return response;
    } catch (e) {
      print('Error creating ZaloPay payment: $e');
      rethrow;
    }
  }

  void _showZaloPayOptions(Map<String, dynamic> paymentData) {
    Get.dialog(
      AlertDialog(
        title: const Text('Chọn phương thức thanh toán ZaloPay'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.qr_code, color: Colors.blue),
              title: const Text('Quét mã QR'),
              subtitle: const Text('Mở ZaloPay và quét mã QR'),
              onTap: () => _openZaloPayQR(paymentData),
            ),
            ListTile(
              leading: const Icon(Icons.open_in_new, color: Colors.green),
              title: const Text('Mở ZaloPay'),
              subtitle: const Text('Chuyển đến ứng dụng ZaloPay'),
              onTap: () => _openZaloPayApp(paymentData),
            ),
            ListTile(
              leading: const Icon(Icons.web, color: Colors.orange),
              title: const Text('Thanh toán web'),
              subtitle: const Text('Thanh toán qua trình duyệt'),
              onTap: () => _openZaloPayWeb(paymentData),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Hủy'),
          ),
        ],
      ),
    );
  }

  Future<void> _openZaloPayQR(Map<String, dynamic> paymentData) async {
    Get.back(); // Close dialog

    // Show QR code dialog
    Get.dialog(
      AlertDialog(
        title: const Text('Mã QR ZaloPay'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildQRCodeWidget(paymentData['qr_code']),
            ),
            const SizedBox(height: 16),
            const Text(
              'Mở ZaloPay và quét mã QR này để thanh toán toàn bộ',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  Future<void> _openZaloPayApp(Map<String, dynamic> paymentData) async {
    Get.back(); // Close dialog

    try {
      // Try to open ZaloPay app
      final url =
          'zalopay://payment?amount=${paymentData['amount']}&transId=${paymentData['app_trans_id']}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // Fallback to Play Store
        await launchUrl(Uri.parse('market://details?id=com.zing.zalo'));
      }
    } catch (e) {
      showError(message: 'Không thể mở ZaloPay: ${e.toString()}');
    }
  }

  Future<void> _openZaloPayWeb(Map<String, dynamic> paymentData) async {
    Get.back(); // Close dialog

    // Check if the paymentData contains a valid order_url
    if (paymentData['order_url'] == null || paymentData['order_url'].toString().isEmpty) {
      showError(message: 'Không có URL thanh toán. Vui lòng thử lại.');
      return;
    }

    // Navigate to web payment screen
    Get.toNamed(RouterName.paymentWeb, arguments: {
      'payment_url': paymentData['order_url'],
      'payment_data': paymentData,
    });
  }

  // Check payment status
  Future<void> checkPaymentStatus(String appTransId) async {
    try {
      // This would call your backend to check payment status
      // For now, simulating the process
      await Future.delayed(const Duration(seconds: 2));

      // Mock response
      const status = 'completed'; // This would come from your API

      if (status == 'completed') {
        showSuccess(message: 'Thanh toán thành công!');
        _handlePaymentSuccess();
      } else {
        showError(message: 'Thanh toán chưa hoàn tất. Vui lòng thử lại.');
      }
    } catch (e) {
      showError(message: 'Lỗi kiểm tra trạng thái thanh toán: ${e.toString()}');
    }
  }

  // Handle payment success
  void _handlePaymentSuccess() {
    try {
      // Clear cart after successful payment
      cartItems.clear();
      calculateTotal();

      // Navigate to success screen or back to main screen
      Get.offAllNamed(
          '/bottom-navigation'); // Or whatever your main screen route is

      // Show success message
      Get.snackbar(
        'Thành công',
        'Đơn hàng đã được thanh toán thành công!',
        backgroundColor: Colors.green[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      print('Error handling payment success: $e');
    }
  }

  // Handle payment failure
  void _handlePaymentFailure(String errorMessage) {
    showError(message: 'Thanh toán thất bại: $errorMessage');

    // Optionally navigate back to cart or show retry options
    Get.back(); // Go back to previous screen
  }
}