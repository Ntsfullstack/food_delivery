import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/base_controller.dart';
import 'package:food_delivery_app/models/profile/profile.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends BaseController {
  // Profile reference
  final profile = Rxn<Profile>();  // Thay đổi thành Rxn<Profile>


  // Observable properties
  final _isDarkMode = false.obs;
  final _isNotificationEnabled = true.obs;
  final _isPromoNotificationEnabled = true.obs;
  final _selectedLanguage = 'Tiếng Việt'.obs;
  final _fontSize = 14.0.obs;

  // Getters
  bool get isDarkMode => _isDarkMode.value;
  bool get isNotificationEnabled => _isNotificationEnabled.value;
  bool get isPromoNotificationEnabled => _isPromoNotificationEnabled.value;
  String get selectedLanguage => _selectedLanguage.value;
  double get fontSize => _fontSize.value;

  // Available languages
  final List<String> availableLanguages = [
    'Tiếng Việt',
    'English',
    '日本語',
  ];

  @override
  void onInit() {
    super.onInit();
    loadProfile();
    loadSettings();
  }

  // Load saved settings from SharedPreferences
  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load dark mode setting
      _isDarkMode.value = prefs.getBool('isDarkMode') ?? false;

      // Load notification settings
      _isNotificationEnabled.value =
          prefs.getBool('isNotificationEnabled') ?? true;
      _isPromoNotificationEnabled.value =
          prefs.getBool('isPromoNotificationEnabled') ?? true;

      // Load language setting
      _selectedLanguage.value =
          prefs.getString('selectedLanguage') ?? 'Tiếng Việt';

      // Load font size setting
      _fontSize.value = prefs.getDouble('fontSize') ?? 14.0;

      // Apply the loaded settings
      _applyThemeMode();
      _applyFontSize();
      _applyLanguage();
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  // Toggle dark mode
  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    _applyThemeMode();

    // Show feedback to user
    Get.snackbar(
      'Chế độ tối',
      value ? 'Đã bật chế độ tối' : 'Đã tắt chế độ tối',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.white,
      colorText: Get.isDarkMode ? Colors.white : Colors.black,
      duration: const Duration(seconds: 2),
    );
  }

  // Apply theme mode based on settings
  void _applyThemeMode() {
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Toggle notifications
  Future<void> toggleNotification(bool value) async {
    _isNotificationEnabled.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotificationEnabled', value);

    // If main notifications are turned off, also disable promo notifications
    if (!value && _isPromoNotificationEnabled.value) {
      await togglePromoNotification(false);
    }
  }

  // Toggle promo notifications
  Future<void> togglePromoNotification(bool value) async {
    // Only allow promo notifications if main notifications are enabled
    if (value && !_isNotificationEnabled.value) {
      Get.snackbar(
        'Thông báo',
        'Bạn cần bật thông báo chính trước',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isPromoNotificationEnabled.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPromoNotificationEnabled', value);
  }

  // Change language
  Future<void> changeLanguage(String language) async {
    _selectedLanguage.value = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);

    _applyLanguage();

    // Show feedback to user
    Get.snackbar(
      'Ngôn ngữ',
      'Đã chuyển ngôn ngữ sang $language',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Apply language changes
  void _applyLanguage() {
    Locale locale;
    switch (_selectedLanguage.value) {
      case 'English':
        locale = const Locale('en', 'US');
        break;
      case 'Tiếng Việt':
        locale = const Locale('vi', 'VN');
        break;
      case '日本語':
        locale = const Locale('ja', 'JP');
        break;
      default:
        locale = const Locale('vi', 'VN');
    }
    Get.updateLocale(locale);
  }

  // Change font size
  Future<void> changeFontSize(double size) async {
    _fontSize.value = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', size);

    _applyFontSize();
  }

  // Apply font size changes
  void _applyFontSize() {
    // This would typically update a global font size setting
    // For simplicity, we're just saving the value, but in a real app
    // you would apply this to your MaterialApp's theme
  }
  Future<void> loadProfile() async {
    try {
      final response = await authRepositories.getProfile();
      profile.value = response;
    } catch (e) {
      // Sử dụng addPostFrameCallback để hiển thị lỗi sau khi build hoàn tất
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showError(message: 'Không thể tải thông tin: ${e.toString()}');
      });
    }
  }

  // Reset all settings to defaults
  Future<void> resetSettings() async {
    // Show confirmation dialog
    final shouldReset = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Xác nhận đặt lại'),
        content:
            Text('Bạn có chắc chắn muốn đặt lại tất cả cài đặt về mặc định?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('Đặt lại'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );

    if (shouldReset != true) return;

    // Reset all settings to defaults
    await toggleDarkMode(false);
    await toggleNotification(true);
    await togglePromoNotification(true);
    await changeLanguage('Tiếng Việt');
    await changeFontSize(14.0);

    // Notify the user
    Get.snackbar(
      'Đặt lại cài đặt',
      'Tất cả cài đặt đã được đặt về giá trị mặc định',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Logout function
  // Logout function với Dialog tùy chỉnh đẹp hơn
  Future<void> logout() async {
    // Không hiển thị Alert Dialog mà sử dụng Dialog tùy chỉnh
    final shouldLogout = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout_rounded,
                color: Colors.red[400],
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Đăng xuất',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF303030),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(result: false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Hủy',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(result: true),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.red[500],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Đăng xuất',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (shouldLogout != true) return;

    // Hiển thị loading
    showLoading(message: 'Đang đăng xuất...');

    try {
      // Gọi API logout
      await authRepositories.logout();

      // Xóa dữ liệu người dùng
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
      await prefs.remove('userId');
      await prefs.remove('userEmail');
      await prefs.remove('userName');
      await prefs.remove('fullName');
      await prefs.remove('userRole');

      hideLoading();

      // Chuyển đến màn hình đăng nhập
      Get.offAllNamed('/login');
    } catch (e) {
      hideLoading();
      showError(message: 'Không thể đăng xuất: ${e.toString()}');
    }
  }

  // View user profile
  void viewProfile() {
    Get.toNamed(RouterName.profile, arguments: {
      'profile': profile.value
    });
  }
  // View addresses
  void viewAddresses() {
    Get.toNamed('/addresses');
  }

  // View payment methods
  void viewPaymentMethods() {
    Get.toNamed('/payment-methods');
  }

  // Help center
  void openHelpCenter() {
    Get.toNamed('/help-center');
  }

  // Terms of service
  void openTermsOfService() {
    Get.toNamed('/terms');
  }

  // Privacy policy
  void openPrivacyPolicy() {
    Get.toNamed('/privacy');
  }
}
