// settings_controller.dart
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsController extends BaseController {
  final _isDarkMode = false.obs;
  final _isNotificationEnabled = true.obs;
  final _selectedLanguage = 'English'.obs;
  final _fontSize = 14.0.obs;

  bool get isDarkMode => _isDarkMode.value;
  bool get isNotificationEnabled => _isNotificationEnabled.value;
  String get selectedLanguage => _selectedLanguage.value;
  double get fontSize => _fontSize.value;

  final List<String> availableLanguages = ['English', 'Tiếng Việt', '日本語'];

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    _isNotificationEnabled.value = prefs.getBool('isNotificationEnabled') ?? true;
    _selectedLanguage.value = prefs.getString('selectedLanguage') ?? 'English';
    _fontSize.value = prefs.getDouble('fontSize') ?? 14.0;
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    // Implement theme change logic here
    Get.changeTheme(value ? ThemeData.dark() : ThemeData.light());
  }

  Future<void> toggleNotification(bool value) async {
    _isNotificationEnabled.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotificationEnabled', value);
    // Implement notification logic here
  }

  Future<void> changeLanguage(String language) async {
    _selectedLanguage.value = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
    // Implement language change logic here
    // You might want to use Get.updateLocale(locale) here
  }

  Future<void> changeFontSize(double size) async {
    _fontSize.value = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', size);
  }

  void resetSettings() async {
    toggleDarkMode(false);
    toggleNotification(true);
    changeLanguage('English');
    changeFontSize(14.0);
    Get.snackbar(
      'Reset Settings',
      'All settings have been reset to default values',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
