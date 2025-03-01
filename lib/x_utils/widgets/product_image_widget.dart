
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4).w,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        // child: CachedNetworkImage(
        //   imageUrl: imageUrl,
        //   httpHeaders: ConnectionUtil.getAuthorization(),
        //   placeholder: (context, url) => Center(
        //     child: Container(
        //       width: 20.w,
        //       height: 20.w,
        //       child: CircularProgressIndicator(
        //         color: MyColor.MAIN_SOLID,
        //       ),
        //     ),
        //   ),
        //   errorWidget: (context, url, error) => Container(
        //     decoration: BoxDecoration(
        //         color: MyColor.COLOR_DARD_SOLID,
        //         borderRadius: BorderRadius.circular(4).w),
        //   ),
        // ),
      ),
    );
  }
}
