// import 'package:drum_app/x_utils/widgets/text_form_field_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../x_res/my_config.dart';
// import '../validate.dart';
//
// class FormInputWithTitle extends StatelessWidget {
//   final String title;
//   final String? hint;
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
//   const FormInputWithTitle(
//       {Key? key,
//       required this.title,
//       this.hint,
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
//       margin: EdgeInsets.only(top: marginTop ?? 0, bottom: marginBottom ?? 0).r,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               SizedBox(width: 4.w),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//               ),
//               if (tailTitle != null) tailTitle!,
//             ],
//           ),
//           SizedBox(
//             height: 8.h,
//           ),
//           AppTextField(
//             border: enabled
//                 ? null
//                 : OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.all(Radius.circular(16).w),
//                   ),
//             enabled: enabled,
//             // validate: validate,
//             controller: controller,
//             suffixIcon: suffixIcon,
//             onChanged: onChanged,
//             keyboardType: keyboardType,
//             bgColor: bgColor ?? Colors.white,
//             hintText: hint ?? '',
//             colorHint: MyColor.COLOR_SECONDARY_TEXT.withOpacity(0.6),
//             inputFormatters: inputFormatters,
//           ),
//         ],
//       ),
//     );
//   }
// }
