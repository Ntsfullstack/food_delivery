import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';
import '../enum.dart';

class UploadIdentityWidget extends StatelessWidget {
  const UploadIdentityWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    this.path,
    required this.type,
    this.onTab,
    required this.icon,
    required this.supperTile,
    this.onTabCancel,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String icon;
  final String supperTile;
  final PreviewType type;

  final Function(PreviewType)? onTab;
  final VoidCallback? onTabCancel;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          supperTile,
          style: AppTextStyle.blackS14W500,
        ),
        SizedBox(
          height: 8.h,
        ),
        Center(
          child: InkWell(
            onTap: () => onTab?.call(type),
            child: Container(
              padding: const EdgeInsets.all(16).w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0).w,
                border: Border.all(width: 1, color: MyColor.COLOR_STOKE),
              ),
              child: DottedBorder(
                color: MyColor.COLOR_STOKE,
                padding: const EdgeInsets.all(8).w,
                radius: const Radius.circular(8).w,
                dashPattern: const [8, 5],
                borderType: BorderType.RRect,
                child: ClipRRect(
                  child: Container(
                    child: path != null
                        ? Image.file(
                            File(path ?? ''),
                            width: 67.w,
                            height: 45.h,
                            fit: BoxFit.fill,
                          )
                        : SvgPicture.asset(icon),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
