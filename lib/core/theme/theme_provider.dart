import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.system;
  }

  static const String _themeKey = 'app_theme_mode';

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    
    if (savedTheme != null) {
      if (savedTheme == 'light') {
        state = ThemeMode.light;
      } else if (savedTheme == 'dark') {
        state = ThemeMode.dark;
      } else {
        state = ThemeMode.system;
      }
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    if (mode == ThemeMode.light) {
      await prefs.setString(_themeKey, 'light');
    } else if (mode == ThemeMode.dark) {
      await prefs.setString(_themeKey, 'dark');
    } else {
      await prefs.setString(_themeKey, 'system');
    }
  }

  Future<void> toggleTheme(BuildContext context) async {
    if (state == ThemeMode.system) {
      // If system is currently dark, toggle to light, and vice versa.
      final brightness = MediaQuery.platformBrightnessOf(context);
      if (brightness == Brightness.dark) {
        await setTheme(ThemeMode.light);
      } else {
        await setTheme(ThemeMode.dark);
      }
    } else if (state == ThemeMode.dark) {
      await setTheme(ThemeMode.light);
    } else {
      await setTheme(ThemeMode.dark);
    }
  }
}

final themeProvider = NotifierProvider<ThemeProvider, ThemeMode>(() {
  return ThemeProvider();
});
