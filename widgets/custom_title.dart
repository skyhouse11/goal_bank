import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/providers/theme_provider.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';

class SettingsTitle extends StatelessWidget {
  final AppString appString;
  final EdgeInsets margin;

  SettingsTitle({@required this.appString, this.margin});

  Widget build(BuildContext context) {
    return Selector<ThemeProvider, Color>(builder: (context, value, _) {
      return Container(
        margin: margin,
        child: CustomTextSelector(
          name: appString,
          style: TextStyle(
            color: value,
            fontFamily: 'Ubuntu',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            fontSize: 14,
            letterSpacing: -0.17,
            height: 1.25,
          ),
        ),
      );
    }, selector: (ctx, theme) {
      return theme.currentSettingsTextColor;
    });
  }
}
