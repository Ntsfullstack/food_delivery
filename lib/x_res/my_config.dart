import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

/// CONFIGS DATA
class MyConfig {
  /// APP CONFIG
  static const String APP_NAME = "-- FLUTTER BASE APP --";
  // static final String BASE_URL = baseUrl ?? "";
  static const String TOKEN_STRING_KEY = 'TOKEN_STRING_KEY';
  static const String EMAIL_KEY = 'EMAIL_KEY';
  static const String FCM_TOKEN_KEY = 'EMAIL_KEY';
  static const String ROLE = 'ROLE';
  static const String SHOP_INFO = 'SHOP_INFO';
  static const String SHOP_NAME = 'SHOP_NAME';
  static const String USER_NAME = 'USER_NAME';
  static const String ACCESS_TOKEN_KEY = 'ACCESS_TOKEN_KEY';
  static const String REFRESH_TOKEN_KEY = 'REFRESH_TOKEN_KEY';
  static const String USER_INFO = 'USER_INFO';
  static const String CONNECT_PRINTER = 'CONNECT_PRINTER';
  static const String PRINTER_BLU = 'PRINTER';
  static const String PRINTER_IP = 'PRINTER_IP';
  static const String REMEMBER_STORE = 'REMEMBER_STORE';
  static const String EXPORT_MTT = 'EXPORT_MTT';
  static const String PRINT_REMEMBER = 'PRINT_REMEMBER';
  static const String PATCH_VERSION = 'PATCH_VERSION';
  static const String TYPE_PAYMENT = 'TYPE_PAYMENT';
  static const String EMAIL_REPORT = 'EMAIL_REPORT';
  static const String GROUP_ID2 = 'GROUP_ID2';

  /// CUSTOM CONFIG APP
  static const String LANGUAGE = 'LANGUAGE';

  // receiveTimeout
  static const int RECEIVE_TIMEOUT = 30000;

  // connectTimeout
  static const int CONNECTION_TIMEOUT = 30000;
}

/// SPACINGS DATA
class MySpace {
  /// Padding
  static const double paddingZero = 0.0;
  static const double paddingXS = 2.0;
  static const double paddingS = 4.0;
  static const double paddingM = 8.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 36.0;

  /// Margin
  static const double marginZero = 0.0;
  static const double marginXS = 2.0;
  static const double marginS = 4.0;
  static const double marginM = 8.0;
  static const double marginL = 16.0;
  static const double marginXL = 32.0;

  /// Spacing
  static const double spaceXS = 2.0;
  static const double spaceS = 4.0;
  static const double spaceM = 8.0;
  static const double spaceL = 16.0;
  static const double spaceXL = 32.0;
}

class MyStyle {
  static final headLine1 = TextStyle(
      fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.w500);
  static final headLine2 = TextStyle(
      fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w500);
  static final headLine3 = TextStyle(
      fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w300);
  static final headLineBlack1 = TextStyle(
      fontSize: 28.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static final headLinePrimary2 = TextStyle(
      fontSize: 18.sp,
      color: MyColor.COLOR_BTN_PRIMARY,
      fontWeight: FontWeight.w500);
  static final headLineBlack3 = TextStyle(
      fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w300);
  static final headLineBlack2 = TextStyle(
      fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static final headLineBlackNormal = TextStyle(
      fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w300);
  static final headLineBlackW500 = TextStyle(
      fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500);
  static final headLineS13W300 = TextStyle(
      fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.w300);
  static final headLineS13W300Link = TextStyle(
      fontSize: 13.sp, color: MyColor.MAIN_SOLID, fontWeight: FontWeight.w300);
  static final headLineWhiteW500 = TextStyle(
      fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w500);
}

/// COLORS DATA
class MyColor {
  /// Common Colors
  static const PRIMARY_COLOR = Color(0xff7060E5);
  static const SECONDARY = Color(0xFF3EA720);
  static const ERROR = Color(0xFFF82C2C);
  static const MISTY_COLOR = Color(0xFFE0E0E0);
  static const Color LIGHT_BACKGROUND_COLOR = Color(0xFFF9F9F9);
  static const ACCENT_COLOR = Color(0xFF9B51E0);
  static const PRIMARY_VARIANT = Color(0xFF9B51E0);
  static const PRIMARY_VARIANT_LIGHT = Color(0xFFE8F5E9);
  static const PRIMARY_SWATCH = Color(0xFF3681EC);
  static const PIMARY_ICON_COLOR = Color(0xFF7060e5);
  static const BUTTON_COLORS = Color(0xffe0595d);
  static const CARD_COLOR = Colors.white;
  static const TEXT_COLOR_WHITE = Colors.white;

  static const ICON_COLOR = Color(0xFFE5DFEB);
  static const TEXT_COLOR = Color(0xFF000000);
  static const BUTTON_COLOR = PRIMARY_COLOR;
  static const TEXT_BUTTON_COLOR = Colors.white;
  static const BOX_COLOR_WHITE = Colors.white;
  static final MAIN_COLOR = Colors.cyan[700];

  static const PRIMARY_DARK_COLOR = Color(0xFF3B85AF);
  static const Color DARK_BACKGROUND_COLOR = Color(0xFF000000);
  static const ICON_COLOR_DARK = Colors.white;
  static const TEXT_COLOR_DARK = Color(0xFFffffff);
  static const BUTTON_COLOR_DARK = PRIMARY_DARK_COLOR;
  static const TEXT_BUTTON_COLOR_DARK = Colors.black;
  static const COLOR_BTN_LOGIN = Color(0xFF0DFFF0);
  static const COLOR_BTN_PRIMARY = Color(0xFF3C87B3);
  static const COLOR_STOKE = Color(0xFFE5DFEB);
  static const COLOR_SECONDARY_TEXT = Color(0xFF4E445B);
  static const MAIN_SOLID = Color(0xFF3B85AF);
  static const BG_COLOR = Color(0xFFF0F0F0);
  static const COLOR_GREEN = Color(0xFF00A84F);
  static const COLOR_DARD_SOLID = Color(0xFF0E4F74);
  static const COLOR_LIGHT_SOLID = Color(0xFFECF8FF);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const LIGHT_SOLID = Color(0xFFECF8FF);
  static const FOUNDATION = Color(0xFFC3C6C9);
  static const NAVY = Color(0xFF00A3FF);
  static const PURPLE = Color(0xFF3A2FD3);
  static const SECONDARY_GREEN = Color(0xFF10D36C);
  static final PRIMARY_GRADIENT = [
    const Color(0xFF1E7DE9),
    const Color(0xFF18C0EF),
  ];

  static const CONSUMER = Color(0xFFF5ECFF);
  static const DENIED = Color(0xFFF96800);
  static const COLOR_TEXT_SUB_CONTENT = Color(0xFF1E1E1E);
  static const DEEP_BLUE = Color(0xFF3A2FD3);
  static const BLUE = Color(0xFF22BFCE);
  static const ORANGE = Color(0xFFF2783A);
  static final GRADIENT_LINE = [
    const Color(0xFF5AF9FF),
    const Color(0xFFE86EFF),
  ];
}
