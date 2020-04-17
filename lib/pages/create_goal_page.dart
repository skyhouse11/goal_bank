import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/enums/status_enum.dart';

import 'package:goal_bank/models/app_class.dart';
import 'package:goal_bank/models/goal_class.dart';

import 'package:goal_bank/pages/theme_container.dart';

import 'package:goal_bank/providers/focus_node_provider.dart';
import 'package:goal_bank/providers/shared_preference_provider.dart';
import 'package:goal_bank/providers/theme_provider.dart';

import 'package:goal_bank/widgets/custom_app_bar.dart';
import 'package:goal_bank/widgets/custom_button.dart';
import 'package:goal_bank/widgets/custom_date_picker.dart';
import 'package:goal_bank/widgets/custom_title.dart';
import 'package:goal_bank/widgets/image_picker.dart';
import 'package:goal_bank/widgets/input_field.dart';
import 'package:goal_bank/widgets/pop_up/error_popup.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';

class CreateGoalPage extends StatefulWidget {
  @override
  _CreateGoalPageState createState() => _CreateGoalPageState();
}

class _CreateGoalPageState extends State<CreateGoalPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _goalController = TextEditingController();
  TextEditingController _currentSumController = TextEditingController();
  File image;

  DateTime date;
  SharedPreferencesProvider _sharedPreferencesProvider;
  ThemeProvider _themeProvider;
  FocusNodeProvider _focus;
  AppClass appClass = GetIt.instance<AppClass>();

  bool validate() {
    bool _valid = true;
    List<AppString> _listOfErrors = [];

    if (_nameController.text.isEmpty) {
      _listOfErrors.add(AppString.ERROR_GOAL_NAME_IS_EMPTY);
      _valid = false;
    }

    if (image == null) {
      _listOfErrors.add(AppString.ERROR_GOAL_IMAGE_IS_EMPTY);
      _valid = false;
    }

    if (_goalController.text.isEmpty) {
      _listOfErrors.add(AppString.ERROR_GOAL_SUM_IS_EMPTY);
      _valid = false;
    }

//    if (_currentSumController.text.isEmpty) {
//      _listOfErrors.add(AppString.ERROR_GOAL_CURRENT_SUM_IS_EMPTY);
//      _valid = false;
//    }

    if (_currentSumController.text.isNotEmpty &&
        _goalController.text.isNotEmpty) {
      if (int.parse(_currentSumController.text) >
          int.parse(_goalController.text)) {
        _listOfErrors.add(AppString.ERROR_GOAL_CURRENT_SUM_BIGGER_THAN_GOAL);
        _valid = false;
      }
    }

//    if (date == null) {
//      _listOfErrors.add(AppString.ERROR_GOAL_DATE_IS_EMPTY);
//      _valid = false;
//    }

    if (!_valid) {
      showDialog(
        context: context,
        builder: (context) => ErrorPopup(listOfErrors: _listOfErrors),
      );
      return _valid;
    }

    return _valid;
  }

  void getInformation() {
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    Map<String, dynamic> _temp = {
      'id': Generator.getUniqueId(10),
      'name': _nameController.text,
      'photo': base64Image,
      'create_date': DateTime.now().toIso8601String(),
      'end_date': date?.toIso8601String() ?? null,
      'current_sum': (_currentSumController.text != null && _currentSumController.text.isNotEmpty) ? int.parse(_currentSumController.text) : 0,
      'needed_sum': int.parse(_goalController.text),
      'status': GoalStatus.ACTIVE.toString(),
      'symbol': appClass.currentCurrency.symbol,
    };

    _sharedPreferencesProvider.addNewGoal(Goal.fromJson(_temp));

    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    _focus ??= Provider.of<FocusNodeProvider>(context, listen: false);
    _sharedPreferencesProvider ??= Provider.of<SharedPreferencesProvider>(context, listen: false);
    _themeProvider ??= Provider.of<ThemeProvider>(context, listen: false);

    return ThemeBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          appString: AppString.CREATE_GOAL_PAGE_TITLE,
          showSort: false,
        ),
        body: ScrollConfiguration(
          behavior: CleanBehavior(),
          child: ListView(
            padding: EdgeInsets.zero,
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            shrinkWrap: true,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  SettingsTitle(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    appString: AppString.CREATE_GOAL_PAGE_TITLE,
                  ),
                  CustomInputField(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    controller: _nameController,
                    width: MediaQuery.of(context).size.width,
                    hintText: AppString.CREATE_GOAL_PAGE_NAME_HINT,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SettingsTitle(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    appString: AppString.CREATE_GOAL_PAGE_IMAGE_TITLE,
                  ),
                  ImagePickerWidget(
                    image: image,
                    callback: (File selectedImage) {
                      setState(() {
                        image = selectedImage;
                      });
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SettingsTitle(
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              appString: AppString.CREATE_GOAL_PAGE_AMOUNT_TITLE,
                            ),
                            CustomInputField(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              controller: _goalController,
                              textAlign: TextAlign.center,
                              width: (MediaQuery.of(context).size.width / 2) - 32,
                              keyboardType: TextInputType.number,
                              hintText: AppString.CREATE_GOAL_PAGE_AMOUNT_HINT,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SettingsTitle(
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              appString: AppString.CREATE_GOAL_PAGE_CURRENT_SUM_TITLE,
                            ),
                            CustomInputField(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              controller: _currentSumController,
                              textAlign: TextAlign.center,
                              width: (MediaQuery.of(context).size.width / 2) - 32,
                              keyboardType: TextInputType.number,
                              hintText: AppString.CREATE_GOAL_PAGE_CURRENT_SUM_HINT,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: SvgPicture.asset(
                            'assets/svg/date.svg',
                            color: _themeProvider.currentTextColor,
                            height: 16,
                          ),
                        ),
                        SettingsTitle(
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          appString: AppString.CREATE_GOAL_PAGE_CURRENT_DATE,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 10.0,
                      bottom: 4.0,
                    ),
                    child: CustomDatePicker(
                      width: (MediaQuery.of(context).size.width / 2) - 32,
                      dateTime: date,
                      height: 40,
                      callback: (DateTime value) {
                        setState(() {
                          date = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 46.0,
                  ),
                  CustomButton(
                    buttonColor: Provider.of<ThemeProvider>(context).currentButtonColor,
                    highlightColor: Color.fromRGBO(0, 0, 0, 0),
                    splashColor: Colors.lightBlue,
                    child: Container(
                      alignment: Alignment.center,
                      child: CustomTextSelector(
                        name: AppString.CREATE_GOAL_PAGE_BUTTON,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 72.0),
                    onPressed: () {
                      if (validate()) getInformation();
                    },
                  ),
                  SizedBox(
                    height: 77.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Generator {
  static const String symbolsArray =
      '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

  static String getUniqueId(int length) {
    String newId = '';
    for (int i = 0; i < length; i++) {
      int symbolsLength = symbolsArray.length;
      Random rand = new Random();
      int symbolIndex = rand.nextInt(symbolsLength);
      newId = newId + symbolsArray.substring(symbolIndex, symbolIndex + 1);
    }
    return newId;
  }
}

class CleanBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
