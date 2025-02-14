
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';


/// CONFIGS DATA
class MyConfig {
  /// APP CONFIG
  static final String APP_NAME = "-- FLUTTER BASE APP --";
  // static final String BASE_URL = baseUrl ?? "";
  static final String TOKEN_STRING_KEY = 'TOKEN_STRING_KEY';
  static final String EMAIL_KEY = 'EMAIL_KEY';
  static final String FCM_TOKEN_KEY = 'EMAIL_KEY';
  static final String ROLE = 'ROLE';
  static final String SHOP_INFO = 'SHOP_INFO';
  static final String SHOP_NAME = 'SHOP_NAME';
  static final String USER_NAME = 'USER_NAME';
  static final String ACCESS_TOKEN_KEY = 'ACCESS_TOKEN_KEY';
  static final String REFRESH_TOKEN_KEY = 'REFRESH_TOKEN_KEY';
  static final String USER_INFO = 'USER_INFO';
  static final String CONNECT_PRINTER = 'CONNECT_PRINTER';
  static final String PRINTER_BLU = 'PRINTER';
  static final String PRINTER_IP = 'PRINTER_IP';
  static final String REMEMBER_STORE = 'REMEMBER_STORE';
  static final String EXPORT_MTT = 'EXPORT_MTT';
  static final String PRINT_REMEMBER = 'PRINT_REMEMBER';
  static final String PATCH_VERSION = 'PATCH_VERSION';
  static final String TYPE_PAYMENT = 'TYPE_PAYMENT';
  static final String EMAIL_REPORT = 'EMAIL_REPORT';
  static final String GROUP_ID2 = 'GROUP_ID2';

  /// CUSTOM CONFIG APP
  static final String LANGUAGE = 'LANGUAGE';

  // receiveTimeout
  static const int RECEIVE_TIMEOUT = 30000;

  // connectTimeout
  static const int CONNECTION_TIMEOUT = 30000;
}

/// SPACINGS DATA
class MySpace {
  /// Padding
  static final double paddingZero = 0.0;
  static final double paddingXS = 2.0;
  static final double paddingS = 4.0;
  static final double paddingM = 8.0;
  static final double paddingL = 16.0;
  static final double paddingXL = 32.0;
  static final double paddingXXL = 36.0;

  /// Margin
  static final double marginZero = 0.0;
  static final double marginXS = 2.0;
  static final double marginS = 4.0;
  static final double marginM = 8.0;
  static final double marginL = 16.0;
  static final double marginXL = 32.0;

  /// Spacing
  static final double spaceXS = 2.0;
  static final double spaceS = 4.0;
  static final double spaceM = 8.0;
  static final double spaceL = 16.0;
  static final double spaceXL = 32.0;
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
  static final PRIMARY_COLOR = Color(0xff7060E5);
  static final SECONDARY = Color(0xFF3EA720);
  static final ERROR = Color(0xFFF82C2C);
  static final MISTY_COLOR = Color(0xFFE0E0E0);
  static final Color LIGHT_BACKGROUND_COLOR = Color(0xFFF9F9F9);
  static final ACCENT_COLOR = Color(0xFF9B51E0);
  static final PRIMARY_VARIANT = Color(0xFF9B51E0);
  static final PRIMARY_VARIANT_LIGHT = Color(0xFFE8F5E9);
  static final PRIMARY_SWATCH = Color(0xFF3681EC);
  static final PIMARY_ICON_COLOR = Color(0xFF7060e5);
  static final BUTTON_COLORS = Color(0xffe0595d);
  static final CARD_COLOR = Colors.white;
  static final TEXT_COLOR_WHITE = Colors.white;

  static final ICON_COLOR = Color(0xFFE5DFEB);
  static final TEXT_COLOR = Color(0xFF000000);
  static final BUTTON_COLOR = PRIMARY_COLOR;
  static final TEXT_BUTTON_COLOR = Colors.white;
  static final BOX_COLOR_WHITE = Colors.white;
  static final MAIN_COLOR = Colors.cyan[700];

  static final PRIMARY_DARK_COLOR = Color(0xFF3B85AF);
  static final Color DARK_BACKGROUND_COLOR = Color(0xFF000000);
  static final ICON_COLOR_DARK = Colors.white;
  static final TEXT_COLOR_DARK = Color(0xFFffffff);
  static final BUTTON_COLOR_DARK = PRIMARY_DARK_COLOR;
  static final TEXT_BUTTON_COLOR_DARK = Colors.black;
  static final COLOR_BTN_LOGIN = Color(0xFF0DFFF0);
  static final COLOR_BTN_PRIMARY = Color(0xFF3C87B3);
  static final COLOR_STOKE = Color(0xFFE5DFEB);
  static final COLOR_SECONDARY_TEXT = Color(0xFF4E445B);
  static final MAIN_SOLID = Color(0xFF3B85AF);
  static final BG_COLOR = Color(0xFFF0F0F0);
  static final COLOR_GREEN = Color(0xFF00A84F);
  static final COLOR_DARD_SOLID = Color(0xFF0E4F74);
  static final COLOR_LIGHT_SOLID = Color(0xFFECF8FF);
  static final black = Color(0xFF000000);
  static final white = Color(0xFFFFFFFF);
  static final LIGHT_SOLID = Color(0xFFECF8FF);
  static final FOUNDATION = Color(0xFFC3C6C9);
  static final NAVY = Color(0xFF00A3FF);
  static final PURPLE = Color(0xFF3A2FD3);
  static final SECONDARY_GREEN = Color(0xFF10D36C);
  static final PRIMARY_GRADIENT = [
    Color(0xFF1E7DE9),
    Color(0xFF18C0EF),
  ];

  static final CONSUMER = Color(0xFFF5ECFF);
  static final DENIED = Color(0xFFF96800);
  static final COLOR_TEXT_SUB_CONTENT = Color(0xFF1E1E1E);
  static final DEEP_BLUE = Color(0xFF3A2FD3);
  static final BLUE = Color(0xFF22BFCE);
  static final ORANGE = Color(0xFFF2783A);
  static final GRADIENT_LINE = [
    Color(0xFF5AF9FF),
    Color(0xFFE86EFF),
  ];
}
