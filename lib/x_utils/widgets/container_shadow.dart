import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerShadow extends StatelessWidget {
  const ContainerShadow({
    Key? key,
    required this.child,
    required this.bgColor,
    this.onPress,
    this.padding,
    this.borderRadius,
    this.border,
    this.colorShadow,
  }) : super(key: key);

  final EdgeInsets? padding;
  final Widget? child;
  final Color? bgColor;
  final VoidCallback? onPress;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? colorShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0).r,
      child: InkWell(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
              color: bgColor,
              border: border,
              borderRadius: borderRadius ?? BorderRadius.circular(8).w,
              boxShadow: [
                BoxShadow(color: colorShadow ?? Colors.black12, blurRadius: 20)
              ]),
          child: ClipRRect(
              borderRadius: borderRadius ?? BorderRadius.circular(8).w,
              child: child),
        ),
      ),
    );
  }
}
