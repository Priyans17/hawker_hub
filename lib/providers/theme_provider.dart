import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hawker_app/utils/constants.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString(Constants.themeKey);
      if (themeModeString != null) {
        _themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.toString() == themeModeString,
          orElse: () => ThemeMode.system,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading theme mode: $e');
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.themeKey, mode.toString());
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  Future<void> toggleThemeMode() async {
    final newMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }
}

