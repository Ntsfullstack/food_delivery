// import 'package:drum_app/x_utils/widgets/text_field_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// import '../../x_res/app_text_style.dart';
// import '../../x_res/my_config.dart';
// import '../validate.dart';
//
// class FormInputWithoutBorder extends StatelessWidget {
//   final String title;
//   final String? hint;
//   final String? note;
//   final ValueChanged<String>? onChanged;
//   final double? marginTop;
//   final double? marginBottom;
//   final bool enabled;
//   final Color? bgColor;
//   final TextEditingController? controller;
//   final Widget? tailTitle;
//   final Widget? suffixIcon;
//   final TextInputType keyboardType;
//   // final Validate? validate;
//   final List<TextInputFormatter>? inputFormatters;
//
//   const FormInputWithoutBorder(
//       {Key? key,
//       required this.title,
//       this.hint,
//       this.note,
//       this.onChanged,
//       this.marginTop,
//       this.keyboardType = TextInputType.text,
//       this.marginBottom,
//       this.enabled = true,
//       this.bgColor,
//       this.controller,
//       this.suffixIcon,
//       this.tailTitle,
//       // this.validate,
//       this.inputFormatters})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//           border: Border(
//               bottom: BorderSide(width: 0.5, color: Colors.grey.shade200))),
//       margin: EdgeInsets.only(top: marginTop ?? 0, bottom: marginBottom ?? 0).r,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   title,
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 width: 8.h,
//               ),
//               Expanded(
//                 flex: 2,
//                 child: AppTextFieldNonBody(
//                   border: UnderlineInputBorder(),
//                   enabledBorder: UnderlineInputBorder(),
//                   focusedBorder: UnderlineInputBorder(),
//                   enabled: enabled,
//                   // validate: validate,
//                   controller: controller,
//                   suffixIcon: suffixIcon,
//                   onChanged: onChanged,
//                   keyboardType: keyboardType,
//                   bgColor: bgColor ?? Colors.white,
//                   hintText: hint ?? '',
//                   colorHint: MyColor.COLOR_SECONDARY_TEXT.withOpacity(0.6),
//                   inputFormatters: inputFormatters,
//                 ),
//               ),
//             ],
//           ),
//           if (note != null) Padding(
//             padding: const EdgeInsets.only(top: 8.0, ),
//             child: Text(note!, style: AppTextStyle.greyS13,),
//           ),
//         ],
//       ),
//     );
//   }
// }
