import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class BottomNavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}