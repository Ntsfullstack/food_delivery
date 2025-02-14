// home_controller.dart
import 'package:food_delivery_app/core/config/assets/app_images.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var searchText = ''.obs;
  var selectedCategory = 0.obs;
  var currentBannerIndex = 0.obs;
  var greeting = ''.obs;
  var subGreeting = ''.obs;
  var menuTime = ''.obs;
  final categories = [
    {'icon': AppImages.banhmi, 'name': 'Bánh mì'},
    {'icon': AppImages.banhbao, 'name': 'Bánh bao'},
    {'icon': AppImages.xoi, 'name': 'Xôi'},
    {'icon': AppImages.nuoc, 'name': 'Nước'},

  ];

  final bestSellers = [
    {'name': 'Sushi Roll', 'price': 103.0, 'image': 'assets/images/sushi.jpg'},
    {
      'name': 'Chicken Rice',
      'price': 50.0,
      'image': 'assets/images/chicken.jpg'
    },
    {'name': 'Lasagna', 'price': 12.99, 'image': 'assets/images/lasagna.jpg'},
    {'name': 'Cupcake', 'price': 8.20, 'image': 'assets/images/cupcake.jpg'},
  ];

  final recommended = [
    {
      'name': 'Burger',
      'price': 10.0,
      'rating': 5.0,
      'image': 'assets/images/burger.jpg'
    },
    {
      'name': 'Spring Rolls',
      'price': 25.0,
      'rating': 5.0,
      'image': 'assets/images/spring_rolls.jpg'
    },
  ];

  @override
  void onInit() {
    super.onInit();
    updateGreeting(); // Update greeting when controller initializes
  }

  void updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour >=5 && hour <10) {
      greeting.value = 'Chào buổi sáng';
    }
    else if (hour >= 10 && hour < 13) {
      greeting.value = 'Chào buổi trưa';
    } else if (hour >= 13 && hour < 17) {
      greeting.value = 'Chào buổi chiều';
      subGreeting.value = 'Perfect Time For A Light Meal';
    } else {
      greeting.value = 'Chào buổi tối';
      subGreeting.value = 'Enjoy Your Evening Meal';
    }
  }

  void updateMenuTime() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 14) {
      menuTime.value = 'trưa';
      if (hour >= 13 && hour < 24) {
        menuTime.value = 'tối';
      }
    }

  }
  void setSelectedCategory(int index) {
    selectedCategory.value = index;
  }

  void setBannerIndex(int index) {
    currentBannerIndex.value = index;
  }
}
