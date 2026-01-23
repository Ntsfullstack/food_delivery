import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'booking_controller.dart';
import '../../routes/router_name.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../models/order/booking_table.dart';

class DepositStepScreen extends GetView<TableBookingController> {
  final int reservationId;
  const DepositStepScreen({super.key, required this.reservationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đặt cọc')),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final deposit = controller.getDepositAmount();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số tiền đặt cọc (10%): ${deposit} VND', style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 12.h),
                  Center(
                    child: QrImageView(
                      data: 'DEPOSIT|$reservationId|$deposit',
                      size: 200.r,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final booking = TableBooking(
                    reservationId: reservationId,
                    customerName: controller.nameController.text,
                    phoneNumber: controller.phoneController.text,
                    reservationTime: DateTime(
                      controller.selectedDate.value.year,
                      controller.selectedDate.value.month,
                      controller.selectedDate.value.day,
                      controller.selectedTime.value.hour,
                      controller.selectedTime.value.minute,
                    ),
                    partySize: controller.numberOfPeople.value,
                    status: 'confirmed',
                  );
                  Get.offAllNamed(RouterName.bookingStatus, arguments: booking);
                },
                child: const Text('Xác nhận'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
