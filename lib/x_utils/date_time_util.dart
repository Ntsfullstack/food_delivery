import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateTimeUtil {
  static getDate(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('dd');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String getDMYFromDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM yyyy', 'vi_VN');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String getStringDateTimeFromDateTime(DateTime dateTime) {
    try {
      final DateFormat formatter = DateFormat('dd-MM-yyyyTHH:mm:ss');
      final String formatted = formatter.format(dateTime);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  static String getStringDateTimeFromDateTime2(DateTime dateTime) {
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
      final String formatted = formatter.format(dateTime);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  static getDMY(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static getDMYAndHM(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static String getdMyAndHM(String times) {
    try {
      var date = DateTime.parse(times).toLocal();
      final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  static String getdMy(String times) {
    try {
      var date = DateTime.parse(times).toLocal();
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  static String getdMyAndHM3(String times) {
    try {
      var date = DateTime.parse(times).toLocal();
      final DateFormat formatter = DateFormat('HH:mm dd/MM/yy');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  static String getHM(String times) {
    try {
      var date = DateTime.parse(times).toLocal();
      final DateFormat formatter = DateFormat('HH:mm dd/MM');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  static String getdMyAndHM2(String times) {
    try {
      var date = DateTime.parse(times).toLocal();
      final DateFormat formatter = DateFormat('EEEE - dd/MM/yyyy', 'vi_VN');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  static DateTime? getDateOnlyDate(String times) {
    try {
      var date = DateTime.parse(times).toLocal();
      DateTime dateOnly = DateTime(date.year, date.month, date.day);
      return dateOnly;
    } catch (e) {}
  }

  static getMouthYear(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('MM/yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static getTime(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(date);
    return formatted;
  }

  static int toTimeStamp(String dateString) {
    int date = DateTime.parse(dateString).toLocal().millisecondsSinceEpoch;
    return date;
  }

  static int stringToTimeStamp(String dateString) {
    int date =
        DateFormat("dd/MM/yyyy").parse(dateString).millisecondsSinceEpoch;
    return date;
  }

  static String toYYMMDDString(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  static String toYYMMDD2String(DateTime date) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(date);
  }

  static String toYYMMDD3String(DateTime date) {
    var outputFormat = DateFormat('yyyy/MM/dd');
    return outputFormat.format(date);
  }

  static String toDDMMYYString(DateTime date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(date);
  }

  static DateTime toDateTime(String? dateString) {
    initializeDateFormatting();
    if (dateString == null) return DateTime.now();
    var date = DateTime.parse(dateString).toLocal();
    return date;
  }

  static String todayStr() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String utc2String(String times) {
    try {
      var date = DateTime.parse(times);
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "";
    }
  }
}
