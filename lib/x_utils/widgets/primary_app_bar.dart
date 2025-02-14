import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:senpos_ticket/base/base_controller.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingAppbar;
  final Widget? centerAppbar;
  final List<Widget>? listActionAppbar;
  final VoidCallback? onTapBack;
  final Color appBarColor;
  final Color bgColor;
  final Widget? bottomNavigationBar;
  final double elevationAppBar;
  final TabBar? tabBar;
  final double? height;
  final bool transparentBg;
  final Widget? iconBack;

  const PrimaryAppBar({
    Key? key,
    this.leadingAppbar,
    this.listActionAppbar,
    this.centerAppbar,
    this.onTapBack,
    this.appBarColor = Colors.transparent,
    this.bgColor = Colors.grey,
    this.bottomNavigationBar,
    this.elevationAppBar = 0,
    this.tabBar,
    this.height,
    this.transparentBg = true,
    this.iconBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      elevation: elevationAppBar,
      leading: leadingAppbar ??
          IconButton(
            splashRadius: 24.r,
            icon: iconBack ?? Icon(CupertinoIcons.back),
            onPressed: onTapBack ?? () => Get.back(),
            splashColor: Colors.white,
          ),
      actions: listActionAppbar ?? [],
      bottom: tabBar,
      centerTitle: true,
      title: centerAppbar,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
