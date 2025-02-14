import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/x_utils/snackbar_util.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

import '../x_res/my_res.dart';

///
/// --------------------------------------------
/// There are many amazing [Function]s in this class.
/// Especialy in [Function]ality.
/// You can find and use on your Controller wich is the Controller extends [BaseController].
mixin class Utilities {
  // void callPhoneNumber({String phone = "0"}) async {
  //   launchUrl(Uri(scheme: 'tel', path: phone));
  // }

  // void intentOpenUrl({String link = "https://google.com"}) async {
  //   final url = link;
  //   if (await canLaunchUrl(Uri.parse(link))) {
  //     await launchUrl(Uri.parse(link));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  String rupiahFormater(String value) {
    if (value == null || value == 'null') {
      value = "0";
    }

    double amount = double.parse(value);
    // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
    // String c = fmf.output.nonSymbol.toString().replaceAll(".00", "");
    // String fix = "Rp. " + c.replaceAll(",", ".");
    return value;
  }

  String unitFormater(String? value) {
    try {
      String formattedNumber = "0";
      if (value == null || value == 'null') {
        return formattedNumber;
      }
      // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
      // String c = fmf.output.nonSymbol.toString().replaceAll(".00", "");
      // String fix = "" + c.replaceAll(",", ".");
      num myNumber = num.parse(value.replaceAll(",", ""));
      NumberFormat numberFormatter = NumberFormat('###,###,###,##0.##');
      formattedNumber = numberFormatter.format(myNumber);
      return formattedNumber;
    } catch (e) {
      print(e);
      return "0";
    }
  }

  String moneyFormater(String? value) {
    try {
      String formattedNumber = "0";
      if (value == null || value == 'null') {
        return formattedNumber;
      }
      // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
      // String c = fmf.output.nonSymbol.toString().replaceAll(".00", "");
      // String fix = "" + c.replaceAll(",", ".");
      num myNumber = num.parse(value.replaceAll(",", ""));
      NumberFormat numberFormatter = NumberFormat('###,###,###,##0.##');
      formattedNumber = numberFormatter.format(myNumber);
      return formattedNumber;
    } catch (e) {
      print(e);
      return "0";
    }
  }

  String unitFormat(String? value) {
    try {
      String formattedNumber = "0";
      if (value == null || value == 'null') {
        return formattedNumber;
      }
      num myNumber = num.parse(value.replaceAll(",", ""));
      NumberFormat numberFormatter = NumberFormat('###,###,###,##0.#####');
      formattedNumber = numberFormatter.format(myNumber);
      return formattedNumber;
    } catch (e) {
      print(e);
      return "0";
    }
  }

  String moneyFormaterRoundFloor(String? value) {
    try {
      String formattedNumber = "0";
      if (value == null || value == 'null') {
        return formattedNumber;
      }
      // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
      // String c = fmf.output.nonSymbol.toString().replaceAll(".00", "");
      // String fix = "" + c.replaceAll(",", ".");
      num myNumber = num.parse(value.replaceAll(",", "")).round();
      NumberFormat numberFormatter = NumberFormat('###,###,###,##0');
      formattedNumber = numberFormatter.format(myNumber);
      return formattedNumber;
    } catch (e) {
      print(e);
      return "0";
    }
  }

  // Future<bool> printPOZ92(PrinterPosSystem print, XFile file) async {
  //   try {
  //     Uint8List imageBytes = await file.readAsBytes();
  //     // I.Image? image = I.decodeImage(imageBytes);
  //     // image = I.grayscale(image!);
  //     // I.Image thumbnail = I.copyResize(image, width: 500);
  //     // var data = thumbnail.data?.buffer;
  //     // if (data != null) {
  //     //   Uint8List byteData = I.encodePng(thumbnail);
  //     //   await print.printBitMap(pathImage: byteData);
  //     //
  //     // }
  //     await print.printBitMap(pathImage: imageBytes);
  //     return true;
  //   } catch (e) {
  //     SnackbarUtil.showErrSnackbar("In thất bại vui lòng thử lại.");
  //     return false;
  //   }
  // }
  Future<bool> printIMIN(XFile file) async {
    try {
      // var iminPrinter = IminPrinter();
      //    // must init the printer first. for more exmaple.. pls refer to example tab.
      // if(await iminPrinter.initPrinter()??false){
      //   Uint8List imageBytes = await file.readAsBytes();
      //   await iminPrinter.printSingleBitmap(imageBytes);
      //   await iminPrinter.printAndLineFeed();
      //   await iminPrinter.printAndLineFeed();
      // }
      return true;
    } catch (e) {
      SnackbarUtil.showErrSnackbar("In thất bại vui lòng thử lại.");
      return false;
    }
  }

  // Future<bool> printPOS(XFile file) async {
  //   try {
  //     var data = await file.readAsBytes();
  //     POS.PrinterController controllerBluetooth = POS.PrinterController();
  //     await controllerBluetooth.initBluetoothPrinter(
  //       onSuccess: (device) async{
  //         var a = await device.initPrinter();
  //         // device.printText("input Alo aloo ơi ơi", 'utf-8');
  //         device.printRasterBitmap(data, 0);
  //         device.printNextLine(1);
  //         device.printNextLine(1);
  //         device.printNextLine(1);
  //         // printerBLU = device;
  //       },
  //       onFailure: (error) {
  //         print('--> error : ${error}');
  //       },
  //     );
  //     return true;
  //   } catch (e) {
  //     SnackbarUtil.showErrSnackbar("In thất bại vui lòng thử lại.");
  //     return false;
  //   }
  // }

  Future<void> printB88(XFile file) async {
    // final telpoFlutterChannel = TelpoFlutterChannel();
    // final bool? statusPrinter = await telpoFlutterChannel.isConnected();
    // bool connected = false;
    // if (statusPrinter == true) {
    //   connected = true;
    //   SnackbarUtil.showErrSnackbar("Đã kết nối máy in");
    // } else {
    //   connected = await telpoFlutterChannel.connect();
    //   if (!connected)
    //   SnackbarUtil.showErrSnackbar( "Không tìm thấy máy in");
    // }
    // if (connected) {
    //   try {
    //     final sheet = TelpoPrintSheet();
    //     Uint8List? imageBytes = await file.readAsBytes();
    //     //     I.Image? image = I.decodeImage(imageBytes!);
    //     //
    //     //     image = I.grayscale(image!);
    //     //     I.Image thumbnail = I.copyResize(image, width: 400);
    //     //     var data = thumbnail.data?.buffer;
    //     if (data != null) {
    //       Uint8List byteData = I.encodePng(thumbnail);
    //       var spacing = PrintData.byte(bytesList: [byteData]);
    //       sheet.addElement(spacing);
    //       await telpoFlutterChannel.print(sheet);
    //     }
    //   } catch (e) {
    //     SnackbarUtil.showErrSnackbar("In thất bại vui lòng thử lại");
    //   }
    // }
  }

  // Future<bool> printBluetooth(BluetoothPrint bluetoothPrint, XFile file) async {
  //   try {
  //     Map<String, dynamic> config = Map();
  //     List<LineText> list = [];
  //     List<int>? imageBytes = await file.readAsBytes();
  //     String base64Image = base64Encode(imageBytes);
  //     list.add(LineText(
  //       type: LineText.TYPE_IMAGE,
  //       x: 10,
  //       y: 10,
  //       content: base64Image,
  //       width: 400,
  //     ));
  //     // config['width'] = 40; // 标签宽度，单位mm
  //     // config['height'] = 120;
  //     await bluetoothPrint.printLabel(config, list);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> printWifi(NetworkPrinter printer, XFile file) async {
  //   try {
  //     Uint8List? imageBytes = await file.readAsBytes();
  //     I.Image? image = I.decodeImage(imageBytes);
  //     image = I.grayscale(image!);
  //     I.Image thumbnail = I.copyResize(image, width: 580);
  //     // final I.Image image = I.decodeImage(imageBytes!)!;
  //     printer.image(thumbnail, align: PosAlign.left);
  //     printer.feed(1);
  //     printer.cut();
  //     printer.disconnect();
  //     return true;
  //   } catch (e) {
  //     printer.disconnect();
  //     return false;
  //   }
  // }

  NumberFormat moneyVietNamFormat() {
    return NumberFormat.compactCurrency(
        decimalDigits: 2, symbol: '', locale: 'vi');
  }

  static String convertNumToStringMoney(num? str) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0)
        .format(str ?? 0);
  }

  String decimalNumber(String? value) {
    try {
      String formattedNumber = "0";
      if (value == null || value == 'null') {
        return formattedNumber;
      }
      // FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amount);
      // String c = fmf.output.nonSymbol.toString().replaceAll(".00", "");
      // String fix = "" + c.replaceAll(",", ".");
      int myNumber = int.parse(value.replaceAll(".", ""));
      NumberFormat numberFormatter = NumberFormat('###,###,###,##0');
      formattedNumber = numberFormatter.format(myNumber);
      return formattedNumber;
    } catch (e) {
      print(e);
      return "0";
    }
  }

  String formattedDate({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return formattedDate;
  }

  String formattedDateGetDay({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('EEEE').format(dateTime);
    switch (formattedDate) {
      case "Monday":
        formattedDate = "Senin";
        break;
      case "Tuesday":
        formattedDate = "Selasa";
        break;
      case "Wednesday":
        formattedDate = "Rabu";
        break;
      case "Thursday":
        formattedDate = "Kamis";
        break;
      case "Friday":
        formattedDate = "Jum'at";
        break;
      case "Saturday":
        formattedDate = "Sabtu";
        break;
      case "Sunday":
        formattedDate = "Minggu";
        break;
    }

    return formattedDate;
  }

  String formattedDateGetMonth({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('MMMM').format(dateTime);
    switch (formattedDate) {
      case "January":
        formattedDate = "Januari";
        break;
      case "February":
        formattedDate = "Februari";
        break;
      case "March":
        formattedDate = "Maret";
        break;
      case "April":
        formattedDate = "April";
        break;
      case "May":
        formattedDate = "Mei";
        break;
      case "June":
        formattedDate = "Juni";
        break;
      case "July":
        formattedDate = "Juli";
        break;
      case "August":
        formattedDate = "Agustus";
        break;
      case "September":
        formattedDate = "September";
        break;
      case "October":
        formattedDate = "Oktober";
        break;
      case "November":
        formattedDate = "November";
        break;
      case "December":
        formattedDate = "Desember";
        break;
    }

    return formattedDate;
  }

  String formattedSimpleDate({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  String formattedSuperSimpleDate(
      {required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMM').format(dateTime);
    return formattedDate;
  }

  String formattedDateTimeWithDay(
      {required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String day = formattedDateGetDay(format: format, date: date);

    String formattedDate = DateFormat('dd MMMM yyyy HH:mm').format(dateTime);
    return '${day}, ${formattedDate}';
  }

  String formattedDateTime({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMMM yyyy HH:mm').format(dateTime);
    return formattedDate;
  }

  String formattedTime({required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('HH:mm').format(dateTime);
    return formattedDate;
  }

  String formattedSimpleDateTime(
      {required String format, required String date}) {
    if (date == 'null') {
      return "";
    }

    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = dateFormat.parse(date);

    String formattedDate = DateFormat('dd MMM yyyy HH:mm').format(dateTime);
    return formattedDate;
  }

  String parseHtmlString(String htmlString) {
    // var document = parse(htmlString);
    // String parsedString = parse(document.body.text).documentElement.text;
    return htmlString;
  }

  // Future<String> getVersionApp() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String appName = packageInfo.appName;
  //   String packageName = packageInfo.packageName;
  //   String version = packageInfo.version;
  //   String buildNumber = packageInfo.buildNumber;
  //   if (Platform.isAndroid) {
  //     return "Version " + version;
  //   } else {
  //     return "Version " + version;
  //   }
  // }

  String stringCardFormated(
      {String value = "", int splitOn = 3, String modelSplit = " "}) {
    String newValue = "Error Formating";
    if (value.length < splitOn) {
      newValue = value;
    } else {
      int startIndex = 0;
      int endIndex = splitOn;
      newValue =
          _formating(startIndex, endIndex, value, "", splitOn, modelSplit);
    }
    return newValue;
  }

  String _formating(int startIndex, int endIndex, String value, String temp,
      int splitOn, String modelSplit) {
    if (startIndex == 0 && endIndex >= value.length) {
      temp = value.substring(startIndex, endIndex);
      return temp;
    }
    if (startIndex == 0 && endIndex < value.length) {
      temp = value.substring(startIndex, endIndex);
      startIndex += splitOn;
      endIndex += splitOn;
      return _formating(startIndex, endIndex, value, temp, splitOn, modelSplit);
    }
    if (startIndex < value.length && endIndex < value.length) {
      temp += "$modelSplit" + value.substring(startIndex, endIndex);
      startIndex += splitOn;
      endIndex += splitOn;
      return _formating(startIndex, endIndex, value, temp, splitOn, modelSplit);
    } else {
      temp += "$modelSplit" + value.substring(startIndex, value.length);
      return temp;
    }
  }

  Color colorConvert(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      return Color(int.parse("0xFF" + color));
    }
    // else if (color.length == 8) {
    //   return Color(int.parse("0x" + color));
    // }
    return Color(int.parse("0x" + color));
  }

  String stringSliptedConvertToSentence(String string, String splitter) {
    string = string.replaceAll("$splitter", " ");
    string = string.capitalizeFirstofEach;
    return string;
  }

  void logWhenDebug(String tag, String message) {
    if (kDebugMode)
      log("$tag => ${message.toString()}", name: MyConfig.APP_NAME);
  }

  String hideNumber({required String number, int? indexStartHide}) {
    try {
      int startIndex = indexStartHide ?? 2;
      int endIndex = number.length - 3;
      String hiddenDigits = 'X' * (endIndex - startIndex);
      return number.replaceRange(startIndex, endIndex, hiddenDigits);
    } catch (e) {
      return number;
    }
  }

  // String getRequestStatusValue(String type) {
  //   switch (type) {
  //     case 'waiting':
  //       return RequestType.waiting.value;
  //     case 'approved':
  //       return RequestType.approved.value;
  //     case 'canceled':
  //       return RequestType.canceled.value;
  //     default:
  //       return RequestType.rejected.value;
  //   }
  // }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';

  String get allInCaps => this.toUpperCase();

  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}

// extension RetailOutTotalPriceExtension on List<RetailOutTicket> {
//   num calculateTotalPrice() {
//     return this.fold(0, (total, item) => total + (item.giaVe ?? 0));
//   }
// }

// extension RetailOutCountTicketExtension on List<RetailOut> {
//   num countTicket() {
//     return this.fold(0,
//         (previousValue, ticket) => previousValue + (ticket.tongSoLuong as int));
//   }
// }

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
