// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
//
// class PaymentMethodScreen extends GetView<PaymentMethodController> {
//   const PaymentMethodScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment Methods'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (controller.paymentMethods.isEmpty) {
//           return Center(child: Text('No payment methods available.'));
//         }
//         return ListView.builder(
//           itemCount: controller.paymentMethods.length,
//           itemBuilder: (context, index) {
//             final method = controller.paymentMethods[index];
//             return ListTile(
//               title: Text(method.name),
//               subtitle: Text(method.details),
//               onTap: () => controller.selectPaymentMethod(method),
//             );
//           },
//         );
//       }),
//     );
//   }
// }