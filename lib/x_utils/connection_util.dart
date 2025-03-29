import 'dart:io';

import 'package:get/get.dart';
// import 'package:senpos_ticket/notification/notification_controller.dart';

import '../base/notification/notification_controller.dart';
import '../x_res/my_config.dart';
import 'get_storage_util.dart';

class ConnectionUtil {
  //The test to actually see if there is a connection
  static Future<bool> checkConnection() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }

    if (Get.isRegistered<AppController>()) {
      AppController appController = Get.find();
      appController.rxIsOffline(!isConnected);
    }
    return isConnected;
  }

  static Map<String, String> getAuthorization() {
    final accessToken = ShareStorage.storage.read(MyConfig.ACCESS_TOKEN_KEY);
    var headers = {
      'Authorization': "Bearer $accessToken",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    };

    return headers;
  }
}
