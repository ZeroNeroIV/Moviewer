import 'package:flutter/material.dart';
import 'package:moviewer/providers/theme_provider.dart';

Widget buildThemeButton(
    String text, IconData icon, ThemeProvider themeProvider) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () => themeProvider.setThemeMode(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildThemeCard(String title, ThemeProvider themeProvider) {
  // final isSelected = themeProvider.selectedStyle == title;

  return Expanded(
    child: GestureDetector(
      onTap: () => themeProvider.setSelectedStyle(title),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: const BoxDecoration(
                // color: Colors.grey,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildSettingsTile(String title) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {
      // Handle navigation
    },
  );
}

Widget buildSwitchTile(String title, bool value, Function(bool) onChanged) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title),
    trailing: Switch(
      value: value,
      onChanged: onChanged,
    ),
  );
}
