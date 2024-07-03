import 'package:flutter/material.dart';
import 'package:clean_cycle/Themes/dark_mode.dart';
import 'package:clean_cycle/Themes/light_mode.dart';
// Would help in switching colors from dark to light mode or vice versa

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  //check if it is in dark mode
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  //create the setter for the theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    //function to toggle theme
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
