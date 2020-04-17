import 'package:flutter/material.dart';

class Themes {
  final Color darkPrimaryColor = Color.fromRGBO(54, 54, 54, 1);
  final Color darkGradientColor = Color.fromRGBO(120, 120, 120, 1);
  final Color darkBottomAppBarColor = Color.fromRGBO(54, 54, 54, 1);
  final Color darkButtonColor = Color.fromRGBO(48, 132, 255, 1);
  final Color darkTextColor = Color.fromRGBO(255, 255, 255, 1);
  final Color darkSettingsTextColor = Color.fromRGBO(255, 255, 255, 0.5);
  final Brightness dark = Brightness.dark;

  final Color lightPrimaryColor = Color.fromRGBO(208, 208, 208, 1);
  final Color lightGradientColor = Color.fromRGBO(255, 255, 255, 1);
  final Color lightButtonColor = Color.fromRGBO(48, 132, 255, 1);
  final Color lightBottomAppBarColor = Color.fromRGBO(255, 255, 255, 1);
  final Color lightTextColor = Color.fromRGBO(0, 0, 0, 1);
  final Color lightSettingsTextColor = Color.fromRGBO(0, 0, 0, 0.5);
  final Brightness light = Brightness.light;
}

Themes themes = Themes();
