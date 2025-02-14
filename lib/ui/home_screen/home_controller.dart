// home_controller.dart
import 'package:get/get.dart';

class HomeController extends GetxController {
  var searchText = ''.obs;
  var selectedCategory = 0.obs;
  var currentBannerIndex = 0.obs;

  final categories = [
    {'icon': 'assets/icons/snacks.png', 'name': 'Snacks'},
    {'icon': 'assets/icons/meal.png', 'name': 'Meal'},
    {'icon': 'assets/icons/vegan.png', 'name': 'Vegan'},
    {'icon': 'assets/icons/dessert.png', 'name': 'Dessert'},
    {'icon': 'assets/icons/drinks.png', 'name': 'Drinks'},
  ];

  final bestSellers = [
    {'name': 'Sushi Roll', 'price': 103.0, 'image': 'assets/images/sushi.jpg'},
    {'name': 'Chicken Rice', 'price': 50.0, 'image': 'assets/images/chicken.jpg'},
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

  void setSelectedCategory(int index) {
    selectedCategory.value = index;
  }

  void setBannerIndex(int index) {
    currentBannerIndex.value = index;
  }
}
