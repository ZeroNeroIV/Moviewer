import 'package:flutter/material.dart';
import 'package:moviewer/app_settings_page/about_page/main.dart';
import 'package:moviewer/app_settings_page/appearance_page/appearance_page.dart';
import 'package:moviewer/app_settings_page/profile_settings_Page/page.dart';
import 'package:moviewer/app_settings_page/security_settings_page/page.dart';
import 'package:moviewer/app_settings_page/storage_settings_page/page.dart';
import 'package:moviewer/auth_system/login_page.dart';
import 'package:moviewer/providers/user_provider.dart';
import 'package:moviewer/reviews/my_reviews/user_reviews.dart';
import 'package:provider/provider.dart';

class AppSettingsScreen extends StatelessWidget {
  AppSettingsScreen({super.key});

  final Map<String, Widget> pages = {
    'Data and Storage': const StorageSettingsPage(),
    'Security': const SecuritySettingsScreen(),
    'User Profile': const ProfileSettingsPage(),
    'About': const AboutPage(),
    'Appearance': const AppearancePage(),
    'My Reviews': const Reviews()
  };

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // Add SingleChildScrollView here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SettingsButton(
                text: 'User Profile',
                onPressed: () => _navigateToPage(context, 'User Profile'),
              ),
              const SizedBox(height: 16),
              SettingsButton(
                text: 'My Reviews',
                onPressed: () => _navigateToPage(context, 'My Reviews'),
              ),
              const SizedBox(height: 16),
              SettingsButton(
                text: 'Data and Storage',
                onPressed: () => _navigateToPage(context, 'Data and Storage'),
              ),
              const SizedBox(height: 16),
              SettingsButton(
                text: 'Security',
                onPressed: () => _navigateToPage(context, 'Security'),
              ),
              const SizedBox(height: 16),
              SettingsButton(
                text: 'Appearance',
                onPressed: () => _navigateToPage(context, 'Appearance'),
              ),
              const SizedBox(height: 16),
              SettingsButton(
                text: 'About',
                onPressed: () => _navigateToPage(context, 'About'),
              ),
              const SizedBox(height: 16),
              SettingsButton(
                text: 'Log Out',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String pageKey) {
    if (pages.containsKey(pageKey)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pages[pageKey]!),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Page "$pageKey" not found')),
      );
    }
  }
}

class SettingsButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SettingsButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonBackground,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: AppStyles.buttonText,
      ),
    );
  }
}

// **************
class AppColors {
  static const Color background = Colors.black;
  static const Color buttonBackground = Color(0xFF636E72);
  static const Color textColor = Colors.white;
  static const grey = Color(0xFF636E72);
  static const purple = Color(0xFF6C5CE7);
  static const darkGrey = Color(0xFF2D3436);
  static const lightGrey = Color(0xFFC9C9C9);
}

class AppStyles {
  static const TextStyle buttonText = TextStyle(
    color: AppColors.textColor,
    fontSize: 16,
  );

  static const TextStyle appBarTitle = TextStyle(
    color: AppColors.textColor,
    fontSize: 20,
  );
}
