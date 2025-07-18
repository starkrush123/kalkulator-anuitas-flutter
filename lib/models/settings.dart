import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ModeRumus { biasa, awalPeriode }
enum AppTheme { terang, gelap, ikutiSistem }

class SettingsProvider with ChangeNotifier {
  int _fontSize = 12;
  ModeRumus _modeRumus = ModeRumus.biasa;
  AppTheme _theme = AppTheme.ikutiSistem;

  int get fontSize => _fontSize;
  ModeRumus get modeRumus => _modeRumus;
  AppTheme get theme => _theme;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getInt('fontSize') ?? 12;
    _modeRumus = ModeRumus.values[prefs.getInt('modeRumus') ?? 0];
    _theme = AppTheme.values[prefs.getInt('theme') ?? 2];
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fontSize', _fontSize);
    await prefs.setInt('modeRumus', _modeRumus.index);
    await prefs.setInt('theme', _theme.index);
  }

  void setFontSize(int value) {
    _fontSize = value;
    _saveSettings();
    notifyListeners();
  }

  void setModeRumus(ModeRumus value) {
    _modeRumus = value;
    _saveSettings();
    notifyListeners();
  }

  void setTheme(AppTheme value) {
    _theme = value;
    _saveSettings();
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    switch (_theme) {
      case AppTheme.terang:
        return ThemeMode.light;
      case AppTheme.gelap:
        return ThemeMode.dark;
      case AppTheme.ikutiSistem:
        return ThemeMode.system;
    }
  }
}