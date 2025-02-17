
// settings_screen.dart
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/router_name.dart';
import 'package:food_delivery_app/ui/setting_screen/setting_controller.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cài đặt',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: controller.resetSettings,
          ),
        ],
      ),
      body: Obx(
            () => ListView(
          children: [
            const SizedBox(height: 16),


            _buildSection(
              'Display Settings',
              [
                _buildSwitchTile(
                  'Dark Mode',
                  'Enable dark theme',
                  controller.isDarkMode,
                  controller.toggleDarkMode,
                  Icons.dark_mode,
                ),
                _buildSliderTile(
                  'Font Size',
                  'Adjust text size',
                  controller.fontSize,
                  12.0,
                  20.0,
                  controller.changeFontSize,
                  Icons.format_size,
                ),
              ],
            ),
            _buildSection(
              'Notification Settings',
              [
                _buildSwitchTile(
                  'Notifications',
                  'Enable push notifications',
                  controller.isNotificationEnabled,
                  controller.toggleNotification,
                  Icons.notifications,
                ),
              ],
            ),
            _buildSection(
              'Language Settings',
              [
                _buildLanguageSelector(),
              ],
            ),
            _buildSection(
              'Account Information',
              [
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('View Profile'),
                  subtitle: const Text('View and edit your account details'),
                  onTap: () {
                    Get.toNamed(RouterName.profile);
                  },
                ),
              ],
            ),
            _buildSection(
              'About',
              [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('App Version'),
                  subtitle: const Text('1.0.0'),
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Privacy Policy'),
                  onTap: () {
                    // Navigate to privacy policy
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Terms of Service'),
                  onTap: () {
                    // Navigate to terms of service
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildSwitchTile(
      String title,
      String subtitle,
      bool value,
      Function(bool) onChanged,
      IconData icon,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSliderTile(
      String title,
      String subtitle,
      double value,
      double min,
      double max,
      Function(double) onChanged,
      IconData icon,
      ) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 8,
          label: value.toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildLanguageSelector() {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('Language'),
      subtitle: Text(controller.selectedLanguage),
      onTap: () {
        Get.bottomSheet(
          Container(
            color: Get.theme.scaffoldBackgroundColor,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.availableLanguages.length,
              itemBuilder: (context, index) {
                final language = controller.availableLanguages[index];
                return ListTile(
                  title: Text(language),
                  trailing: language == controller.selectedLanguage
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    controller.changeLanguage(language);
                    Get.back();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

