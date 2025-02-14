// import 'package:flutter/services.dart';
// import 'utilities.dart';
//
// class CurrencyInputFormatter extends TextInputFormatter {
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     TextEditingValue newValueTmp = newValue;
//     if (newValueTmp.text[newValueTmp.text.length - 1] == ",")
//       newValueTmp = newValueTmp.copyWith(
//           text:
//           newValueTmp.text.substring(0, newValueTmp.text.length - 1) + ".");
//     if (newValueTmp.text.indexOf(".") == newValueTmp.text.length - 1 ) {
//       return newValueTmp;
//     }
//     if (newValueTmp.selection.baseOffset == 0) {
//       return newValueTmp;
//     }
//     if (num.tryParse(newValueTmp.text) == 0) {
//       return newValueTmp;
//     }
//
//   }
// }
//
// class UnitInputFormatter extends TextInputFormatter {
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     TextEditingValue newValueTmp = newValue;
//     if (newValueTmp.text[newValueTmp.text.length - 1] == ",")
//       newValueTmp = newValueTmp.copyWith(
//           text:
//           newValueTmp.text.substring(0, newValueTmp.text.length - 1) + ".");
//     if (newValueTmp.text.indexOf(".") == newValueTmp.text.length - 1 ) {
//       return newValueTmp;
//     }
//     if (newValueTmp.selection.baseOffset == 0) {
//       return newValueTmp;
//     }
//     if (num.tryParse(newValueTmp.text) == 0) {
//       return newValueTmp;
//     }
//     // String newText = Utilities().unitFormat(newValueTmp.text);
//     // if (newText.isEmpty) return oldValue;
//     return newValueTmp;
//     // return newValueTmp.copyWith(
//     //     text: newText,
//     //     selection: new TextSelection.collapsed(offset: newText.length));
//   }
// }
//
