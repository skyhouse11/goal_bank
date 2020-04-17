import 'package:flutter/material.dart';
import 'package:goal_bank/providers/focus_node_provider.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/data/themes.dart';
import 'package:goal_bank/providers/theme_provider.dart';

class ThemeBackground extends StatelessWidget{
  final Widget child;
  ThemeProvider themeProvider;
  FocusNodeProvider focusNodeProvider;

  ThemeBackground({this.child});

  @override
  Widget build(BuildContext context) {
    themeProvider ??= Provider.of<ThemeProvider>(context);
    focusNodeProvider ??= Provider.of<FocusNodeProvider>(context);

    return Material(
      child: InkWell(
        onTap: () {
          focusNodeProvider.onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themeProvider?.currentPrimaryColor  ?? themes.lightPrimaryColor,
                themeProvider?.currentGradientColor ?? themes.lightGradientColor,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.1, 1.0],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
