
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/x_utils/widgets/primary_app_bar.dart';


import '../../base/base_controller.dart';
import '../../x_res/app_text_style.dart';
import 'background_profile_widget.dart';

class BodyWithBannerWidget extends StatelessWidget {
  const BodyWithBannerWidget(
      {Key? key,
      required this.titleAppbar,
      this.urlAvt,
      required this.child,
      this.bottomWidget,
      this.bgColor,
      this.showActionInfo = true,
      this.height,
      this.onTapBack})
      : super(key: key);
  final String titleAppbar;
  final String? urlAvt;
  final Widget child;
  final Widget? bottomWidget;
  final double? height;
  final Color? bgColor;
  final VoidCallback? onTapBack;
  final bool showActionInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PrimaryAppBar(
          transparentBg: true,
          iconBack: Icon(Icons.arrow_back_ios_new),
          onTapBack: onTapBack ?? () => Get.back(),
          listActionAppbar: [
            if (showActionInfo)
              Container(
                  margin: EdgeInsets.only(right: 16), child: Icon(Icons.info)),
          ],
          centerAppbar: Text(titleAppbar, style: AppTextStyle.whiteS18W500),
        ),
        body: GestureDetector(
          onTap: () {
            Get.focusScope?.unfocus();
          },
          child: Container(
            color: bgColor ?? Colors.white,
            child: Stack(
              children: [
                BackgroundProfileWidget(
                  height: height ?? 200.h,
                  isShowBg: false,
                ),
                Container(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: 50).r,
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    child,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (bottomWidget != null) ...[
                          bottomWidget!,
                          SizedBox(height: 20.h)
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
