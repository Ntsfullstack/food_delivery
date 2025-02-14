// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:senpos_ticket/x_res/app_text_style.dart';
//
// class DropdownWithoutBorderWidget<T> extends StatelessWidget {
//   const DropdownWithoutBorderWidget(
//       {Key? key,
//       required this.items,
//       this.value,
//       required this.onChange,
//       required this.title,
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
//       this.borderBox,
//       required this.isHighLightHint,
//       this.showData})
//       : super(key: key);
//
//   final List<T> items;
//   final T? value;
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
//   final String title;
//   final Border? borderBox;
//   final List<DropdownMenuItem<T>>? itemsWidget;
//   final String Function(T)? showData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           if(title.isNotEmpty)
//           Expanded(
//             flex: 1,
//             child: Text(
//               title,
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ),
//           if(title.isNotEmpty)
//             SizedBox(
//             width: 8.h,
//           ),
//           Expanded(
//             flex: 2,
//             child: InkWell(
//               onTap: onTab,
//               child: Container(
//                 margin: EdgeInsets.only(top: marginTop ?? 0),
//                 height: height ?? 42.h,
//                 width: width,
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton2<T>(
//                     isExpanded: true,
//                     hint: Container(
//                       padding: paddingHint ?? EdgeInsets.zero,
//                       child: Text(
//                         value == null ? "" : (showData?.call(value!) ?? ''),
//                         overflow: TextOverflow.ellipsis,
//                         style: (isHighLightHint)
//                             ? AppTextStyle.blackS16W300
//                             : AppTextStyle.secondaryS16W300,
//                       ),
//                     ),
//                     items: itemsWidget ??
//                         items
//                             .map(
//                               (item) => DropdownMenuItem<T>(
//                                 value: item,
//                                 child: Row(
//                                   children: [
//                                     leadingIcon ?? SizedBox(),
//                                     SizedBox(
//                                       width: spaceLeadingIcon ?? 0,
//                                     ),
//                                     Text(
//                                       showData?.call(item) ?? '',
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                     dropdownMaxHeight: 300.h,
//                     onChanged: (T? value) {
//                       onChange.call(value);
//                     },
//                     icon: Icon(
//                       Icons.keyboard_arrow_down,
//                       color: colorIcon ?? Colors.white,
//                     ),
//                     iconSize: 24.r,
//                     buttonHeight: height,
//                     buttonWidth: buttonWidth,
//                     buttonPadding: const EdgeInsets.only(right: 4).r,
//                     buttonDecoration: BoxDecoration(
//                       border: borderBox??Border(bottom: BorderSide()),
//                     ),
//                     itemHeight: 40.h,
//                     itemPadding: const EdgeInsets.only(left: 15, right: 15).r,
//                     dropdownDecoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15).w,
//                       color: colorDropDown ?? Colors.white,
//                     ),
//                     dropdownElevation: 0,
//                     scrollbarRadius: const Radius.circular(40).w,
//                     scrollbarThickness: 6,
//                     scrollbarAlwaysShow: true,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
