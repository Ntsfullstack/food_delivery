// matching various patterns for kinds of data
import 'package:get/get.dart';

class Validator {
  Validator();

  bool email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value!))
      return true;
    else
      return false;
  }

  bool phoneNumber(String? value) {
    String pattern = r'(0[3|7|8|9])+([0-9]{8})\b';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty) {
      return false;
    } else {
      value = value.replaceFirst('+', '');
      if (value.substring(0, 2) == '84') {
        value = value.replaceFirst('84', '0');
      }
      if (!regExp.hasMatch(value)) {
        return false;
      }
    }
    return true;
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.password'.tr;
    else
      return null;
  }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.name'.tr;
    else
      return null;
  }

  String? number(String? value) {
    String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.number'.tr;
    else
      return null;
  }

  String? amount(String? value) {
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.amount'.tr;
    else
      return null;
  }

  String? notEmpty(String? value) {
    String pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'validator.notEmpty'.tr;
    else
      return null;
  }
}
