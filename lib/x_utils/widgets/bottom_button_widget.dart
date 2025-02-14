import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    this.padding,
    this.rightText,
    this.onPressLeft,
    this.onPressRight,
    this.active = true,
  }) : super(key: key);
  final EdgeInsets? padding;
  final String? rightText;
  final VoidCallback? onPressRight;
  final VoidCallback? onPressLeft;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0).w,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                onPressLeft?.call();
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16).w,
                decoration: BoxDecoration(
                    color: MyColor.BG_COLOR,
                    borderRadius: BorderRadius.circular(16).w),
                child: Text('Bỏ lọc', style: AppTextStyle.blackS16W500),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: InkWell(
              onTap: active ? onPressRight ?? () {} : null,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16).w,
                decoration: BoxDecoration(
                    color: active ? MyColor.MAIN_SOLID : MyColor.FOUNDATION,
                    borderRadius: BorderRadius.circular(16).w),
                child:
                    Text(rightText ?? '', style: AppTextStyle.whiteS16W500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
