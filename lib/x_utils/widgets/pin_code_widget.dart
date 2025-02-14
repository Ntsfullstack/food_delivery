// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../base/base_controller.dart';
// import '../validate.dart';
//
// class PinCodeWidget extends StatefulWidget {
//   const PinCodeWidget(
//       {Key? key,
//       required this.valueChange,
//       this.paddingHorizontal,
//       this.shape,
//       this.obscureText,
//       this.fieldWidth,
//       this.controller,
//       this.validate})
//       : super(key: key);
//   final Function(String) valueChange;
//   final double? paddingHorizontal;
//   final PinCodeFieldShape? shape;
//   final bool? obscureText;
//   final double? fieldWidth;
//   final TextEditingController? controller;
//   final Validate? validate;
//
//   @override
//   State<PinCodeWidget> createState() => _PinCodeWidgetState();
// }
//
// class _PinCodeWidgetState extends State<PinCodeWidget> {
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal ?? 0).r,
//       child: Form(
//         key: _formKey,
//         child: PinCodeTextField(
//           appContext: Get.context!,
//           pastedTextStyle: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.normal,
//           ),
//           length: 6,
//           obscureText: widget.obscureText ?? false,
//           controller: widget.controller,
//           blinkWhenObscuring: false,
//           validator: (value) {
//             if (widget.validate != null &&
//                 widget.validate!.validate(value) != null) {
//               return widget.validate!.validate(value);
//             }
//             return null;
//           },
//           animationType: AnimationType.scale,
//           animationCurve: Curves.ease,
//           pinTheme: PinTheme(
//             shape: widget.shape ?? PinCodeFieldShape.box,
//             borderRadius: BorderRadius.all(Radius.circular(10.0).w),
//             activeColor: MyColor.COLOR_BTN_PRIMARY,
//             inactiveColor: MyColor.COLOR_STOKE,
//             selectedColor: MyColor.COLOR_BTN_PRIMARY,
//             borderWidth: 2.0,
//             fieldHeight: 52,
//             fieldWidth: widget.fieldWidth ?? Get.width * 0.1077,
//           ),
//           textStyle: TextStyle(fontSize: 24.sp, color: Colors.black),
//           cursorColor: Colors.black,
//           keyboardType: TextInputType.number,
//           onChanged: widget.valueChange,
//           autoDisposeControllers: false,
//         ),
//       ),
//     );
//   }
// }
