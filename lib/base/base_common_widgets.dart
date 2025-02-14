import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:oktoast/oktoast.dart';

import '../x_utils/api_error_util.dart';
import '../x_utils/loading_dialog.dart';
import 'base_controller.dart';

///
/// --------------------------------------------
/// There are many amazing [Function]s in this class.
/// Especialy in user interactions.
/// You can find and use on your Controller wich is the Controller extends [BaseController].
mixin class BaseCommonWidgets implements _CommonWidgetsInterface {
  Debouncer showDialog = Debouncer(delay: Duration(seconds: 2));

  @override
  void showSnackBar({String title = "", String message = ""}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black45,
      barBlur: 8.0,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      duration: Duration(seconds: 2),
    );
  }

  @override
  void showErrorSnackBar({String title = "", String message = ""}) {
    Get.snackbar(title, message,
        backgroundColor: Color(0x8AD32F2F),
        barBlur: 10.0,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        duration: Duration(seconds: 2),
        icon: Icon(Icons.error, color: Colors.white));
  }

  @override
  void showSuccessSnackBar({String title = "", String message = ""}) {
    Get.snackbar(title, message,
        backgroundColor: Color(0x8A2E7D32),
        barBlur: 10.0,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        duration: Duration(seconds: 2),
        icon: Icon(Icons.check_circle, color: Colors.white));
  }

  @override
  void showSimpleSnackBar({String message = ""}) {
    Get.showSnackbar(GetBar(
      messageText: Text(message, style: TextStyle(color: Colors.white)),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  void showSimpleErrorSnackBar({String message = ""}) {
    Get.showSnackbar(GetBar(
      backgroundColor: Colors.red,
      icon: Icon(Icons.error, color: Colors.white),
      messageText: Text(message, style: TextStyle(color: Colors.white)),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  void showSimpleSuccessSnackBar({String message = ""}) {
    Get.showSnackbar(GetBar(
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle, color: Colors.white),
      messageText: Text(message, style: TextStyle(color: Colors.white)),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  void hideDialog() {
    if (Get.isDialogOpen != null && Get.isDialogOpen == true) Get.back();
  }

  @override
  void showLoadingDialog() {
    Get.dialog(LoadingDialog(),
        barrierDismissible: false, name: "Loading Dialog");
  }

  @override
  void showAlert(
      {String title = "Alert",
      TextStyle? titleStyle,
      Widget? content,
      VoidCallback? onConfirm,
      VoidCallback? onCancel,
      VoidCallback? onCustom,
      Color? cancelTextColor,
      Color? confirmTextColor,
      String? textConfirm,
      String? textCancel,
      String? textCustom,
      Widget? confirm,
      Widget? cancel,
      Widget? custom,
      Color? backgroundColor,
      bool barrierDismissible = true,
      Color? buttonColor,
      String middleText = "Dialog made in 3 lines of code",
      TextStyle? middleTextStyle,
      double radius = 20.0,
      List<Widget>? actions,
      WillPopCallback? onWillPop}) {
    Get.defaultDialog(
        title: title,
        titleStyle: titleStyle,
        content: content,
        onConfirm: onConfirm,
        onCancel: onCancel,
        onCustom: onCustom,
        cancelTextColor: cancelTextColor,
        confirmTextColor: confirmTextColor,
        textConfirm: textConfirm,
        textCancel: textCancel,
        textCustom: textCustom,
        confirm: confirm,
        cancel: cancel,
        custom: custom,
        backgroundColor: backgroundColor,
        barrierDismissible: barrierDismissible,
        buttonColor: buttonColor,
        middleText: middleText,
        middleTextStyle: middleTextStyle,
        radius: radius,
        actions: actions,
        onWillPop: onWillPop);
  }

  @override
  void handleErrorShowToast({required Object error}) {
    if (error is DioError) {
      showToastWidget(
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xE0D32F2F),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text(
                error.response?.data?['message'] ?? error.message ?? '',
                style:
                    TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
              )),
          position: ToastPosition.bottom);
    }
  }

  @override
  void handleErrorStringShowToast({required String error}) {
    showToastWidget(
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xE0D32F2F),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Text(
              error,
              style:
                  TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
            )),
        position: ToastPosition.bottom);
  }

  @override
  void handleSuccessStringShowToast({required String message}) {
    showToastWidget(
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xE04BD041),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Text(
              message,
              style:
                  const TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
            )),
        position: ToastPosition.bottom);
  }

  @override
  void handleErr(Object e) {
    String errMess = HttpErrorUtil.handleError(e);
    handleErrorStringShowToast(error: errMess);
  }
}

abstract class _CommonWidgetsInterface {
  void showSnackBar({String title = "", String message = ""});

  void showErrorSnackBar({String title = "", String message = ""});

  void showSuccessSnackBar({String title = "", String message = ""});

  void handleErrorShowToast({required Object error});

  void handleErrorStringShowToast({required String error});

  void handleSuccessStringShowToast({required String message});

  void showSimpleSnackBar({String message = ""});

  void showSimpleErrorSnackBar({String message = ""});

  void showSimpleSuccessSnackBar({String message = ""});

  void showLoadingDialog();

  void handleErr(Object e);

  void showAlert(
      {String title = "Alert",
      TextStyle titleStyle,
      Widget content,
      VoidCallback onConfirm,
      VoidCallback onCancel,
      VoidCallback onCustom,
      Color cancelTextColor,
      Color confirmTextColor,
      String textConfirm,
      String textCancel,
      String textCustom,
      Widget confirm,
      Widget cancel,
      Widget custom,
      Color backgroundColor,
      bool barrierDismissible = true,
      Color buttonColor,
      String middleText = "Dialog made in 3 lines of code",
      TextStyle middleTextStyle,
      double radius = 20.0,
      //   ThemeData themeData,
      List<Widget> actions,

      // onWillPop Scope
      WillPopCallback onWillPop});

  void hideDialog();
}
