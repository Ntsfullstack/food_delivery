import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/food/dishes.dart';
import '../../models/food/dish_categories.dart';
import '../../repository/dishes_repository/categories_repository.dart';
import '../dish_management/dish_management_controller.dart';

class DishDetailController extends BaseController {
  // Form controllers
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final prepTimeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // State variables
  final Rxn<Dishes> dish = Rxn<Dishes>();
  final RxBool _isLoading = false.obs;
  final RxString imagePath = RxString('');
  final RxBool isEdit = false.obs;
  final RxInt? dishId = RxInt(0);
  
  // Category related variables
  final RxList<DishesCategory> categories = <DishesCategory>[].obs;
  final Rxn<DishesCategory> selectedCategory = Rxn<DishesCategory>();
  late CategoryRepositories categoryRepositories;

  @override
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    
    // Get arguments if editing
    final args = Get.arguments;
    if (args != null && args is Map) {
      isEdit.value = args['isEdit'] ?? false;
      if (args['dishId'] != null) {
        dishId?.value = args['dishId'];
        loadDish(args['dishId']);
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    prepTimeController.dispose();
    super.onClose();
  }

  Future<void> loadDish(int id) async {
    _isLoading.value = true;
    try {
      final result = await productRepositories.getDetailDishes(
        dishId: id.toString(),
      );
      if (result.data != null) {
        dish.value = result.data;
        // Update form controllers
        nameController.text = result.data?.name ?? '';
        descController.text = result.data?.description ?? '';
        priceController.text = result.data?.price?.toString() ?? '';
        prepTimeController.text = result.data?.preparationTime?.toString() ?? '';
        imagePath.value = result.data?.image ?? '';
        
        // Set selected category
        if (result.data?.categoryId != null) {
          final category = getCategoryById(result.data!.categoryId);
          selectedCategory.value = category;
        }
      } else {
        showError(message: 'Không thể tải món ăn');
      }
    } catch (e) {
      showError(message: 'Không thể tải món ăn: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadCategories() async {
    try {
      final result = await categoryRepositories.getListCategories();
      if (result.data != null) {
        categories.value = result.data!;
      }
    } catch (e) {
      showError(message: 'Không thể tải danh sách danh mục: $e');
    }
  }

  void onCategoryChanged(DishesCategory? category) {
    selectedCategory.value = category;
  }

  DishesCategory? getCategoryById(int? id) {
    if (id == null) return null;
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        imagePath.value = picked.path;
      }
    } catch (e) {
      showError(message: 'Không thể chọn ảnh: $e');
    }
  }

  Future<void> saveDish() async {
    if (!formKey.currentState!.validate()) return;

    _isLoading.value = true;
    try {
      // Convert price string to double safely
      double? price;
      try {
        if (priceController.text.isNotEmpty) {
          price = double.parse(priceController.text.replaceAll(',', ''));
        }
      } catch (e) {
        showError(message: 'Giá không hợp lệ');
        return;
      }

      final dishData = Dishes(
        id: isEdit.value ? dishId?.value : null,
        name: nameController.text,
        description: descController.text,
        price: price,
        preparationTime: int.tryParse(prepTimeController.text),
        categoryId: selectedCategory.value?.id,
        image: imagePath.value,
      );

      if (isEdit.value) {
        await productRepositories.updateDish(dish: dishData, imagePath: imagePath.value);
        Get.snackbar(


          'Thành công',
          'Cập nhật món ăn thành công',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      } else {
        await productRepositories.createDish(dish: dishData);
        Get.snackbar(
          'Thành công',
          'Thêm món ăn thành công',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
      
      // Refresh danh sách món ăn ở màn hình trước
      final previousController = Get.find<DishManagementController>();
      await previousController.refreshDishes();
      
      Get.back();
    } catch (e) {
      showError(message: 'Không thể lưu món ăn: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> deleteDish() async {
    if (dishId?.value == null) return;

    _isLoading.value = true;
    try {
      // Implement delete dish API call here
      // await productRepositories.deleteDish(dishId!.value);
      Get.snackbar(
        'Thành công',
        'Xóa món ăn thành công',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.back(result: true);
    } catch (e) {
      showError(message: 'Không thể xóa món ăn: $e');
    } finally {
      _isLoading.value = false;
    }
  }
}
