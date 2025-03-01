import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get_storage/get_storage.dart';


import 'app_text_style.dart';
import 'my_res.dart';

class AppThemes {
  final String _sThemeModeKey = 'S_THEME_MODE_KEY';
  final String _sThemeModeLight = '_sThemeModeLight';
  final String _sThemeModeDark = '_sThemeModeDark';
  static String NotoSans = "NotoSans";
  static String Roboto = "Roboto";
  static String QuicksandRegular = "QuicksandRegular";
  static String QuicksandMedium = "QuicksandMedium";

  static final String _fontFamily = Roboto;

  // LIGHT THEME TEXT
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 20.0.sp, fontFamily: _fontFamily),
    bodyLarge: TextStyle(fontSize: 16.0.sp, fontFamily: _fontFamily),
    bodyMedium: TextStyle(fontSize: 14.0.sp, fontFamily: _fontFamily),
    titleLarge: TextStyle(fontSize: 16.0.sp, fontFamily: _fontFamily),
    titleMedium: TextStyle(fontSize: 16.0.sp, fontFamily: _fontFamily),
    bodySmall: TextStyle(fontSize: 12.0.sp, fontFamily: _fontFamily),
    labelLarge: TextStyle(fontSize: 15.0.sp, fontFamily: _fontFamily),
    labelMedium: TextStyle(fontSize: 12.0.sp, fontFamily: _fontFamily),
    labelSmall: TextStyle(color: MyColor.TEXT_COLOR, fontFamily: _fontFamily),
  );

  // DARK THEME TEXT
  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 20.0.sp, fontFamily: _fontFamily),
    bodyMedium: TextStyle(fontSize: 14.0.sp, fontFamily: _fontFamily),
    titleLarge: TextStyle(fontSize: 16.0.sp, fontFamily: _fontFamily),
    titleMedium: TextStyle(fontSize: 16.0.sp, fontFamily: _fontFamily),
    bodySmall: TextStyle(fontSize: 12.0.sp, fontFamily: _fontFamily),
    bodyLarge: TextStyle(fontSize: 16.0.sp, fontFamily: _fontFamily),
    labelLarge: TextStyle(fontSize: 15.0.sp, fontFamily: _fontFamily),
    labelMedium: AppTextStyle.blackS14W300,
    labelSmall: TextStyle(color: MyColor.TEXT_COLOR, fontFamily: _fontFamily),
  );

  // LIGHT THEME
  static final ThemeData _lightTheme = ThemeData(
    fontFamily: _fontFamily,
    hintColor: Colors.black,
    primaryColor: MyColor.PRIMARY_COLOR,
    disabledColor: MyColor.COLOR_STOKE,
    // accentColor: MyColor.ACCENT_COLOR,
    scaffoldBackgroundColor: MyColor.LIGHT_BACKGROUND_COLOR,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MyColor.PRIMARY_COLOR,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: MyColor.SECONDARY,
      disabledColor: MyColor.MISTY_COLOR,
    ),
    appBarTheme: const AppBarTheme(
      // brightness: Brightness.dark,
      color: MyColor.PRIMARY_COLOR,
      iconTheme: IconThemeData(color: MyColor.ICON_COLOR),
    ),
    colorScheme: const ColorScheme.light(
      primary: MyColor.PRIMARY_COLOR,
      secondary: MyColor.SECONDARY,
    ),
    snackBarTheme:
        const SnackBarThemeData(backgroundColor: MyColor.LIGHT_BACKGROUND_COLOR),
    iconTheme: const IconThemeData(
      color: MyColor.ICON_COLOR,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: MyColor.LIGHT_BACKGROUND_COLOR),
    textTheme: _lightTextTheme,
    useMaterial3: true,
  );

  // DARK THEME
  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    hintColor: Colors.black,
    fontFamily: _fontFamily,
    primaryColor: MyColor.PRIMARY_DARK_COLOR,
    disabledColor: MyColor.COLOR_STOKE,
    scaffoldBackgroundColor: MyColor.DARK_BACKGROUND_COLOR,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MyColor.PRIMARY_DARK_COLOR,
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: MyColor.SECONDARY, disabledColor: MyColor.MISTY_COLOR),
    appBarTheme: const AppBarTheme(
      // brightness: Brightness.dark,
      color: MyColor.PRIMARY_DARK_COLOR,
      iconTheme: IconThemeData(color: MyColor.ICON_COLOR_DARK),
    ),
    colorScheme: const ColorScheme.dark(
        primary: MyColor.PRIMARY_DARK_COLOR, secondary: MyColor.SECONDARY),
    snackBarTheme:
        const SnackBarThemeData(backgroundColor: MyColor.DARK_BACKGROUND_COLOR),
    iconTheme: const IconThemeData(
      color: MyColor.ICON_COLOR_DARK,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: MyColor.DARK_BACKGROUND_COLOR),
    textTheme: _darkTextTheme,
  );
  static final TextTheme _lightTextThemeJp = TextTheme(
    headlineLarge: TextStyle(fontSize: 28.sp, fontFamily: _fontFamily),
    headlineMedium: TextStyle(fontSize: 24.0.sp, fontFamily: _fontFamily),
    headlineSmall: TextStyle(fontSize: 22.0.sp, fontFamily: _fontFamily),
    bodyLarge: TextStyle(fontSize: 14.0.sp, fontFamily: _fontFamily),
    bodyMedium: TextStyle(fontSize: 17.0.sp, fontFamily: _fontFamily),
    labelLarge: TextStyle(fontSize: 16.0.sp, fontFamily: _fontFamily),
    titleMedium: TextStyle(fontSize: 16.0.sp, fontFamily: _fontFamily),
    bodySmall: TextStyle(fontSize: 12.0.sp, fontFamily: _fontFamily),
  );

  /// LIGHT THEME
  static ThemeData theme() {
    return _lightTheme;
  }

  /// DARK THEME
  static ThemeData darkTheme() {
    return _darkTheme;
  }

  ///
  /// [AppThemes] initiation.
  /// Please Add [AppThemes().init() into GetMaterialApp.
  ///
  /// [Example] :
  ///
  /// GetMaterialApp(
  ///   themeMode: AppThemes().init(),
  /// )
  ///
  /// This [Function] works to initialize what theme is used.
  ThemeMode init() {
    final box = GetStorage();
    String? tm = box.read(_sThemeModeKey);
    if (tm == null) {
      box.write(_sThemeModeKey, _sThemeModeLight);
      return ThemeMode.light;
    } else if (tm == _sThemeModeLight) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  void changeThemeMode(ThemeMode themeMode) {
    final box = GetStorage();
    if (themeMode == ThemeMode.dark) {
      box.write(_sThemeModeKey, _sThemeModeDark);
    } else {
      box.write(_sThemeModeKey, _sThemeModeLight);
    }
    Get.changeThemeMode(themeMode);
    Get.rootController.themeMode.reactive;
  }

  ///
  /// [ThemeData] general.
  ///
  /// [Example] :
  ///
  /// Text("Hello, world",
  ///   style: AppThemes().general().textTheme.bodyText1,
  /// )
  ///
  /// This [Function] is useful for styling widgets.
  ///
  /// [Function] AppThemes().general().*
  /// has several derivative functions.
  ThemeData general() {
    final box = GetStorage();
    String tm = box.read(_sThemeModeKey);
    if (tm == _sThemeModeLight) {
      return _lightTheme;
    }
    return _darkTheme;
  }
}
