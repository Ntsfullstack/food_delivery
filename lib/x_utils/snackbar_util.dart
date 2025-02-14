import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static double _marginVertical = Get.height * 0.13;
  static double _radiusBorder = 14;
  static double _marginHorizontal = 14;
  static Duration _durationDisplaying = Duration(seconds: 3);

  static _buildMessageWidget(String message) {
    return Container(
      child: Text(
        message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  static _buildIcon(Widget icon) {
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      width: 20,
      height: 20,
      child: icon,
    );
  }

  static showErrSnackbar(message) {
    Get.showSnackbar(GetSnackBar(
      duration: _durationDisplaying,
      borderRadius: _radiusBorder,
      backgroundColor: Colors.grey,
      margin: EdgeInsets.symmetric(
          horizontal: _marginHorizontal, vertical: _marginVertical),
      padding: EdgeInsets.all(_marginHorizontal),
      messageText: _buildMessageWidget(message),
      icon: _buildIcon(Icon(Icons.error, color: Colors.white)),
    ));
  }

  static showSuccessSnackbar(String message) {
    Get.showSnackbar(GetSnackBar(
      duration: _durationDisplaying,
      borderRadius: _radiusBorder,
      backgroundColor: Colors.grey,
      margin: EdgeInsets.symmetric(
          horizontal: _marginHorizontal, vertical: _marginVertical),
      padding: EdgeInsets.all(_marginHorizontal),
      messageText: _buildMessageWidget(message),
      icon: _buildIcon(Icon(Icons.check_circle, color: Colors.white)),
    ));
  }

  static showSnackbar({required String message, required Widget icon}) {
    Get.showSnackbar(GetSnackBar(
      duration: _durationDisplaying,
      borderRadius: _radiusBorder,
      backgroundColor: Colors.grey,
      margin: EdgeInsets.symmetric(
          horizontal: _marginHorizontal, vertical: _marginVertical),
      padding: EdgeInsets.all(_marginHorizontal),
      messageText: _buildMessageWidget(message),
      icon: _buildIcon(icon),
    ));
  }

  static showSnackbarWithTail(
      {required String message,
      required Widget icon,
      required Widget mainButton}) {
    Get.showSnackbar(GetSnackBar(
      duration: _durationDisplaying,
      borderRadius: _radiusBorder,
      backgroundColor: Colors.grey,
      margin: EdgeInsets.symmetric(
          horizontal: _marginHorizontal, vertical: _marginVertical),
      padding: EdgeInsets.all(_marginHorizontal),
      messageText: _buildMessageWidget(message),
      mainButton: mainButton,
      icon: _buildIcon(icon),
    ));
  }

  static snackBarWithCancel(
      {String? message, VoidCallback? onPress}) {
    Get.showSnackbar(GetSnackBar(
      duration: Duration(seconds: 3),
      borderRadius: _radiusBorder,
      backgroundColor: Colors.grey,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: _marginVertical),
      message: message ?? 'added.to.favourite.folder'.tr,
      mainButton: TextButton(child: Text('cancel'.tr), onPressed: onPress),
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildIcon(Icon(Icons.check_circle, color: Colors.white)),
      ),
    ));
  }
}
