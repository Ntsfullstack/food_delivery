import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../x_res/my_config.dart';

class ItemTransaction extends StatelessWidget {
  final String title;
  final String? icon;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTab;
  final Color bgColor;

  const ItemTransaction({
    Key? key,
    required this.title,
    this.icon,
    this.margin,
    this.onTab,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        padding: icon == null
            ? EdgeInsets.symmetric(horizontal: 16, vertical: 10).r
            : EdgeInsets.symmetric(horizontal: 22, vertical: 20).r,
        margin: margin,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(16).w, topLeft: Radius.circular(16).w)),
        child: Row(
          children: [
            icon == null
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24.r,
                  )
                : SvgPicture.asset(icon!),
            SizedBox(
              width: 8.w,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),

            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
