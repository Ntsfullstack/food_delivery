import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../x_res/app_text_style.dart';
import '../../../../x_res/my_config.dart';
import '../../../../x_res/x_r.dart';
import '../../../../x_utils/enum.dart';
import 'item_transaction.dart';


class ChooseImageBottomSheet extends StatelessWidget {
  const ChooseImageBottomSheet(
      {Key? key, this.onTab, this.showSelectPicture = true})
      : super(key: key);
  final bool showSelectPicture;
  final Function(ActionMedia)? onTab;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.back(),
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox.shrink(),
                      Expanded(
                        child: Text(
                          "Ảnh sản phẩm",
                          style: AppTextStyle.blackS16W500,
                        ),
                      ),
                      InkWell(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            weight: 20,
                          ))
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Vui lòng chon hoặc chụp ảnh sản phẩm",
                    style: AppTextStyle.blackS14W300,
                  ),
                  ItemTransaction(
                    title: "Chụp ảnh",
                    icon: XR().svgImage.ic_camera,
                    margin: EdgeInsets.only(top: 12),
                    bgColor: MyColor.LIGHT_SOLID,
                    onTab: () {
                      Get.back();
                      onTab?.call(ActionMedia.camera);
                    },
                  ),
                  if (showSelectPicture)
                    ItemTransaction(
                      title: "Chọn ảnh",
                      icon: XR().svgImage.ic_image,
                      margin: EdgeInsets.only(top: 12),
                      bgColor: MyColor.LIGHT_SOLID,
                      onTab: () {
                        Get.back();
                        onTab?.call(ActionMedia.gallery);
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
