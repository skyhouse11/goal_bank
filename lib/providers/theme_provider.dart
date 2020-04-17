import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:goal_bank/data/themes.dart';
import 'package:goal_bank/models/app_class.dart';

class ThemeProvider extends ChangeNotifier {
  static SharedPreferences _sharedPrefs;

  String currentTheme;

  Color currentPrimaryColor;
  Color currentGradientColor;
  Color currentBottomAppBarColor;
  Color currentButtonColor;
  Color currentTextColor;
  Color currentSettingsTextColor;

  Brightness currentBrightness;

  AppClass get appClass => GetIt.instance<AppClass>();

  void init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();

    if (!_sharedPrefs.containsKey('theme')) {
      currentPrimaryColor = themes.lightPrimaryColor;
      currentGradientColor = themes.lightGradientColor;
      currentBottomAppBarColor = themes.lightBottomAppBarColor;
      currentButtonColor = themes.lightButtonColor;
      currentTextColor = themes.lightTextColor;
      currentSettingsTextColor = themes.lightSettingsTextColor;
      currentBrightness = themes.light;
      currentTheme = 'light';
      appClass.currentTheme = 'light';

    } else if (_sharedPrefs.getString('theme') == 'light') {
      currentPrimaryColor = themes.lightPrimaryColor;
      currentGradientColor = themes.lightGradientColor;
      currentBottomAppBarColor = themes.lightBottomAppBarColor;
      currentButtonColor = themes.lightButtonColor;
      currentTextColor = themes.lightTextColor;
      currentSettingsTextColor = themes.lightSettingsTextColor;
      currentBrightness = themes.light;
      appClass.currentTheme = 'light';
      currentTheme = 'light';

    } else if (_sharedPrefs.getString('theme') == 'dark') {
      currentPrimaryColor = themes.darkPrimaryColor;
      currentGradientColor = themes.darkGradientColor;
      currentBottomAppBarColor = themes.darkBottomAppBarColor;
      currentButtonColor = themes.darkButtonColor;
      currentTextColor = themes.darkTextColor;
      currentSettingsTextColor = themes.darkSettingsTextColor;
      currentBrightness = themes.dark;
      appClass.currentTheme = 'dark';
      currentTheme = 'dark';

    }

    notifyListeners();
  }

  void updateTheme(String themeName) async {
    _sharedPrefs ??= await SharedPreferences.getInstance();

    if (themeName == 'light') {
      currentPrimaryColor = themes.lightPrimaryColor;
      currentGradientColor = themes.lightGradientColor;
      currentBottomAppBarColor = themes.lightBottomAppBarColor;
      currentButtonColor = themes.lightButtonColor;
      currentTextColor = themes.lightTextColor;
      currentBrightness = themes.light;
      currentSettingsTextColor = themes.lightSettingsTextColor;

    } else if (themeName == 'dark') {
      currentPrimaryColor = themes.darkPrimaryColor;
      currentGradientColor = themes.darkGradientColor;
      currentBottomAppBarColor = themes.darkBottomAppBarColor;
      currentButtonColor = themes.darkButtonColor;
      currentTextColor = themes.darkTextColor;
      currentBrightness = themes.dark;
      currentSettingsTextColor = themes.darkSettingsTextColor;

    }

    appClass.currentTheme = themeName;
    currentTheme = themeName;

    notifyListeners();

    await _sharedPrefs.setString('theme', themeName);
  }
}
