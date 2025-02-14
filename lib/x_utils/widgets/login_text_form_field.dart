// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// import '../../x_res/app_text_style.dart';
// import '../currency_input_formater.dart';
//
// // ignore: must_be_immutable
// class LoginTextFormField extends StatelessWidget {
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
//
//   LoginTextFormField(
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
//       this.currencyMode = false,
//       this.inputNumber = false,
//       this.obscureText = false});
//
//   @override
//   Widget build(BuildContext context) {
//     if (obscureText) {
//       _withIconShowHideText = true;
//     }
//     var inputDecoration = InputDecoration(
//       hintText: hint,
//       counterText: "",
//       // labelText: "$labelText",
//       contentPadding: EdgeInsets.symmetric(
//         vertical: 10,
//         horizontal: 10,
//       ).r,
//       filled: true,
//       fillColor: controller?.text.isEmpty ?? false
//           ? Color.fromRGBO(248, 247, 251, 1)
//           : Colors.transparent,
//       hintStyle: AppTextStyle.greyS14,
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//           borderSide: BorderSide(
//             color: controller?.text.isEmpty ?? false
//                 ? Colors.grey.shade400
//                 : Theme.of(context).primaryColor,
//           )),
//       enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//           borderSide: BorderSide(
//             color: controller?.text.isEmpty ?? false
//                 ? Colors.grey.shade400
//                 : Theme.of(context).primaryColor,
//           )),
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//           borderSide: BorderSide(
//             color: Theme.of(context).primaryColor,
//           )),
//     );
//
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if(labelText != "")
//             Title(color: Colors.black, child: Text(labelText)),
//             SizedBox(height: 4.h),
//             Stack(
//               children: [
//                 controller == null
//                     ? TextFormField(
//                         controller: null,
//                         validator: (val) {
//                           if (val == '') {
//                             return "Vui lòng điền $labelText";
//                           } else {
//                             return null;
//                           }
//                         },
//                         maxLength: maxLength,
//                         onChanged: onChanged,
//                         focusNode: focusNode,
//                         onSaved: onSaved,
//                         onFieldSubmitted: (val) {
//                           if (focusNodeNext != null) {
//                             FocusScope.of(context).unfocus();
//                             FocusScope.of(context).requestFocus(focusNodeNext);
//                           } else {
//                             FocusScope.of(context).unfocus();
//                             return FocusScope.of(context).requestFocus(FocusNode());
//                           }
//                         },
//                         initialValue: initialText,
//                         maxLines: maxLines,
//                         obscureText: obscureText,
//                         textInputAction: focusNodeNext != null
//                             ? TextInputAction.next
//                             : (maxLines > 1
//                                 ? TextInputAction.newline
//                                 : TextInputAction.done),
//                         keyboardType: inputNumber == true
//                             ? TextInputType.number
//                             : (maxLines > 1
//                                 ? TextInputType.multiline
//                                 : TextInputType.text),
//                         inputFormatters: inputNumber == true
//                             ? currencyMode == true
//                                 ? [
//                                     FilteringTextInputFormatter.digitsOnly,
//                                     CurrencyInputFormatter()
//                                   ]
//                                 : [FilteringTextInputFormatter.digitsOnly]
//                             : null,
//                         decoration: inputDecoration,
//                       )
//                     : TextFormField(
//                         controller: controller,
//                         validator: (val) {
//                           if (val == '') {
//                             return "Vui lòng điền $labelText";
//                           } else {
//                             return null;
//                           }
//                         },
//                         maxLength: maxLength,
//                         onChanged: onChanged,
//                         focusNode: focusNode,
//                         onSaved: onSaved,
//                         onFieldSubmitted: (val) {
//                           if (focusNodeNext != null) {
//                             FocusScope.of(context).unfocus();
//                             FocusScope.of(context).requestFocus(focusNodeNext);
//                           } else {
//                             FocusScope.of(context).unfocus();
//                             return FocusScope.of(context).requestFocus(FocusNode());
//                           }
//                         },
//                         // initialValue: initialText,
//                         maxLines: maxLines,
//                         obscureText: obscureText,
//                         textInputAction: focusNodeNext != null
//                             ? TextInputAction.next
//                             : (maxLines > 1
//                                 ? TextInputAction.newline
//                                 : TextInputAction.done),
//                         keyboardType: inputNumber == true
//                             ? TextInputType.number
//                             : (maxLines > 1
//                                 ? TextInputType.multiline
//                                 : TextInputType.text),
//                         inputFormatters: inputNumber == true
//                             ? (currencyMode == true
//                                 ? [
//                                     FilteringTextInputFormatter.digitsOnly,
//                                     CurrencyInputFormatter()
//                                   ]
//                                 : [FilteringTextInputFormatter.digitsOnly])
//                             : null,
//                         decoration: inputDecoration,
//                       ),
//                 _withIconShowHideText == false
//                     ? Container()
//                     : Positioned(
//                         right: 5.w,
//                         top: 0,
//                         child: IconButton(
//                           icon: obscureText == true
//                               ? Icon(
//                                   Icons.visibility_off,
//                                   color: Colors.grey,
//                                 )
//                               : Icon(
//                                   Icons.visibility,
//                                   color: Colors.grey,
//                                 ),
//                           onPressed: () {
//                             setState(() {
//                               if (obscureText == true) {
//                                 obscureText = false;
//                               } else {
//                                 obscureText = true;
//                               }
//                             });
//                           },
//                         ),
//                       )
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
