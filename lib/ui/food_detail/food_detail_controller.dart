import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodDetailController extends GetxController {
  // Food item data passed from previous screen
  late Map<String, dynamic> foodItem;

  // UI states
  var isFavorite = false.obs;
  var quantity = 1.obs;
  var selectedSizeIndex = 0.obs;
  var selectedAddOns = <int>[].obs;

  // Size options
  final sizes = [
    {'name': 'Nhỏ', 'price': 0.0},
    {'name': 'Vừa', 'price': 2.0},
    {'name': 'Lớn', 'price': 4.0},
  ];

  // Add-on options
  final addOns = [
    {
      'name': 'Thêm phô mai',
      'price': 1.0,
      'icon': Icons.egg_alt_rounded,
    },
    {
      'name': 'Thêm đồ chua',
      'price': 0.5,
      'icon': Icons.spa_rounded,
    },
    {
      'name': 'Thêm nước sốt',
      'price': 0.75,
      'icon': Icons.water_drop_rounded,
    },
    {
      'name': 'Không đường (đặc biệt)',
      'price': 0.0,
      'icon': Icons.healing_rounded,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    foodItem = Get.arguments as Map<String, dynamic>;
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
    selectedSizeIndex.value = index;
  }

  void toggleAddOn(int index) {
    if (selectedAddOns.contains(index)) {
      selectedAddOns.remove(index);
    } else {
      selectedAddOns.add(index);
    }
  }

  // Calculate total price including size and add-ons
  double getTotalPrice() {
    double basePrice = foodItem['price'] as double;
    double sizePrice = sizes[selectedSizeIndex.value]['price'] as double;
    double addOnsPrice = 0.0;

    for (var index in selectedAddOns) {
      addOnsPrice += addOns[index]['price'] as double;
    }

    return (basePrice + sizePrice + addOnsPrice) * quantity.value;
  }

  // Generate description based on food name
  String getDescription() {
    final name = foodItem['name'].toString().toLowerCase();

    if (name.contains('phở') || name.contains('pho')) {
      return 'Phở là một món ăn truyền thống của Việt Nam, nổi tiếng với nước dùng thơm ngon được ninh từ xương bò và các loại gia vị đặc trưng, kết hợp với bánh phở mềm, thịt bò tái và các loại rau thơm.';
    } else if (name.contains('burger')) {
      return 'Burger thịt bò thơm ngon với lớp thịt bò 100% tươi ngon được nướng tới độ chín hoàn hảo, kết hợp với phô mai, rau xà lách tươi, cà chua và sốt đặc biệt trong một chiếc bánh mì mềm xốp.';
    } else if (name.contains('bánh xèo') || name.contains('banh xeo')) {
      return 'Bánh xèo là món ăn truyền thống của Việt Nam với lớp vỏ giòn được làm từ bột gạo, nghệ và nước cốt dừa, bên trong là tôm, thịt, giá đỗ và các loại rau thơm, thường được ăn kèm với rau sống và nước mắm pha chua ngọt.';
    } else if (name.contains('sushi')) {
      return 'Sushi salmon cao cấp được làm từ cá hồi Na Uy tươi ngon nhất, kết hợp với cơm sushi được nấu theo công thức truyền thống, tạo nên hương vị đậm đà, tinh tế mà không kém phần đặc sắc.';
    } else {
      return 'Món ăn đặc biệt được chế biến từ nguyên liệu tươi ngon, kết hợp với các loại gia vị đặc trưng, tạo nên hương vị độc đáo, thơm ngon không thể cưỡng lại. Thưởng thức ngay để cảm nhận vẻ đẹp ẩm thực đích thực.';
    }
  }

  // Get ingredients based on food type
  List<Map<String, String>> getIngredients() {
    final name = foodItem['name'].toString().toLowerCase();

    if (name.contains('phở') || name.contains('pho')) {
      return [
        {'name': 'Thịt bò', 'icon': 'meat.png'},
        {'name': 'Bánh phở', 'icon': 'noodles.png'},
        {'name': 'Hành lá', 'icon': 'green_onion.png'},
        {'name': 'Giá đỗ', 'icon': 'bean_sprouts.png'},
        {'name': 'Gia vị', 'icon': 'spices.png'},
      ];
    } else if (name.contains('burger')) {
      return [
        {'name': 'Thịt bò', 'icon': 'patty.png'},
        {'name': 'Bánh mì', 'icon': 'bun.png'},
        {'name': 'Phô mai', 'icon': 'cheese.png'},
        {'name': 'Rau xà lách', 'icon': 'lettuce.png'},
        {'name': 'Cà chua', 'icon': 'tomato.png'},
      ];
    } else if (name.contains('pizza')) {
      return [
        {'name': 'Đế bánh', 'icon': 'dough.png'},
        {'name': 'Sốt cà chua', 'icon': 'tomato_sauce.png'},
        {'name': 'Phô mai', 'icon': 'cheese.png'},
        {'name': 'Hải sản', 'icon': 'seafood.png'},
        {'name': 'Oregano', 'icon': 'herbs.png'},
      ];
    } else if (name.contains('sushi')) {
      return [
        {'name': 'Cá hồi', 'icon': 'salmon.png'},
        {'name': 'Cơm sushi', 'icon': 'rice.png'},
        {'name': 'Wasabi', 'icon': 'wasabi.png'},
        {'name': 'Gừng muối', 'icon': 'ginger.png'},
        {'name': 'Rong biển', 'icon': 'seaweed.png'},
      ];
    } else {
      return [
        {'name': 'Nguyên liệu 1', 'icon': 'ingredient1.png'},
        {'name': 'Nguyên liệu 2', 'icon': 'ingredient2.png'},
        {'name': 'Nguyên liệu 3', 'icon': 'ingredient3.png'},
        {'name': 'Nguyên liệu 4', 'icon': 'ingredient4.png'},
        {'name': 'Nguyên liệu 5', 'icon': 'ingredient5.png'},
      ];
    }
  }

  void addToCart() {
    Get.snackbar(
      'Thành công',
      '${foodItem['name']} đã được thêm vào giỏ hàng',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
      margin: EdgeInsets.all(8),
      duration: const Duration(seconds: 2),
    );

    // Navigate back after adding to cart
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.back();
    });
  }
}
