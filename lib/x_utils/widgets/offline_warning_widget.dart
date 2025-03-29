import 'package:flutter/material.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';

class OfflineWarningWidget extends StatelessWidget {
  const OfflineWarningWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColor.ERROR, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: Row(
        children: [
          const Icon(
            Icons.warning_rounded,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Không có kết nối mạng, bạn đang ở chế độ offline",
              style: AppTextStyle.whiteS14W500,
            ),
          )
        ],
      ),
    );
  }
}
