import 'package:get/get.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/profile/profile.dart';
import 'package:food_delivery_app/models/food/dish_categories.dart';
import '../../models/food/dishes.dart';
import '../cart_screen/cart_controller.dart'; // Import CartController

class HomeController extends BaseController {
  final RxString searchText = ''.obs;
  final RxInt selectedCategory = 0.obs;
  final RxInt currentBannerIndex = 0.obs;
  final RxString greeting = ''.obs;
  final RxString subGreeting = ''.obs;
  final RxString menuTime = ''.obs;

  // Profile reference
  late Rx<Profile?> profile = Rx<Profile?>(null);

  // Cart controller reference
   CartController cartController = Get.find<CartController>();

  // Biến để lưu trữ danh mục từ API
  final RxList<DishesCategory> apiCategories = RxList<DishesCategory>([]);
  // Biến để kiểm tra trạng thái tải danh mục
  final RxBool isLoadingCategories = false.obs;

  // Banner images with promo information
  final banners = [
    {
      'image':
      'https://img.freepik.com/free-photo/food-delivery-banner-background_23-2149150021.jpg',
      'color': 0xFF42A5F5,
      'title': 'Món Việt Nam',
      'subtitle': 'KHUYẾN MÃI ĐẶC BIỆT',
      'discount': 'GIẢM 30%',
    },
    {
      'image':
      'https://img.freepik.com/free-photo/assortment-take-away-food-banner_23-2149098603.jpg',
      'color': 0xFF7E57C2,
      'title': 'Đồ Ăn Nhanh',
      'subtitle': 'THỜI GIAN CÓ HẠN',
      'discount': 'GIẢM 25%',
    },
    {
      'image':
      'https://img.freepik.com/free-photo/food-delivery-service-mockup-banner_23-2149151118.jpg',
      'color': 0xFFEF5350,
      'title': 'Miễn Phí Giao Hàng',
      'subtitle': 'CHỈ HÔM NAY',
      'discount': 'ĐƠN TỪ 50K',
    },
  ];

  // Danh sách cho thực đơn trưa/tối (danh sách chính)
  final RxBool isLoadingMenuDishes = false.obs;
  final RxInt menuCurrentPage = 1.obs;
  final RxBool hasMoreMenuDishes = true.obs;
  final RxList<Dishes> menuDishes = RxList<Dishes>([]);

  // Danh sách cho món theo danh mục
  final RxBool isLoadingCategoryDishes = false.obs;
  final RxInt categoryCurrentPage = 1.obs;
  final RxBool hasMoreCategoryDishes = true.obs;
  final RxList<Dishes> categoryDishes = RxList<Dishes>([]);

  @override
  void onInit() {
    super.onInit();

    // Initialize CartController
    initCartController();

    // Get the shared profile instance
    try {
      profile = Get.find<Rx<Profile?>>();
    } catch (e) {
      profile = Rx<Profile?>(null);
      print('Profile not found in GetX: $e');
    }
    updateGreeting();
    updateMenuTime();

    // Fetch categories first, then dishes for the first category
    getCategories().then((_) {
      // After categories are loaded, fetch dishes for the first category if available
      if (apiCategories.isNotEmpty) {
        int firstCategoryId = apiCategories[0].id ?? 0;
        if (firstCategoryId > 0) {
          print('Initial loading of dishes for first category: $firstCategoryId');
          getListDishesByCategory(categoryId: firstCategoryId);
        }
      }
    });

    // Fetch menu dishes separately
    getMenuDishes();

    // Fetch user profile if needed
    loadProfile();
  }

  Future<void> getCategories() async {
    try {
      isLoadingCategories.value = true;

      final response = await categoryRepositories.getListCategories();

      if (response.data != null && response.data!.isNotEmpty) {
        apiCategories.value = response.data!;
        print('Loaded ${apiCategories.length} categories from API');

        // Make sure the first category is selected
        selectedCategory.value = 0;
      } else {
        print('No categories found or empty response');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  // Initialize CartController
  void initCartController() {
    try {
      // Try to find existing CartController first
      cartController = Get.find<CartController>();
      print('Existing CartController found');
    } catch (e) {
      // If not found, create a new one
      print('Creating new CartController instance');
      cartController = Get.put(CartController());
    }
  }

  // Phương thức lấy món ăn theo danh mục (cho phần "Món theo danh mục")
  Future<void> getListDishesByCategory(
      {bool isLoadMore = false, int? categoryId}) async {
    if (!isLoadMore) {
      categoryCurrentPage.value = 1;
      categoryDishes.clear();
    }
    if (!hasMoreCategoryDishes.value && isLoadMore) return;

    try {
      isLoadingCategoryDishes.value = true;
      final response = await categoryRepositories.getDishesByCategory(
        categoryId: categoryId.toString(),
      );

      if (response.data?.isNotEmpty == true) {
        categoryDishes.addAll(response.data!);
        categoryCurrentPage.value++;
        hasMoreCategoryDishes.value = response.data!.length >= 10;
      } else {
        hasMoreCategoryDishes.value = false;
      }
    } catch (e) {
      print('Error fetching category dishes: $e');
    } finally {
      isLoadingCategoryDishes.value = false;
    }
  }

  // Phương thức lấy tất cả món ăn (cho phần "Thực đơn trưa/tối")
  Future<void> getMenuDishes({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      menuCurrentPage.value = 1;
      menuDishes.clear();
    }

    if (!hasMoreMenuDishes.value && isLoadMore) return;

    try {
      isLoadingMenuDishes.value = true;
      final response = await productRepositories.getListDishes(
        page: menuCurrentPage.value.toString(),
      );

      if (response.data?.isNotEmpty == true) {
        menuDishes.addAll(response.data!);
        menuCurrentPage.value++;
        hasMoreMenuDishes.value = response.data!.length >= 10;
      } else {
        hasMoreMenuDishes.value = false;
      }
    } catch (e) {
      print('Error fetching menu dishes: $e');
    } finally {
      isLoadingMenuDishes.value = false;
    }
  }

  Future<void> loadProfile() async {
    try {
      final response = await authRepositories.getProfile();
      profile.value = response;
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  void updateGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 10) {
      greeting.value = 'Chào buổi sáng';
      subGreeting.value = 'Bắt đầu ngày mới với bữa sáng';
    } else if (hour >= 10 && hour < 13) {
      greeting.value = 'Chào buổi trưa';
      subGreeting.value = 'Đã đến giờ ăn trưa rồi';
    } else if (hour >= 13 && hour < 17) {
      greeting.value = 'Chào buổi chiều';
      subGreeting.value = 'Thời điểm tuyệt vời cho bữa nhẹ';
    } else {
      greeting.value = 'Chào buổi tối';
      subGreeting.value = 'Thưởng thức bữa tối ngon miệng';
    }
  }

  void updateMenuTime() {
    final hour = DateTime.now().hour;

    if (hour >= 1 && hour < 13) {
      menuTime.value = 'trưa';
    } else if (hour >= 13 && hour < 24) {
      menuTime.value = 'tối';
    }
  }

  void setSelectedCategory(int index) {
    selectedCategory.value = index;
    if (apiCategories.isNotEmpty && index < apiCategories.length) {
      int categoryId = apiCategories[index].id ?? 1;
      if (categoryId > 0) {
        print('Calling getListDishesByCategory with categoryId: $categoryId');
        getListDishesByCategory(categoryId: categoryId);
      }
    }
  }

  void setBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  // New method to navigate to cart screen
  void goToCart() {
    Get.toNamed('/cart');
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}