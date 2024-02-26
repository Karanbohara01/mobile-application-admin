import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_admin/screens/about-screen.dart';
import 'package:mobile_admin/screens/language-screen.dart';
import 'package:mobile_admin/screens/theme-provider-screen.dart';
import 'package:provider/provider.dart';

import 'feedback-screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: [
              _buildListTile(
                title: 'Dark Mode',
                leading: Icons.dark_mode,
                trailing: Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ),
              Divider(),
              _buildListTile(
                title: 'App Version',
                leading: Icons.info,
                subtitle: '1.0.0',
                onTap: () {
                  // Show a dialog with more information about the app version
                },
              ),
              Divider(),
              _buildListTile(
                title: 'Feedback',
                leading: Icons.feedback,
                onTap: () {
                  Get.to(() => FeedbackScreen());
                  // Navigate to the feedback screen
                },
              ),
              Divider(),
              _buildListTile(
                title: 'About',
                leading: Icons.info_outline,
                onTap: () {
                  Get.to(() => AboutScreen());
                  // Navigate to the about screen
                },
              ),
              Divider(),
              _buildListTile(
                title: 'Logout',
                leading: Icons.logout,
                onTap: () {
                  // Implement logout functionality
                },
              ),
              Divider(),
              _buildListTile(
                title: 'Language',
                leading: Icons.language,
                onTap: () {
                  // Navigate to the language selection screen
                  Get.to(() => LanguageScreen());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    IconData? leading,
    Widget? trailing,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      leading: leading != null ? Icon(leading) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
