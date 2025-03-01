import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';
import 'container_shadow.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    Key? key,
    required this.name,
    required this.price,
    required this.number,
    this.urlAvt,
    this.isShowDropdown = true,
  }) : super(key: key);

  final String name;
  final String price;
  final String number;
  final String? urlAvt;
  final bool isShowDropdown;

  @override
  Widget build(BuildContext context) {
    return ContainerShadow(
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8).w,
            topRight: const Radius.circular(16).w,
            bottomLeft: const Radius.circular(8).w,
            bottomRight: const Radius.circular(16).w),
        bgColor: Colors.white,
        child: Container(
          child: Row(
            children: [
              Container(
                color: MyColor.COLOR_BTN_LOGIN,
                height: 100.h,
                width: 8.w,
              ),
              Container(
                margin: const EdgeInsets.all(16.0).w,
                width: 46.w,
                height: 46.h,
                decoration: const BoxDecoration(
                    color: MyColor.LIGHT_SOLID, shape: BoxShape.circle),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.blackS14W500,
                  ),
                  SizedBox(height: 4.h),
                  Text('$price MMK', style: AppTextStyle.mainSolidS16),
                  SizedBox(height: 4.h),
                  Text(
                    number,
                    style: AppTextStyle.blackS13W300,
                  ),
                ],
              ),
              const Spacer(),
              if (isShowDropdown)
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                ),
              SizedBox(
                width: 22.w,
              )
            ],
          ),
        ));
  }
}
