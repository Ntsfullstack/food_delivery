import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../x_res/x_r.dart';

class BackgroundProfileWidget extends StatelessWidget {
  const BackgroundProfileWidget({
    Key? key,
    this.height,
    this.isShowBg = true,
  }) : super(key: key);
  final double? height;
  final bool isShowBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: height ?? Get.width * 0.6,
      padding: EdgeInsets.only(bottom: 16, right: 16).r,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF3480AF), Color(0xFF76BBCD)]),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20).w)),
      child: isShowBg
          ? Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(XR().svgImage.img_bg_profile,
                  width: Get.width * 0.4))
          : null,
    );
  }
}
