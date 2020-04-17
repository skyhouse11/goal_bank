import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goal_bank/providers/language_provider.dart';

import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/widgets/text.dart';


class CustomTextSelector extends StatelessWidget {
  final AppString name;
  final String freeText;
  final TextStyle style;
  final TextAlign textAlign;
  final bool toOverflow;
  final int cutValue;

  const CustomTextSelector({
    Key key,
    this.name,
    this.style,
    this.textAlign,
    this.freeText = '',
    this.toOverflow = false,
    this.cutValue,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Selector<LanguageProvider, String>(builder: (ctx, val, _) {
      return CustomText(
        val + freeText ?? '',
        cutValue: cutValue,
        toOverflow: toOverflow,
        style: style,
        textAlign: textAlign == null ? null : TextAlign.center,
      );
    }, selector: (ctx, lang) {
      return lang.getCurrentStringValue(name);
    });
  }
}
