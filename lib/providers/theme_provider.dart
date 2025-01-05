import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier { 
  ThemeMode _themeMode = ThemeMode.system; // by default system
  String _themeStyle = 'Default'; // dynamic , default (optional)
  bool _pureBlackMode = false;

  // make functions to GET data
  ThemeMode get themeMode => _themeMode;
  String get themeStyle => _themeStyle;
  bool get pureBlackMode => _pureBlackMode;

  void setThemeMode(String theme) {
    switch (theme) {
      case 'Light':
        _themeMode = ThemeMode.light;
        break;
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'System':
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }

  void setThemeStyle(String style) {
    _themeStyle = style;
    notifyListeners();
  }

  void setPureBlackMode(bool value) {
    _pureBlackMode = value;
    notifyListeners();
  }

  String _selectedStyle = 'Default';
  bool _relativeTimestamps = true;

  String get selectedStyle => _selectedStyle;
  bool get relativeTimestamps => _relativeTimestamps;

  void setSelectedStyle(String style) {
    _selectedStyle = style;
    notifyListeners();
  }

  void setRelativeTimestamps(bool value) {
    _relativeTimestamps = value;
    notifyListeners();
  }
}
