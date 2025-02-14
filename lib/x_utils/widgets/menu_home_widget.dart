// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
//
// import '../../models/home/node.dart';
// import '../../x_res/my_config.dart';
// import 'gridview_dash_widget.dart';
//
// class MenuHomeWidget extends StatelessWidget {
//   const MenuHomeWidget({
//     Key? key,
//     required this.listData, this.onPress,
//   }) : super(key: key);
//
//   final List<Nodes> listData;
//   final Function(int)? onPress;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.white,
//         padding: EdgeInsets.symmetric(horizontal: 14).w,
//         child: GridViewDashWidget(
//           countItem: listData.length,
//           child: (BuildContext context, int index) {
//             return InkWell(
//               onTap: () {
//                 onPress?.call(index);
//               },
//               child: Container(
//                 padding: const EdgeInsets.fromLTRB(3, 10, 3, 0).r,
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 50.w,
//                       height: 50.w,
//                       padding: EdgeInsets.all(10.w),
//                       decoration: BoxDecoration(
//                           color:listData[index].color?? MyColor.PRIMARY_COLOR,
//                           borderRadius: BorderRadius.circular(50)),
//                       child: SvgPicture.asset(listData[index].icon ?? '',color: Colors.white,),
//                     ),
//                     SizedBox(height: 2.h),
//                     Text(
//                       listData[index].title ?? '',
//                       textAlign: TextAlign.center,
//                       maxLines: 2,
//                       style: TextStyle(
//                           overflow: TextOverflow.ellipsis,
//                           fontWeight: FontWeight.w300,
//                           fontSize: 12.sp),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ));
//   }
// }
