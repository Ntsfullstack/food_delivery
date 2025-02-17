// table_booking_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableBookingController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;
  final numberOfPeople = 2.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final specialRequestsController = TextEditingController();

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

  void submitBooking() {
    if (formKey.currentState!.validate()) {
      final booking = TableBooking(
        date: selectedDate.value,
        time: selectedTime.value,
        numberOfPeople: numberOfPeople.value,
        customerName: nameController.text,
        customerPhone: phoneController.text,
        customerEmail: emailController.text,
        specialRequests: specialRequestsController.text,
      );

      // TODO: Submit booking to backend

      Get.snackbar(
        'Thành công',
        'Đặt bàn thành công',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate back or to confirmation screen
      Get.back();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    specialRequestsController.dispose();
    super.onClose();
  }
}

// models
class TableBooking {
  final DateTime date;
  final TimeOfDay time;
  final int numberOfPeople;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String specialRequests;

  TableBooking({
    required this.date,
    required this.time,
    required this.numberOfPeople,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.specialRequests,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'time': '${time.hour}:${time.minute}',
    'numberOfPeople': numberOfPeople,
    'customerName': customerName,
    'customerPhone': customerPhone,
    'customerEmail': customerEmail,
    'specialRequests': specialRequests,
  };
}