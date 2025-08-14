import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food/dishes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/base_controller.dart';
import 'rating_dialog.dart';

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

      print('Loaded dish: ${dish.value?.name}');
      print('Ratings count: ${dish.value?.ratings?.length ?? 0}');
      if (dish.value?.ratings != null) {
        print('Ratings: ${dish.value!.ratings}');
      }

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
      return double.parse(dish.value!.price.toString() ?? "0");
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
      String? adjustment = dish.value!.sizes![index].priceAdjustment.toString();
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
  // String getFormattedPrice() {
  //   double price = getTotalPrice();
  //   if (price == 0) return "0K";
  //
  //   // Định dạng xxK
  //   return "${(price).toStringAsFixed(1)}K";
  // }

  void addToCart() async {
    if (dish.value == null) return;

    try {
      showLoading(message: 'Đang thêm vào giỏ hàng...');
      int? sizeId;
      if (dish.value!.sizes != null && dish.value!.sizes!.isNotEmpty) {
        sizeId = dish.value!.sizes![selectedSizeIndex.value].id;
      }
      await cartRepository.addToCart(
          dish.value!,  // Truyền đối tượng Dishes
          sizeId: sizeId,
          quantity: quantity.value
      );

      Get.snackbar(
        'Thành công',
        '${dish.value!.name} đã được thêm vào giỏ hàng',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Có thể quay lại màn hình trước sau khi thêm thành công
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    } catch (e) {
      // Xử lý lỗi
      Get.snackbar(
        'Lỗi',
        'Không thể thêm vào giỏ hàng: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      hideLoading();
    }
  }

  // Rating functionality
  void showRatingDialog() async {
    if (dish.value == null) return;

    // Check if user is logged in
    if (!isUserLoggedIn()) {
      Get.snackbar(
        'Yêu cầu đăng nhập',
        'Vui lòng đăng nhập để đánh giá món ăn',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // Find user's existing rating
    int? currentRating;
    String? currentComment;
    final userRating = _findUserRating();
    if (userRating != null) {
      currentRating = userRating.rating;
      currentComment = userRating.comment;
    }

    final result = await Get.dialog<Map<String, dynamic>>(
      RatingDialog(
        dishName: dish.value!.name ?? 'Món ăn',
        currentRating: currentRating,
        currentComment: currentComment,
      ),
    );

    if (result != null) {
      await _submitRating(result['rating'], result['comment']);
    }
  }

  Rating? _findUserRating() {
    if (dish.value?.ratings == null) return null;
    
    try {
      final prefs = Get.find<SharedPreferences>();
      final currentUserId = prefs.getString('userId');
      
      if (currentUserId == null) return null;
      
      // Find rating by current user
      for (final rating in dish.value!.ratings!) {
        // Note: This assumes the rating has a userId field
        // You may need to adjust this based on your API response structure
        if (rating.id != null) {
          // For now, we'll just return the first rating as the API doesn't seem to include userId in ratings
          // This should be updated when the API includes user information in ratings
          return rating;
        }
      }
    } catch (e) {
      print('Error finding user rating: $e');
    }
    
    return null;
  }

  bool isUserLoggedIn() {
    try {
      final prefs = Get.find<SharedPreferences>();
      final token = prefs.getString('accessToken');
      return token != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> _submitRating(int rating, String comment) async {
    if (dish.value == null) return;

    try {
      showLoading(message: 'Đang gửi đánh giá...');
      
      print('Submitting rating: $rating, comment: $comment');
      
      final response = await productRepositories.rateDish(
        dishId: dish.value!.id.toString(),
        rating: rating,
        comment: comment.isNotEmpty ? comment : null,
      );

      print('Rating response: ${response.data}');

      // Update the dish data with new rating
      if (response.data != null) {
        dish.value = response.data;
      }

      // Reload dish details to get updated ratings
      await loadDishDetails(dish.value!.id.toString());

      Get.snackbar(
        'Thành công',
        'Cảm ơn bạn đã đánh giá món ăn!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error submitting rating: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể gửi đánh giá: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      hideLoading();
    }
  }
}