import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FirebaseRemoteConfigClass {
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<String> getVersion() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 1),
        minimumFetchInterval: Duration(seconds: 1)));
    await remoteConfig.fetchAndActivate();
    var version = remoteConfig.getString("version_app");
    return version;
  }

  Future<String> getPatchVersion() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 1),
        minimumFetchInterval: Duration(seconds: 1)));
    await remoteConfig.fetchAndActivate();
    var version = remoteConfig.getString("patch_app");
    return version;
  }
  Future<bool> getForceUpdate() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 1),
        minimumFetchInterval: Duration(seconds: 1)));
    await remoteConfig.fetchAndActivate();
    var forceUpdate = remoteConfig.getBool("force_update");
    return forceUpdate;
  }

  Future<bool> getUpdateDialog() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 1),
        minimumFetchInterval: Duration(seconds: 1)));
    await remoteConfig.fetchAndActivate();
    var forceUpdate = remoteConfig.getBool("update_dialog");
    return forceUpdate;
  }

  Future listenConfig() async {
    remoteConfig.onConfigUpdated.listen((event)async {
      await remoteConfig.activate();
      var forceUpdate = remoteConfig.getString(event.updatedKeys.first);
      print(forceUpdate);
    });
  }

  void showUpdateDialog({
    required BuildContext context,
    required String versionStatus,
    String dialogTitle = 'Đã có bản cập nhật mới',
    String? dialogText,
    String updateButtonText = "Cập nhật",
    bool allowDismissal = true,
    String dismissButtonText = 'Cập nhật sau',
    VoidCallback? dismissAction,
  }) async {
    final dialogTitleWidget = Text(dialogTitle);
    final dialogTextWidget = Text(
      dialogText ??
          'You can now update this app from ${versionStatus} to ${versionStatus}',
    );

    final updateButtonTextWidget = Text(updateButtonText);
    final updateAction = () {
      Platform.isIOS
          ? launchAppStore('https://apps.apple.com/vn/app/senpos-gas/id6472602984')
          : launchAppStore(
              'https://play.google.com/store/apps/details?id=com.staron.senpos.gas&hl=vi_VN&pli=1');
      if (allowDismissal) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    };

    List<Widget> actions = [
      Platform.isAndroid
          ? TextButton(
              child: updateButtonTextWidget,
              onPressed: updateAction,
            )
          : CupertinoDialogAction(
              child: updateButtonTextWidget,
              onPressed: updateAction,
            ),
    ];

    if (allowDismissal) {
      final dismissButtonTextWidget = Text(dismissButtonText);
      dismissAction = dismissAction ??
          () => Navigator.of(context, rootNavigator: true).pop();
      actions.add(
        Platform.isAndroid
            ? TextButton(
                child: dismissButtonTextWidget,
                onPressed: dismissAction,
              )
            : CupertinoDialogAction(
                child: dismissButtonTextWidget,
                onPressed: dismissAction,
              ),
      );
    }

    await showDialog(
      context: context,
      barrierDismissible: allowDismissal,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Platform.isAndroid
                ? AlertDialog(
                    title: dialogTitleWidget,
                    content: dialogTextWidget,
                    actions: actions,
                  )
                : CupertinoAlertDialog(
                    title: dialogTitleWidget,
                    content: dialogTextWidget,
                    actions: actions,
                  ),
            onWillPop: () => Future.value(allowDismissal));
      },
    );
  }



  void showShorebirdDialog({
    required BuildContext context,
    String dialogTitle = 'Đã có bản cập nhật mới',
    String? dialogText,
    String updateButtonText = "Cập nhật",
    bool allowDismissal = true,
    String dismissButtonText = 'Cập nhật sau',
    VoidCallback? updateAction,
    VoidCallback? dismissAction,
  }) async {
    final dialogTitleWidget = Text(dialogTitle);
    final dialogTextWidget = Text(
      dialogText ??
          'You can now update this app from ',
    );

    final updateButtonTextWidget = Text(updateButtonText);


    List<Widget> actions = [
      Platform.isAndroid
          ? TextButton(
              child: updateButtonTextWidget,
              onPressed: updateAction,
            )
          : CupertinoDialogAction(
              child: updateButtonTextWidget,
              onPressed: updateAction,
            ),
    ];

    if (allowDismissal) {
      final dismissButtonTextWidget = Text(dismissButtonText);
      dismissAction = dismissAction ??
          () => Navigator.of(context, rootNavigator: true).pop();
      actions.add(
        Platform.isAndroid
            ? TextButton(
                child: dismissButtonTextWidget,
                onPressed: dismissAction,
              )
            : CupertinoDialogAction(
                child: dismissButtonTextWidget,
                onPressed: dismissAction,
              ),
      );
    }

    await showDialog(
      context: context,
      barrierDismissible: allowDismissal,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Platform.isAndroid
                ? AlertDialog(
                    title: dialogTitleWidget,
                    content: dialogTextWidget,
                    actions: actions,
                  )
                : CupertinoAlertDialog(
                    title: dialogTitleWidget,
                    content: dialogTextWidget,
                    actions: actions,
                  ),
            onWillPop: () => Future.value(allowDismissal));
      },
    );
  }

  /// Launches the Apple App Store or Google Play Store page for the app.
  Future<void> launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    if (await canLaunchUrl(Uri.parse( appStoreLink))) {
      await launchUrl(Uri.parse( appStoreLink));
    } else {
      throw 'Could not launch appStoreLink';
    }
  }
}


void showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Action'),
        content: Text('Are you sure you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text('Confirm'),
          ),
        ],
      );
    },
  );
  performAction();
}


performAction(){}