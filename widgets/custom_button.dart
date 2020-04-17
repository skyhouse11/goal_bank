import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/providers/theme_provider.dart';
import 'package:goal_bank/widgets/custom_inkwell.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';

class CustomButton extends StatelessWidget {
  final EdgeInsets margin;
  final Function onPressed;
  final BorderRadius borderRadius;
  final Color buttonColor;
  final Color splashColor;
  final Color highlightColor;
  final Widget child;
  final EdgeInsets padding;
  final AppString name;
  final Color textColor;
  final Border border;
  final List<BoxShadow> shadows;
  final double height;

  CustomButton({
    this.margin,
    this.onPressed,
    this.buttonColor,
    this.splashColor,
    this.highlightColor = const Color.fromRGBO(0, 0, 0, 0),
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.child,
    this.padding,
    this.name,
    this.textColor = const Color.fromRGBO(0, 0, 0, 1),
    this.border,
    this.shadows,
    this.height = 40.0,
  });

  ThemeProvider _themeProvider;

  Widget build(BuildContext context) {
    _themeProvider ??= Provider.of<ThemeProvider>(context, listen: false);

    Widget body = child != null
        ? child
        : Center(
            child: CustomTextSelector(
              name: name,
              style: TextStyle(
                color: textColor,
                fontSize: 14.0,
                letterSpacing: -0.17,
              ),
            ),
          );

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: buttonColor ?? _themeProvider.currentButtonColor,
        borderRadius: borderRadius,
        border: border,
        boxShadow: shadows ?? [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: CustomInkWell(
        highlightColor: highlightColor,
        splashColor: splashColor ?? Colors.lightBlue,
        splashFactory: InkSplash.splashFactory,
        borderRadius: borderRadius,
        onTap: onPressed,
        child: Container(padding: padding, height: height, child: body),
      ),
    );
  }
}
