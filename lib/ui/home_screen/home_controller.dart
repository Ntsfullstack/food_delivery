import 'package:get/get.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/profile/profile.dart';
import 'package:food_delivery_app/models/food/dish_categories.dart';
import '../../models/food/dishes.dart';

class HomeController extends BaseController {
  final RxString searchText = ''.obs;
  final RxInt selectedCategory = 0.obs;
  final RxInt currentBannerIndex = 0.obs;
  final RxString greeting = ''.obs;
  final RxString subGreeting = ''.obs;
  final RxString menuTime = ''.obs;

  // Profile reference
  late Rx<Profile?> profile = Rx<Profile?>(null);

  // Biến để lưu trữ danh mục từ API
  final RxList<DishesCategory> apiCategories = RxList<DishesCategory>([]);
  // Biến để kiểm tra trạng thái tải danh mục
  final RxBool isLoadingCategories = false.obs;

  // Best selling items with network images
  final bestSellers = [
    {
      'name': 'Sushi Salmon',
      'price': 103.0,
      'image':
      'https://cdn.pixabay.com/photo/2021/01/05/23/17/sushi-5892926_1280.jpg'
    },
    {
      'name': 'Gà Nướng Sa Tế',
      'price': 50.0,
      'image':
      'https://cdn.pixabay.com/photo/2016/03/05/19/02/abstract-1238247_1280.jpg'
    },
    {
      'name': 'Lasagna Bò',
      'price': 12.99,
      'image':
      'https://cdn.pixabay.com/photo/2016/12/11/22/41/lasagna-1900529_1280.jpg'
    },
    {
      'name': 'Bánh Cupcake',
      'price': 8.20,
      'image':
      'https://cdn.pixabay.com/photo/2015/03/26/09/39/cupcakes-690040_1280.jpg'
    },
    {
      'name': 'Pizza Hải Sản',
      'price': 89.0,
      'image':
      'https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_1280.jpg'
    },
  ];
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

  final RxBool isLoadingDishes = false.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreDishes = true.obs;
  final RxList<Dishes> dishes = RxList<Dishes>([]);

  @override
  void onInit() {
    super.onInit();

    // Get the shared profile instance
    try {
      profile = Get.find<Rx<Profile?>>();
    } catch (e) {
      profile = Rx<Profile?>(null);
      print('Profile not found in GetX: $e');
    }

    // Update greeting based on time of day
    updateGreeting();
    updateMenuTime();

    // Fetch categories from API
    getCategories();

    // Fetch dishes
    getListDishes();

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
      } else {
        print('No categories found or empty response');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  // Method to fetch dishes with the selected category
  Future<void> getListDishes({bool isLoadMore = false, int? categoryId}) async {
    if (!isLoadMore) {
      currentPage.value = 1;
      dishes.clear();
    }

    if (!hasMoreDishes.value && isLoadMore) return;

    try {
      isLoadingDishes.value = true;

      Map<String, String> queryParams = {
        "page": currentPage.value.toString(),
        "limit": "10",
      };

      if (categoryId != null) {
        queryParams["categoryId"] = categoryId.toString();
      }

      final response = await productRepositories.getListDishes(
        page: currentPage.value.toString(),
        limit: "10",
      );

      if (response.data?.isNotEmpty == true) {
        dishes.addAll(response.data!);
        currentPage.value++;
        hasMoreDishes.value = response.data!.length >= 10;
      } else {
        hasMoreDishes.value = false;
      }
    } catch (e) {
      print('Error fetching dishes: $e');
    } finally {
      isLoadingDishes.value = false;
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

    // Khi chọn danh mục, tải lại món ăn theo danh mục đó
    if (index == 0) {
      // Nếu chọn "Tất cả", tải tất cả món ăn không lọc theo danh mục
      getListDishes();
    } else if (apiCategories.isNotEmpty && index - 1 < apiCategories.length) {
      // Trừ 1 vì index 0 là "Tất cả"
      int categoryId = apiCategories[index - 1].id ?? 0;
      if (categoryId > 0) {
        getListDishes(categoryId: categoryId);
      }
    }
  }

  void setBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

// Có thể thêm lại phương thức getFilteredItems nếu cần thiết
/*
  List<Map<String, dynamic>> getFilteredItems() {
    if (categories.isEmpty || selectedCategory.value >= categories.length) {
      return [];
    }

    final categoryName =
    categories[selectedCategory.value]['name'].toString().toLowerCase();

    // Combine bestSellers and recommended
    final allItems = [...bestSellers, ...recommended];

    // If "All" category is selected (usually first category)
    if (selectedCategory.value == 0) {
      return allItems;
    }

    // Filter based on category name
    return allItems.where((item) {
      final itemName = item['name'].toString().toLowerCase();

      if (categoryName.contains('bánh mì') ||
          categoryName.contains('banh mi')) {
        return itemName.contains('bánh mì') || itemName.contains('banh mi');
      } else if (categoryName.contains('phở') || categoryName.contains('pho')) {
        return itemName.contains('phở') || itemName.contains('pho');
      } else if (categoryName.contains('cơm') || categoryName.contains('com')) {
        return itemName.contains('cơm') || itemName.contains('com');
      } else if (categoryName.contains('bánh') ||
          categoryName.contains('banh')) {
        return itemName.contains('bánh') || itemName.contains('banh');
      } else if (categoryName.contains('nước') ||
          categoryName.contains('nuoc')) {
        return itemName.contains('nước') || itemName.contains('nuoc');
      } else {
        // Try to find any partial match
        return itemName.contains(categoryName) ||
            categoryName.contains(itemName);
      }
    }).toList();
  }
  */
}