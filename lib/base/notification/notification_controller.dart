import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../x_utils/api_error_util.dart';
import '../../x_utils/snackbar_util.dart';
// import '../base/base_controller.dart';
import '../base_controller.dart';
// import '../x_utils/api_error_util.dart';
// import '../x_utils/snackbar_util.dart';
import 'firebase_remote_config.dart';

class AppController extends BaseController {
  ScrollController scrollController = ScrollController();
  String tokenFCM = '';
  RxBool rxIsOffline = RxBool(false);
  final FirebaseRemoteConfigClass remoteConfig = FirebaseRemoteConfigClass();

  @override
  void onInit() {
    super.onInit();
    remoteConfig.listenConfig();
  }

  Future<bool> updateFCMToken() async {
    try {
      // var res = await notificationRepositories.updateFCM(
      //     deviceToken: tokenFCM,
      //     userRole: Platform.isIOS ? 'ios' : 'android',
      //     msisdn: '',
      //     deviceId: '');
      // debugPrint('UPDATE FCM: success $res');
      return true;
    } catch (e) {
      _handleException(e);
      return false;
    }
  }

  /// Handle logic when calling API failure
  _handleError(String errMsg) {
    SnackbarUtil.showErrSnackbar(errMsg);
  }

  /// Handle logic when an exception occurred
  _handleException(dynamic e) {
    print(e.toString());
    SnackbarUtil.showErrSnackbar(HttpErrorUtil.handleError(e));
  }

}
