// import 'package:flutter/cupertino.dart';
// import 'package:senpos_ticket/x_utils/validator_util.dart';
//
// abstract class Validate<T> {
//   String? validate(T value);
// }
//
// class PhoneValidate extends Validate<String> {
//   final FocusNode? focusNode;
//
//   PhoneValidate({this.focusNode});
//
//   @override
//   String? validate(String value) {
//     if (value.trim().isEmpty) {
//       focusNode?.requestFocus();
//       return 'Phone number cannot be empty';
//     }
//     if (!Validator().phoneNumber(value.trim())) {
//       focusNode?.requestFocus();
//       return 'Phone number invalid';
//     }
//     return null;
//   }
// }
//
// class EmailValidate extends Validate<String> {
//   final String? message;
//
//   EmailValidate({this.message});
//
//   @override
//   String? validate(String value) {
//     if (value.trim().isEmpty) return "Email empty";
//     final emailRegexp = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     if (emailRegexp.hasMatch(value.trim()) == false) {
//       return message ?? "Email was wrong format";
//     }
//     return null;
//   }
// }
//
// class PasswordValidate implements Validate<String> {
//   final TextEditingController? comparePwd;
//
//   PasswordValidate({this.comparePwd});
//
//   @override
//   String? validate(String value) {
//     if (value.trim().isEmpty) return 'Mật khẩu không được để trống';
//     if (value.trim().length < 6 || value.trim().length > 32)
//       return 'Mật khẩu phải từ 6-32 ký tự';
//     // final passwordRegexp = RegExp(
//     //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$');
//     // if (passwordRegexp.hasMatch(value.trim()) == false) {
//     //   return 'err_login_pwd_invalid'.tr;
//     // }
//     if (comparePwd != null && comparePwd!.text.trim() != value.trim()) {
//       return 'Mật khẩu mới không khớp';
//     }
//     return null;
//   }
// }
//
// class PinCodeValidate implements Validate<String> {
//   final TextEditingController? comparePin;
//
//   PinCodeValidate({this.comparePin});
//
//   @override
//   String? validate(String value) {
//     if (comparePin != null && comparePin!.text.trim() != value.trim()) {
//       return 'Pin code does not match';
//     }
//     return null;
//   }
// }
//
// class EmptyValidate implements Validate<String> {
//   final String? message;
//   final FocusNode? focusNode;
//
//   EmptyValidate({
//     this.message,
//     this.focusNode,
//   });
//
//   @override
//   String? validate(String value) {
//     if (value.trim().isEmpty) return message ?? "Required field to enter.";
//     return null;
//   }
// }
