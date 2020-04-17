import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/pages/theme_container.dart';

import 'package:goal_bank/providers/language_provider.dart';
import 'package:goal_bank/providers/shared_preference_provider.dart';

import 'package:goal_bank/models/dto/language_dto.dart';
import 'package:goal_bank/models/dto/currency_dto.dart';

import 'package:goal_bank/widgets/appstring_dropdown.dart';
import 'package:goal_bank/widgets/custom_app_bar.dart';
import 'package:goal_bank/widgets/custom_title.dart';
import 'package:goal_bank/widgets/theme_picker.dart';

class SettingsPage extends StatefulWidget {
  ValueNotifier<bool> isOpenLanguage = ValueNotifier(false);
  ValueNotifier<bool> isOpenCurrency = ValueNotifier(false);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  LanguageProvider _languageProvider;
  SharedPreferencesProvider _sharedPreferencesProvider;

  List<Language> _tempListOfLang = [];
  List<Currency> _tempListOfCurrency = [];

  void _cleanedListOfLanguage() {
    _tempListOfLang.clear();
    for (Language element in _languageProvider.languageList) {
      _tempListOfLang.add(element);
    }
    _tempListOfLang.removeWhere((Language element) {
      return element.locale == _sharedPreferencesProvider.currentLang.locale;
    });
  }

  void _cleanedListOfCurrency() {
    _tempListOfCurrency.clear();
    for (Currency element in _sharedPreferencesProvider.currencyList) {
      _tempListOfCurrency.add(element);
    }
    _tempListOfCurrency.removeWhere((Currency element) {
      return element.id == _sharedPreferencesProvider.currentCurrency.id;
    });
  }


  Widget build(BuildContext context) {
    _languageProvider ??= Provider.of<LanguageProvider>(context, listen: false);
    _sharedPreferencesProvider ??= Provider.of<SharedPreferencesProvider>(context, listen: false);

    _cleanedListOfLanguage();
    _cleanedListOfCurrency();

    return ThemeBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          appString: AppString.SETTINGS_PAGE_TITLE,
          showSort: false,
          leadingWidget: Container(),
          forceCenter: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 51),
            SettingsTitle(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              appString: AppString.SETTINGS_PAGE_LANGUAGE_TITLE,
            ),
            Consumer<LanguageProvider>(
              builder: (context, value, child) {
                return CustomDropdown(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  initialValue: _languageProvider.selectedLanguage,
                  list: _tempListOfLang,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 36.0,
                  isOpenCurrency: widget.isOpenCurrency,
                  isOpenLanguage: widget.isOpenLanguage,
                  callBack: () {
                    setState(() {});
                  },
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            SettingsTitle(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              appString: AppString.SETTINGS_PAGE_CURRENCY,
            ),
            Consumer<LanguageProvider>(
              builder: (context, value, child) {
                return CustomDropdown(
                  width: MediaQuery.of(context).size.width,
                  initialValue: _sharedPreferencesProvider.currentCurrency,
                  list: _tempListOfCurrency,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 36.0,
                  isOpenCurrency: widget.isOpenCurrency,
                  isOpenLanguage: widget.isOpenLanguage,
                  callBack: () {
                    setState(() {});
                  },
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            SettingsTitle(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              appString: AppString.SETTINGS_PAGE_THEME_TITLE,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: ThemePicker(),
            ),
          ],
        ),
      ),
    );
  }
}
