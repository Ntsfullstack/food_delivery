// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// import '../../x_res/app_text_style.dart';
// import '../../x_res/my_config.dart';
//
// class TextDropdownWidget<T> extends StatelessWidget {
//   const TextDropdownWidget(
//       {Key? key,
//       required this.items,
//       this.value,
//       required this.onChange,
//       this.leadingIcon,
//       this.spaceLeadingIcon,
//       this.radius,
//       this.buttonWidth,
//       this.height,
//       this.marginTop,
//       this.width,
//       this.colorIcon,
//       this.colorDropDown,
//       this.paddingHint,
//       this.styleHint,
//       this.onTab,
//       this.itemsWidget,
//       required this.isHighLightHint,
//       this.showData})
//       : super(key: key);
//
//   final List<T> items;
//   final String? value;
//   final ValueChanged<T?> onChange;
//   final Widget? leadingIcon;
//   final double? spaceLeadingIcon;
//   final double? radius;
//   final double? buttonWidth;
//   final double? height;
//   final double? marginTop;
//   final double? width;
//   final Color? colorIcon;
//   final Color? colorDropDown;
//   final EdgeInsetsGeometry? paddingHint;
//   final TextStyle? styleHint;
//   final VoidCallback? onTab;
//   final bool isHighLightHint;
//   final List<DropdownMenuItem<T>>? itemsWidget;
//   final String Function(T)? showData;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTab,
//       child: Container(
//         margin: EdgeInsets.only(top: marginTop ?? 0),
//         height: height ?? 30.h,
//         width: width,
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2<T>(
//             isExpanded: true,
//             hint: Container(
//               padding: paddingHint ?? EdgeInsets.zero,
//               child: Text(
//                 value ?? '',
//                 overflow: TextOverflow.ellipsis,
//                 style: (isHighLightHint)
//                     ? AppTextStyle.blackS16W300
//                     : AppTextStyle.secondaryS16W300,
//               ),
//             ),
//             customButton: Container(
//               alignment: Alignment.centerRight,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         value ?? '',
//                         style: AppTextStyle.blackS16W500,
//                       )),
//                   Icon(
//                     Icons.keyboard_arrow_down_rounded,
//                     color: Colors.black45,
//                     size: 24,
//                   ),
//                 ],
//               ),
//             ),
//             items: itemsWidget ??
//                 items
//                     .map(
//                       (item) => DropdownMenuItem<T>(
//                         value: item,
//                         child: Row(
//                           children: [
//                             leadingIcon ?? SizedBox(),
//                             SizedBox(
//                               width: spaceLeadingIcon ?? 0,
//                             ),
//                             Text(
//                               showData?.call(item) ?? '',
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                     .toList(),
//             dropdownMaxHeight: 300.h,
//             onChanged: (T? value) {
//               onChange.call(value);
//             },
//             icon: Icon(
//               Icons.keyboard_arrow_down,
//               color: colorIcon ?? Colors.white,
//             ),
//             iconSize: 24.r,
//             buttonHeight: height,
//             buttonWidth: buttonWidth,
//             buttonPadding: const EdgeInsets.only(right: 4).r,
//             buttonDecoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 border: Border.all(color: MyColor.COLOR_STOKE),
//                 borderRadius:
//                     BorderRadius.all(Radius.circular(radius ?? 16).w)),
//             itemHeight: 40.h,
//             itemPadding: const EdgeInsets.only(left: 15, right: 15).r,
//             dropdownDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15).w,
//               color: colorDropDown ?? Colors.white,
//             ),
//             dropdownElevation: 1,
//             scrollbarRadius: const Radius.circular(40).w,
//             scrollbarThickness: 6,
//             scrollbarAlwaysShow: true,
//           ),
//         ),
//       ),
//     );
//   }
// }
