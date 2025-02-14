import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';

class ActiveWidget extends StatelessWidget {
  const ActiveWidget({
    Key? key,
    required this.active,
    required this.subtitleLeft,
    this.pending = false,
  }) : super(key: key);

  final bool active;
  final String? subtitleLeft;
  final bool? pending;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12).r,
        decoration: BoxDecoration(
            color: pending ?? false
                ? MyColor.NAVY.withOpacity(0.1)
                : active
                    ? MyColor.COLOR_GREEN.withOpacity(0.1)
                    : MyColor.ERROR.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20).w),
        alignment: Alignment.centerRight,
        child: Text(
          subtitleLeft ?? '',
          style: pending ?? false
              ? AppTextStyle.greenS13W500.copyWith(color: MyColor.NAVY)
              : active
                  ? AppTextStyle.greenS13W500
                  : AppTextStyle.errorS13W500,
        ));
  }
}
