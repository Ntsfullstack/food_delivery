import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/food/dishes.dart';
import '../dish_management/dish_management_controller.dart';

class DishDetailController extends BaseController {
  // Form controllers
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final prepTimeController = TextEditingController();
  final categoryIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // State variables
  final Rxn<Dishes> dish = Rxn<Dishes>();
  final RxBool _isLoading = false.obs;
  final RxString imagePath = RxString('');
  final RxBool isEdit = false.obs;
  final RxInt? dishId = RxInt(0);

  @override
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
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
    categoryIdController.dispose();
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
        categoryIdController.text = result.data?.categoryId?.toString() ?? '';
        imagePath.value = result.data?.image ?? '';
      } else {
        showError(message: 'Không thể tải món ăn');
      }
    } catch (e) {
      showError(message: 'Không thể tải món ăn: $e');
    } finally {
      _isLoading.value = false;
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
        categoryId: int.tryParse(categoryIdController.text),
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
