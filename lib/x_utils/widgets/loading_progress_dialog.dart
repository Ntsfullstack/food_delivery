import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

class LoadingProgressDialog extends StatefulWidget {
  const LoadingProgressDialog({
    super.key,
  });

  @override
  State<LoadingProgressDialog> createState() => _LoadingProgressDialogState();
}

class _LoadingProgressDialogState extends State<LoadingProgressDialog> {
  late RiveAnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = SimpleAnimation(
      'loop',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      child: Center(
        child: Container(
          width: 100.w,
          height: 100.w,
          child: RiveAnimation.asset(
            "assets/gif/loading_screen_with_dots.riv",
            fit: BoxFit.contain,
            controllers: [controller],
          ),
        ),
      ),
    );
  }
}
