import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/widget_state.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../repository/repositories.dart';
import '../x_utils/utilities.dart';
import 'base_common_widgets.dart';
import 'networking/api.dart';
import 'widget_state.dart' as widget_state;

export 'package:get/get.dart';

export '../x_res/my_res.dart';

///
/// --------------------------------------------
/// [Example]
///
/// class HomeController extends BaseController {
///
///   var count = 0.obs;
///
///   @override
///   void onInit() {
///     super.onInit();
///   }
///
///   void increment() => count ++;
///
/// }
///
/// RECOMENDED FOR your [Controller].
/// Please extends to your [Controller].
/// read the [Example] above.
class BaseController extends GetxController
    with
        BaseCommonWidgets,
        Utilities,
        Repositories,
        widget_state.WidgetState,
        ScreenState {
  final box = GetStorage();
  bool isLoadMore = false;
  bool withScrollController = false;
  late ScrollController scrollController;
  final ApiService _service = ApiService();

  set setEnableScrollController(bool value) => withScrollController = value;

  @override
  void onInit() {
    super.onInit();
    if (withScrollController) {
      logWhenDebug("SCROLL CONTROLLER ENABLE on ${Get.currentRoute}",
          withScrollController.toString());
      scrollController = ScrollController();
      scrollController.addListener(_scrollListener);
    }
    initBaseRepositories(apiService: _service);
  }

  void onRefresh() {}

  void onLoadMore() {}

  void onScrollPosition(double position) {}

  void _scrollListener() {
    onScrollPosition(scrollController.position.pixels);
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isLoadMore) {
        isLoadMore = true;
        update();
        onLoadMore();
      }
    }
    _innerBoxScrolled();
  }

  void _innerBoxScrolled() {
    if (scrollController.offset <= 60 && scrollController.offset > 40) {
      // if(!innerBoxIsScrolled) {
      //   innerBoxIsScrolled = true;
      //   update();
      // }
    }
    if (scrollController.offset >= 0 && scrollController.offset <= 40) {
      // if(innerBoxIsScrolled) {
      //   innerBoxIsScrolled = false;
      //   update();
      // }
    }
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Show loading dialog with message
  void showLoading({String message = 'Đang xử lý...'}) {
    if (_isLoading.value) return;
    _isLoading.value = true;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF7043)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Hide loading dialog
  void hideLoading() {
    if (_isLoading.value) {
      _isLoading.value = false;
      Get.back();
    }
  }

  // Show error message
  void showError({required String message}) {
    Get.snackbar(
      'Lỗi',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[800],
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.error_outline_rounded,
        color: Colors.red,
        size: 28,
      ),
      shouldIconPulse: true,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  // Show success message
  void showSuccess({required String message}) {
    Get.snackbar(
      'Thành công',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[100],
      colorText: Colors.green[800],
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.check_circle_outline_rounded,
        color: Colors.green,
        size: 28,
      ),
      shouldIconPulse: true,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  // Show information message
  void showInfo({required String message}) {
    Get.snackbar(
      'Thông tin',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue[100],
      colorText: Colors.blue[800],
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.info_outline_rounded,
        color: Colors.blue,
        size: 28,
      ),
      shouldIconPulse: true,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
