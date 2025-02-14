import 'package:flutter/material.dart';

import '../../base/base_controller.dart';
import '../../x_res/app_text_style.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key, required this.title, this.color,
  });
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4,top: 2),
      decoration: BoxDecoration(
          color: (color??MyColor.PRIMARY_COLOR).withOpacity(0.1),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      child: Text(
        title,
        style: AppTextStyle.primary11.copyWith(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
