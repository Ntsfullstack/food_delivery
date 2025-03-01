import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';
import 'app_button.dart';

class DialogErrorWidget extends StatelessWidget {
  const DialogErrorWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Thông báo",
              style: AppTextStyle.errorS16W500,
            ),
            const SizedBox(height: 16),
            Text(message),
            const SizedBox(height: 16),
            AppButton(
              backgroundColor: Colors.grey,
              text: "Cancel",
              onPress: () {
                Get.back();
              },
              textColor: MyColor.white,
            ),
          ],
        ),
      ),
    );
  }
}
