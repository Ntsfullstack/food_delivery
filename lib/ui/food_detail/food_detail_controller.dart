import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/models/food/dishes.dart';

import '../../base/base_controller.dart';

class FoodDetailController extends BaseController {
  // Dish data
  final Rx<Dishes?> dish = Rx<Dishes?>(null);

  // UI states
  final RxBool isFavorite = false.obs;
  final RxInt quantity = 1.obs;
  final RxInt selectedSizeIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the dish ID from arguments
    final dishId = Get.arguments;

    // Add this to ensure the widget is fully rendered before loading data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dishId is int) {
        loadDishDetails(dishId.toString());
      } else {
        loadDishDetails(dishId);
      }
    });
  }

  Future<void> loadDishDetails(dynamic dishId) async {
    try {
      showLoading(message: 'Đang tải dữ liệu...');
      final String dishIdString = dishId.toString();
      final response = await productRepositories.getDetailDishes(dishId: dishIdString);
      dish.value = response.data;

      // Đặt selectedSizeIndex về 0 khi load món ăn mới
      selectedSizeIndex.value = 0;
    } catch (e) {
      print('Error loading dish details: $e');
    } finally {
      hideLoading();
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void increaseQuantity() {
    if (quantity.value < 10) {
      quantity.value++;
    }
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void selectSize(int index) {
    if (dish.value?.sizes != null && index >= 0 && index < dish.value!.sizes!.length) {
      selectedSizeIndex.value = index;
    }
  }

  // Lấy giá cơ bản của món ăn
  double getBasePrice() {
    if (dish.value == null) return 0.0;

    try {
      return double.parse(dish.value!.price ?? "0");
    } catch (e) {
      print('Error parsing base price: $e');
      return 0.0;
    }
  }

  // Lấy giá điều chỉnh của size đã chọn
  double getSizeAdjustment() {
    if (dish.value == null || dish.value!.sizes == null || dish.value!.sizes!.isEmpty) {
      return 0.0;
    }

    int index = selectedSizeIndex.value;
    if (index >= dish.value!.sizes!.length) {
      index = 0;
    }

    try {
      String? adjustment = dish.value!.sizes![index].priceAdjustment;
      return adjustment != null ? double.parse(adjustment) : 0.0;
    } catch (e) {
      print('Error parsing size adjustment: $e');
      return 0.0;
    }
  }

  // Calculate total price based on selected size and quantity
  double getTotalPrice() {
    double basePrice = getBasePrice();
    double sizeAdjustment = getSizeAdjustment();
    double finalPrice = basePrice + sizeAdjustment;

    // Áp dụng số lượng
    return finalPrice * quantity.value;
  }

  // Lấy giá hiển thị với định dạng xxK
  String getFormattedPrice() {
    double price = getTotalPrice();
    if (price == 0) return "0K";

    // Định dạng xxK
    return "${(price).toStringAsFixed(1)}K";
  }

  void addToCart() {
    if (dish.value == null) return;

    Get.snackbar(
      'Thành công',
      '${dish.value!.name} đã được thêm vào giỏ hàng',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Get.back();
    });
  }
}