
import 'package:flutter/material.dart';
import 'package:food_delivery_app/x_utils/widgets/primary_app_bar.dart';


import '../../base/base_controller.dart';

class BodyWidget extends StatelessWidget {
  final Widget child;
  final bool appBar;
  final Widget? leadingAppbar;
  final Widget? centerAppbar;
  final List<Widget>? listActionAppbar;
  final VoidCallback? onTapBack;
  final Color appBarColor;
  final Color bgColor;
  final Widget? bottomNavigationBar;
  final double elevationAppBar;
  final EdgeInsets? padding;
  final VoidCallback? onRefresh;
  final TabBar? tabBar;
  final PreferredSizeWidget? appBarWidget;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final double? heightAppbar;
  final bool transparentBg;
  final bool extendBodyBehindAppBar;
  final Widget? iconBack;

  const BodyWidget({
    Key? key,
    required this.child,
    this.appBar = false,
    this.leadingAppbar,
    this.listActionAppbar,
    this.centerAppbar,
    this.onTapBack,
    this.appBarColor = Colors.white,
    this.bgColor = Colors.white,
    this.bottomNavigationBar,
    this.elevationAppBar = 0,
    this.padding,
    this.onRefresh,
    this.tabBar,
    this.appBarWidget,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.heightAppbar,
    this.transparentBg = true,
    this.extendBodyBehindAppBar = false,
    this.iconBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar
          ? (appBarWidget ??
              PrimaryAppBar(
                leadingAppbar: leadingAppbar,
                listActionAppbar: listActionAppbar,
                centerAppbar: centerAppbar,
                appBarColor: appBarColor,
                bgColor: bgColor,
                bottomNavigationBar: bottomNavigationBar,
                elevationAppBar: elevationAppBar,
                tabBar: tabBar,
                onTapBack: onTapBack,
                height: heightAppbar,
                transparentBg: transparentBg,
                iconBack: iconBack,
              ))
          : null,
      floatingActionButton: floatingActionButton,
      backgroundColor: bgColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          if (onRefresh != null) onRefresh!;
        },
        child: GestureDetector(
          onTap: () {
            Get.focusScope?.unfocus();
          },
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
