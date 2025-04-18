// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../currency_input_formater.dart';
// import '../validate.dart';
//
// // ignore: must_be_immutable
// class MyTextFormField extends StatelessWidget {
//   ValueChanged<String>? onChanged;
//   String labelText;
//   String initialText;
//   String hint;
//   FocusNode? focusNode;
//   FocusNode? focusNodeNext;
//   bool obscureText;
//   bool inputNumber;
//   bool currencyMode;
//   bool _withIconShowHideText = false;
//   int maxLength;
//   int maxLines;
//   TextEditingController? controller;
//   FormFieldSetter<String>? onSaved;
//   Validate? validate;
//
//   MyTextFormField(
//       {this.onChanged,
//       this.labelText = "Label",
//       this.hint = "",
//       this.initialText = "",
//       this.focusNode,
//       this.focusNodeNext,
//       this.maxLength = 255,
//       this.maxLines = 1,
//       this.onSaved,
//       this.controller,
//       this.validate,
//       this.currencyMode = false,
//       this.inputNumber = false,
//       this.obscureText = false});
//
//   @override
//   Widget build(BuildContext context) {
//     if (obscureText) {
//       _withIconShowHideText = true;
//     }
//
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return Stack(
//           children: [
//             controller == null
//                 ? TextFormField(
//                     controller: null,
//                     validator: (value) {
//                       if (validate != null &&
//                           validate!.validate(value) != null) {
//                         return validate!.validate(value);
//                       }
//                       return null;
//                     },
//                     maxLength: maxLength,
//                     onChanged: onChanged,
//                     focusNode: focusNode,
//                     onSaved: onSaved,
//                     onFieldSubmitted: (val) {
//                       if (focusNodeNext != null) {
//                         FocusScope.of(context).unfocus();
//                         FocusScope.of(context).requestFocus(focusNodeNext);
//                       } else {
//                         FocusScope.of(context).unfocus();
//                         return FocusScope.of(context).requestFocus(FocusNode());
//                       }
//                     },
//                     initialValue: initialText,
//                     maxLines: maxLines,
//                     obscureText: obscureText,
//                     textInputAction: focusNodeNext != null
//                         ? TextInputAction.next
//                         : (maxLines > 1
//                             ? TextInputAction.newline
//                             : TextInputAction.done),
//                     keyboardType: inputNumber == true
//                         ? TextInputType.number
//                         : (maxLines > 1
//                             ? TextInputType.multiline
//                             : TextInputType.text),
//                     inputFormatters: inputNumber == true
//                         ? currencyMode == true
//                             ? [
//                                 FilteringTextInputFormatter.digitsOnly,
//                                 CurrencyInputFormatter()
//                               ]
//                             : [FilteringTextInputFormatter.digitsOnly]
//                         : null,
//                     decoration: InputDecoration(
//                       hintText: hint,
//                       counterText: "",
//                       labelText: "$labelText",
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 10,
//                       ).r,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5).w,
//                       ),
//                     ),
//                   )
//                 : TextFormField(
//                     controller: controller,
//                     validator: (value) {
//                       if (validate != null &&
//                           validate!.validate(value) != null) {
//                         return validate!.validate(value);
//                       }
//                       return null;
//                     },
//                     maxLength: maxLength,
//                     onChanged: onChanged,
//                     focusNode: focusNode,
//                     onSaved: onSaved,
//                     onFieldSubmitted: (val) {
//                       if (focusNodeNext != null) {
//                         FocusScope.of(context).unfocus();
//                         FocusScope.of(context).requestFocus(focusNodeNext);
//                       } else {
//                         FocusScope.of(context).unfocus();
//                         return FocusScope.of(context).requestFocus(FocusNode());
//                       }
//                     },
//                     // initialValue: initialText,
//                     maxLines: maxLines,
//                     obscureText: obscureText,
//                     textInputAction: focusNodeNext != null
//                         ? TextInputAction.next
//                         : (maxLines > 1
//                             ? TextInputAction.newline
//                             : TextInputAction.done),
//                     keyboardType: inputNumber == true
//                         ? TextInputType.number
//                         : (maxLines > 1
//                             ? TextInputType.multiline
//                             : TextInputType.text),
//                     inputFormatters: inputNumber == true
//                         ? (currencyMode == true
//                             ? [
//                                 FilteringTextInputFormatter.digitsOnly,
//                                 CurrencyInputFormatter()
//                               ]
//                             : [FilteringTextInputFormatter.digitsOnly])
//                         : null,
//                     decoration: InputDecoration(
//                       hintText: hint,
//                       counterText: "",
//                       labelText: "$labelText",
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 10,
//                       ).w,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5).w,
//                       ),
//                     ),
//                   ),
//             _withIconShowHideText == false
//                 ? Container()
//                 : Positioned(
//                     right: 5.w,
//                     top: 0,
//                     child: IconButton(
//                       icon: obscureText == true
//                           ? Icon(
//                               Icons.visibility_off,
//                               color: Colors.grey,
//                             )
//                           : Icon(
//                               Icons.visibility,
//                               color: Colors.grey,
//                             ),
//                       onPressed: () {
//                         setState(() {
//                           if (obscureText == true) {
//                             obscureText = false;
//                           } else {
//                             obscureText = true;
//                           }
//                         });
//                       },
//                     ),
//                   )
//           ],
//         );
//       },
//     );
//   }
// }
