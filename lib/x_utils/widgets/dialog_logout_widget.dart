import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';
import '../../x_res/x_r.dart';

class DialogConfirm extends StatelessWidget {
  final String? title;
  final String? content;
  final String? confirmText;
  final VoidCallback? onPressConfirmText;

  const DialogConfirm(
      {super.key,
      this.title,
      this.content,
      this.confirmText,
      this.onPressConfirmText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16).r,
        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Transform.translate(
            //   offset: Offset(0, -27),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: MyColor.ERROR,
            //       borderRadius: BorderRadius.circular(50).w,
            //     ),
            //     width: 56.w,
            //     height: 56.h,
            //     padding: EdgeInsets.all(12).w,
            //     child: SvgPicture.asset(
            //       XR().svgImage.ic_logout,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 32),
            Text(title ?? XR().string.logout, style: AppTextStyle.blackS16W500),
            const SizedBox(height: 8),
            Text(content ?? XR().string.logout_confirm,
                style: AppTextStyle.blackS14W300, textAlign: TextAlign.center,),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16).w,
                      decoration: BoxDecoration(
                          color: MyColor.BG_COLOR,
                          borderRadius: BorderRadius.circular(16)),
                      child: Text("Huỷ", style: AppTextStyle.blackS16W500),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onPressConfirmText?.call();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16).w,
                      decoration: BoxDecoration(
                          color: MyColor.ERROR,
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(confirmText??"Xoá", style: AppTextStyle.whiteS16W500),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
