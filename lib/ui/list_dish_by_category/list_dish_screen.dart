// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
//
// class ListDishByCategory extends GetView<ListDishByCategory> {
//   const ListDishByCategory({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Danh sách món ăn'),
//       ),
//       body: Obx(() => controller.isLoading.value
//           ? const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFFFF7043),
//               ),
//             )
//           : ListView.builder(
//               itemCount: controller.dishes.length,
//               itemBuilder: (context, index) {
//                 final dish = controller.dishes[index];
//                 return RecommendedCard(
//                   dish: dish,
//                   onTap: () {
//                     print('Tapped on dish: ${dish.id} - ${dish.name}');
//                     Get.toNamed(RouterName.foodDetail, arguments: dish.id);
//                   },
//                 );
//               },
//             )),
//     );
//   }
// }