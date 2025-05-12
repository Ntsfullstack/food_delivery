import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/router_name.dart';
import '../home_screen/widget/recomment_card.dart';
import 'list_menu_controller.dart';

class ListMenu extends GetView<ListMenuController> {
  const ListMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thực đơn hôm nay'),
      ),
      body: Obx(() =>
      controller.isLoadingMenuDishes.value
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFF7043),
        ),
      )
          : ListView.builder(
        itemCount: controller.menuDishes.length,
        itemBuilder: (context, index) {
          final dish = controller.menuDishes[index];
          return RecommendedCard(
            dish: dish,
            onTap: () {
              print('Tapped on dish: ${dish.id} - ${dish.name}');
              Get.toNamed(RouterName.foodDetail, arguments: dish.id);
            },
          );
        },
      )
      ),
    );
  }
}