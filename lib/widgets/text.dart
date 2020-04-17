import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String value;
  final int cutValue;
  final TextAlign textAlign;
  final bool toOverflow;
  final TextDirection textDirection;
  final TextStyle style;

  CustomText(
    this.value, {
    this.cutValue,
    this.textAlign,
    this.toOverflow = false,
    this.textDirection,
    this.style,
  });

  String buildText(String value) {
    if (cutValue != null && value.length >= cutValue) {
      value = value.substring(0, cutValue) + '...';
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      buildText(value),
      textAlign: textAlign,
      textDirection: textDirection ,
      style: style ?? TextStyle(
        height: 1.05,
      ),
      overflow: toOverflow ? TextOverflow.ellipsis : null,
    );
  }
}
