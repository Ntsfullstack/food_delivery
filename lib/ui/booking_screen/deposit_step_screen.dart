import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'booking_controller.dart';
import '../../routes/router_name.dart';

class DepositStepScreen extends GetView<TableBookingController> {
  final int reservationId;
  const DepositStepScreen({super.key, required this.reservationId});

  @override
  Widget build(BuildContext context) {
    final amountCtrl = TextEditingController(text: '50000');
    return Scaffold(
      appBar: AppBar(title: const Text('Đặt cọc')),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nhập số tiền đặt cọc', style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'VND'),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final amount = int.tryParse(amountCtrl.text.trim()) ?? 0;
                  if (amount <= 0) {
                    controller.showError(message: 'Số tiền không hợp lệ');
                    return;
                  }
                  try {
                    controller.showLoading(message: 'Tạo thanh toán đặt cọc...');
                    final res = await controller.paymentsRepositories.createDepositPayment(
                      reservationId: reservationId,
                      amount: amount,
                      method: 'zalopay',
                      redirectUrl: 'app://booking-status',
                    );
                    controller.hideLoading();
                    final data = res.data ?? {};
                    final url = data['order_url'] ?? data['payment_url'];
                    if (url is String && url.isNotEmpty) {
                      Get.toNamed(RouterName.paymentWeb, arguments: {'payment_url': url});
                    } else {
                      controller.showError(message: 'Không nhận được link thanh toán');
                    }
                  } catch (e) {
                    controller.hideLoading();
                    controller.showError(message: 'Lỗi tạo thanh toán: $e');
                  }
                },
                child: const Text('Thanh toán đặt cọc'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
