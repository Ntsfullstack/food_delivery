import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../x_res/my_config.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color? backgroundColor;
  final Color? textColor;
  final double? elevation;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? margin;
  final TextStyle? style;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.backgroundColor,
    this.textColor,
    this.elevation,
    this.suffixIcon,
    this.margin,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: Get.width,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: style ??
                  TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w500),
            ),
            if (suffixIcon != null)
              SizedBox(
                width: 4.w,
              ),
            if (suffixIcon != null) suffixIcon!
          ],
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: elevation ?? 0,
            backgroundColor: backgroundColor ?? MyColor.COLOR_BTN_LOGIN),
      ),
    );
  }
}
