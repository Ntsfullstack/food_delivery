import 'package:get/get.dart';

class HomeController extends GetxController {
  var searchText = ''.obs;
  var selectedCategory = 0.obs;
  var currentBannerIndex = 0.obs;
  var greeting = ''.obs;
  var subGreeting = ''.obs;
  var menuTime = ''.obs;

  // Categories with network images
  final categories = [
    {
      'icon':
          'https://cdn.pixabay.com/photo/2019/03/25/15/08/bánh-mì-4080536_1280.jpg',
      'name': 'Bánh mì'
    },
    {
      'icon':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Baozi_%288308896744%29.jpg/640px-Baozi_%288308896744%29.jpg',
      'name': 'Bánh bao'
    },
    {
      'icon':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Xoi_Gac.jpg/640px-Xoi_Gac.jpg',
      'name': 'Xôi'
    },
    {
      'icon':
          'https://cdn.pixabay.com/photo/2014/09/26/19/51/water-462296_1280.jpg',
      'name': 'Nước'
    },
    {
      'icon':
          'https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_1280.jpg',
      'name': 'Món khai vị'
    },
  ];

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

  // Recommended items with network images
  final recommended = [
    {
      'name': 'Burger Thịt Bò',
      'price': 10.0,
      'rating': 4.8,
      'image':
          'https://cdn.pixabay.com/photo/2019/01/29/18/05/burger-3962996_1280.jpg'
    },
    {
      'name': 'Chả Giò Việt Nam',
      'price': 25.0,
      'rating': 4.7,
      'image':
          'https://img.freepik.com/free-photo/vietnamese-spring-rolls-with-vegetables-sauce_2829-10996.jpg'
    },
    {
      'name': 'Phở Bò',
      'price': 35.0,
      'rating': 4.9,
      'image':
          'https://img.freepik.com/free-photo/pho-bo-vietnamese-soup-with-beef-rice-noodles_2829-11094.jpg'
    },
    {
      'name': 'Cơm Chiên Hải Sản',
      'price': 42.0,
      'rating': 4.5,
      'image':
          'https://img.freepik.com/free-photo/seafood-fried-rice_1339-2157.jpg'
    },
    {
      'name': 'Bánh Xèo',
      'price': 28.0,
      'rating': 4.6,
      'image':
          'https://img.freepik.com/free-photo/vietnamese-pancake-banh-xeo_1339-2079.jpg'
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

  @override
  void onInit() {
    super.onInit();
    updateGreeting();
    updateMenuTime();
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
  }

  void setBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  // Method to get filtered food items based on category
  List<Map<String, dynamic>> getFilteredItems() {
    switch (selectedCategory.value) {
      case 0: // Bánh mì
        return bestSellers
            .where((item) =>
                item['name'].toString().toLowerCase().contains('bánh') ||
                item['name'].toString().toLowerCase().contains('banh'))
            .toList();
      case 1: // Bánh bao
        return bestSellers
            .where(
                (item) => item['name'].toString().toLowerCase().contains('bao'))
            .toList();
      case 2: // Xôi
        return bestSellers
            .where((item) =>
                item['name'].toString().toLowerCase().contains('xôi') ||
                item['name'].toString().toLowerCase().contains('xoi'))
            .toList();
      case 3: // Nước
        return bestSellers
            .where((item) =>
                item['name'].toString().toLowerCase().contains('nước') ||
                item['name'].toString().toLowerCase().contains('nuoc'))
            .toList();
      case 4: // Món khai vị
        return bestSellers;
      default:
        return bestSellers;
    }
  }
}
