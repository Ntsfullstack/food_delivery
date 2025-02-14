// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../x_res/my_config.dart';
// import '../connection_util.dart';
//
// class AvatarWidget extends StatelessWidget {
//   const AvatarWidget({
//     Key? key,
//     required this.imageUrl,
//   }) : super(key: key);
//
//   final String imageUrl;
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(56).w,
//       child: Container(
//         width: 48.w,
//         height: 48.h,
//         decoration: BoxDecoration(
//             color: MyColor.COLOR_DARD_SOLID,
//             ),
//         child: CachedNetworkImage(
//           imageUrl: imageUrl ?? '',
//           httpHeaders: ConnectionUtil.getAuthorization(),
//           placeholder: (context, url) => CircularProgressIndicator(
//             color: MyColor.MAIN_SOLID,
//           ),
//           errorWidget: (context, url, error) => Container(
//             decoration: BoxDecoration(
//                 color: MyColor.COLOR_DARD_SOLID,
//                 borderRadius: BorderRadius.circular(56).w),
//           ),
//         ),
//       ),
//     );
//   }
// }
