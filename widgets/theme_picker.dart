import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/models/app_class.dart';

import 'package:goal_bank/providers/theme_provider.dart';

import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:goal_bank/widgets/custom_button.dart';

class ThemePicker extends StatefulWidget {
  @override
  _ThemePickerState createState() => _ThemePickerState();
}

class _ThemePickerState extends State<ThemePicker> {
  ThemeProvider _themeProvider;

  AppClass get appClass => GetIt.instance<AppClass>();

  @override
  Widget build(BuildContext context) {
    _themeProvider ??= Provider.of<ThemeProvider>(context);

    return Row(
      children: <Widget>[
        CustomButton(
          padding: EdgeInsets.zero,
          buttonColor: appClass.currentTheme == 'light'
              ? _themeProvider.currentButtonColor
              : Color.fromRGBO(255, 255, 255, 0.8),
          child: Container(
            alignment: Alignment.center,
            width: 92,
            child: CustomTextSelector(
              name: AppString.SETTINGS_PAGE_THEME_LIGHT,
              style: TextStyle(
                color: appClass.currentTheme == 'light'
                    ? Colors.white
                    : Color.fromRGBO(55, 55, 55, 0.54),
                fontFamily: 'Montserrat',
                fontSize: 16.0,
                letterSpacing: -0.32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onPressed: () {
            appClass.currentTheme = 'light';
            setState(() {
              _themeProvider.updateTheme('light');
            });
          },
        ),
        SizedBox(
          width: 24,
        ),
        CustomButton(
          padding: EdgeInsets.zero,
          buttonColor: appClass.currentTheme == 'dark'
              ? _themeProvider.currentButtonColor
              : Color.fromRGBO(255, 255, 255, 0.8),
          child: Container(
            alignment: Alignment.center,
            width: 92,
            child: CustomTextSelector(
              name: AppString.SETTINGS_PAGE_THEME_DARK,
              style: TextStyle(
                color: appClass.currentTheme == 'dark'
                    ? Colors.white
                    : Color.fromRGBO(55, 55, 55, 0.54),
                fontFamily: 'Montserrat',
                fontSize: 16.0,
                letterSpacing: -0.32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onPressed: () {
            appClass.currentTheme = 'dark';
            setState(() {
              _themeProvider.updateTheme('dark');
            });
          },
        ),
      ],
    );
  }
}
