import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeProvider({required ThemeMode themeMode}) {
    _themeMode = themeMode;
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
