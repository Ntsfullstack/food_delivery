import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/food/dishes.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:food_delivery_app/ui/profile_screen/profile_controller.dart';
import 'deposit_step_screen.dart';

class TableBookingController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final RxList<Dishes> categoryDishes = <Dishes>[].obs;
  final RxList<int> selectedDishes = <int>[].obs;
  final RxMap<int, int> selectedQuantities = <int, int>{}.obs;

  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;
  final numberOfPeople = 2.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final specialRequestsController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _prefillCustomerInfo();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    specialRequestsController.dispose();
    super.onClose();
  }

  void _prefillCustomerInfo() {
    final profile = ProfileController.instance.profile.value;
    if (profile != null) {
      nameController.text = profile.fullName;
      phoneController.text = profile.phoneNumber;
      emailController.text = profile.email;
    }
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime.value,
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  Future<void> getListDishesByCategory({int? categoryId}) async {
    try {
      final response = await categoryRepositories.getDishesByCategory(
        categoryId: categoryId?.toString() ?? '3',
      );

      if (response.data?.isNotEmpty == true) {
        categoryDishes.value = response.data ?? [];
      } else {
        categoryDishes.clear();
      }
    } catch (e) {
      print('Error fetching category dishes: $e');
    }
  }

  void toggleDishSelection(int? dishId) {
    if (dishId == null) return;

    if (selectedDishes.contains(dishId)) {
      selectedDishes.remove(dishId);
      selectedQuantities.remove(dishId);
    } else {
      selectedDishes.add(dishId);
      selectedQuantities[dishId] = 1;
    }
  }

  void increaseDishQuantity(int? dishId) {
    if (dishId == null) return;
    if (!selectedDishes.contains(dishId)) {
      selectedDishes.add(dishId);
      selectedQuantities[dishId] = 1;
      return;
    }
    selectedQuantities[dishId] = (selectedQuantities[dishId] ?? 1) + 1;
  }

  void decreaseDishQuantity(int? dishId) {
    if (dishId == null) return;
    if (!selectedDishes.contains(dishId)) return;
    final current = selectedQuantities[dishId] ?? 1;
    if (current <= 1) {
      selectedDishes.remove(dishId);
      selectedQuantities.remove(dishId);
    } else {
      selectedQuantities[dishId] = current - 1;
    }
  }

  double getSelectedTotal() {
    double sum = 0;
    for (final d in categoryDishes) {
      final id = d.id;
      if (id != null && selectedDishes.contains(id)) {
        final qty = selectedQuantities[id] ?? 1;
        sum += ((d.price ?? 0).toDouble()) * qty;
      }
    }
    return sum;
  }

  int getDepositAmount() {
    final total = getSelectedTotal();
    return (total * 0.10).round();
  }

  Future<void> summitBooking() async {
    try {
      showLoading();
      // Build ordered items with quantities
      final orderedItems = selectedQuantities.entries
          .map((e) => {
                'dishId': e.key,
                'quantity': e.value,
              })
          .toList();

      final response = await bookingTableRepositories.tableBooking(
          customerName: nameController.text,
          phoneNumber: phoneController.text,
          reservationTime: DateTime(
            selectedDate.value.year,
            selectedDate.value.month,
            selectedDate.value.day,
            selectedTime.value.hour,
            selectedTime.value.minute,
          ),
          partySize: numberOfPeople.value,
          specialRequests: specialRequestsController.text,
          orderedItems: orderedItems);
      hideLoading();
      if (response.data != null) {
        final reservation = response.data!;
        final int? reservationId = reservation.reservationId;
        if (reservationId != null && reservationId > 0) {
          Get.to(() => DepositStepScreen(reservationId: reservationId));
        } else {
          Get.offAllNamed(RouterName.bookingStatus, arguments: response.data);
        }
      } else {
        Get.snackbar(
          'Thất bại',
          'Đặt bàn thất bại',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      hideLoading();
      print('Error booking table: $e');
      Get.snackbar(
        'Lỗi',
        'Đặt bàn thất bại',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
