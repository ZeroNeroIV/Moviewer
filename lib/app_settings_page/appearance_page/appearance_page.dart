import 'package:flutter/material.dart';
import 'package:moviewer/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'appearance_helpers.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Appearance'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Theme',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  buildThemeButton(
                      'System', Icons.settings_brightness, themeProvider),
                  buildThemeButton('Light', Icons.light_mode, themeProvider),
                  buildThemeButton('Dark', Icons.dark_mode, themeProvider),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 160,
                child: Row(
                  children: [
                    buildThemeCard('Default', themeProvider),
                    buildThemeCard('Dynamic', themeProvider),
                    buildThemeCard('CloudNine', themeProvider),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              buildSwitchTile(
                'Pure black dark mode',
                themeProvider.pureBlackMode,
                (value) => themeProvider.setPureBlackMode(value),
              ),
              const SizedBox(height: 24),
              // ...['App language', 'Start Screen'].map(buildSettingsTile),
              // buildSwitchTile(
              //   'Relative timestamps',
              //   themeProvider.relativeTimestamps,
              //   (value) => themeProvider.setRelativeTimestamps(value),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
