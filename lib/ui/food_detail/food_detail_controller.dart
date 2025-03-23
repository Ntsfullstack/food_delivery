import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/models/food/dishes.dart';

import '../../base/base_controller.dart';

class FoodDetailController extends BaseController {
  // Dish data
  final Rx<ListDishes?> dish = Rx<ListDishes?>(null);

  // UI states
  final RxBool isFavorite = false.obs;
  final RxInt quantity = 1.obs;
  final RxInt selectedSizeIndex = 0.obs;

  @override
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

  // Calculate total price based on selected size and quantity
  double getTotalPrice() {
    if (dish.value == null || dish.value!.sizes == null || dish.value!.sizes!.isEmpty) {
      return 0.0;
    }

    int sizeIndex = selectedSizeIndex.value;
    if (sizeIndex >= dish.value!.sizes!.length) {
      sizeIndex = 0;
    }

    int? price = dish.value!.sizes![sizeIndex].price;
    return ((price ?? 0) / 1000.0) * quantity.value;
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