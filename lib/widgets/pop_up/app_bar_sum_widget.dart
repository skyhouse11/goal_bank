import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/models/app_class.dart';

import 'package:goal_bank/providers/shared_preference_provider.dart';
import 'package:goal_bank/providers/theme_provider.dart';

class AppBarSumWidget extends StatelessWidget {
  AppClass get appClass => GetIt.instance<AppClass>();

  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Selector<SharedPreferencesProvider, int>(
        builder: (context, value, _) {
          return Text(
            '$value ${appClass?.currentCurrency?.symbol}',
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Provider.of<ThemeProvider>(context, listen: false).currentTextColor,
            ),
          );
        },
        selector: (context, shared) {
          return shared.totalSum;
        },
      ),
    );
  }
}
