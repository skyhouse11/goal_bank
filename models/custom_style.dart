import 'package:flutter/material.dart';

import 'package:goal_bank/enums/direction_type.dart';
import 'package:goal_bank/providers/language_provider.dart';

class CustomStyle extends ChangeNotifier{
  LanguageProvider _languageProvider;
  DirectionType directionType;


  init(LanguageProvider provider) {
    _languageProvider = provider;
    notifyListeners();

  }
  // Edge Insets
  EdgeInsets buildEdge({
    double top = 0,
    double right = 0,
    double bottom = 0,
    double left = 0,
  }) {
    return EdgeInsets.only(
      top     : top,
      right   :  _languageProvider != null ? _languageProvider.direction == DirectionType.RTL ? left : right : right,
      bottom  : bottom,
      left    : left,
    );
  }

  // Alignment

  Alignment getRTLAlignment(Alignment alignment) {

    if (alignment == Alignment.bottomLeft) {
      return Alignment.bottomRight;
    }
    if (alignment == Alignment.bottomRight) {
      return Alignment.bottomLeft;
    }

    if (alignment == Alignment.topLeft) {
      return Alignment.topRight;
    }
    if (alignment == Alignment.topRight) {
      return Alignment.topLeft;
    }

    if (alignment == Alignment.centerLeft) {
      return Alignment.centerRight;
    }
    if (alignment == Alignment.centerRight) {
      return Alignment.centerLeft;
    }

    return alignment;
  }

  Alignment buildAlignment(
      Alignment alignment
      ) {
    return _languageProvider != null ?
      _languageProvider.direction == DirectionType.LTR
        ? alignment
        : getRTLAlignment(alignment)
    :alignment;
  }
}

//