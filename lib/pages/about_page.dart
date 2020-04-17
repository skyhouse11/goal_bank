import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/pages/theme_container.dart';

import 'package:goal_bank/providers/focus_node_provider.dart';
import 'package:goal_bank/providers/theme_provider.dart';

import 'package:goal_bank/widgets/custom_app_bar.dart';
import 'package:goal_bank/widgets/custom_button.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:goal_bank/widgets/custom_title.dart';
import 'package:goal_bank/widgets/dynamic_form.dart';
import 'package:goal_bank/widgets/input_field.dart';
import 'package:goal_bank/widgets/pop_up/email_sent_popup.dart';
import 'package:goal_bank/widgets/pop_up/error_popup.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  ThemeProvider _themeProvider;

  void dataValidation() async {
    bool _valid = true;
    List<AppString> _listOfErrors = [];

    if (_emailController.value.text.isEmpty) {
      _listOfErrors.add(AppString.ERROR_EMAIL_IS_EMPTY);
      _valid = false;
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.value.text)) {
      _listOfErrors.add(AppString.ERROR_EMAIL_NOT_VALID);
      _valid = false;
    }

    if (_nameController.value.text.isEmpty) {
      _listOfErrors.add(AppString.ERROR_NAME_IS_EMPTY);
      _valid = false;
    } else if (_nameController.value.text.length < 3) {
      _listOfErrors.add(AppString.ERROR_NAME_TOO_SHORT);
      _valid = false;
    }

    if (_messageController.value.text.isEmpty) {
      _listOfErrors.add(AppString.ERROR_MESSAGE_IS_EMPTY);
      _valid = false;
    } else if (_messageController.value.text.length < 10) {
      _listOfErrors.add(AppString.ERROR_MESSAGE_TOO_SHORT);
      _valid = false;
    }

    if (!_valid) {
      await showDialog(
        context: context,
        builder: (context) => ErrorPopup(listOfErrors: _listOfErrors),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => EmailSentPopup(),
    );
    await sendEmail(_collectedData());
  }

  Map _collectedData() {
    Map<String, dynamic> _emailData = {
      "message_title": _messageController.value.text,
      "message_content": _messageController.value.text,
      "user_email": _emailController.value.text,
      "app_title": 'GoalBank',
      "user_id": 'asdasd',
      'user_fcm_token': 'user_fcm_token'
    };

    return _emailData;
  }

  Future<http.Response> sendEmail(Map emailData) async {
    http.Response response;
    String _url = 'https://us-central1-sendmessage-c73a6.cloudfunctions.net/sendMessage';

    await http.post(_url, body: {'data': jsonEncode(emailData)}).then((response) {
      print(response.body);
    });
    return response;
  }

  Widget build(BuildContext context) {
    _themeProvider ??= Provider.of<ThemeProvider>(context, listen: false);

    FocusNodeProvider focus = Provider.of<FocusNodeProvider>(context, listen: false);
    return ThemeBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          appString: AppString.ABOUT_PAGE_TITLE,
          showSort: false,
          leadingWidget: Container(),
          forceCenter: true,
        ),
        body: GestureDetector(
          onTap: () {
            focus.onTap();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 24),
                    height: 48,
                    child: Image.asset(
                      _themeProvider.currentBrightness == Brightness.dark ? 'assets/appvesto_logo.png' : 'assets/black_appvesto_logo.png',
                      excludeFromSemantics: true,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: CustomTextSelector(
                    name: AppString.ABOUT_PAGE_ABOUT_TEXT,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: _themeProvider.currentTextColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: CustomTextSelector(
                    name: AppString.ABOUT_PAGE_WRITE_US,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      color: _themeProvider.currentTextColor,
                    ),
                  ),
                ),
                SettingsTitle(
                  margin: EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 16.0,
                  ),
                  appString: AppString.ABOUT_PAGE_NAME_TITLE,
                ),
                CustomInputField(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  hintText: AppString.ABOUT_PAGE_NAME_HINT,
                ),
                SettingsTitle(
                  margin: EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 16.0,
                  ),
                  appString: AppString.ABOUT_PAGE_EMAIL_TITLE,
                ),
                CustomInputField(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppString.ABOUT_PAGE_EMAIL_HINT,
                ),
                SettingsTitle(
                  margin: EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 16.0,
                  ),
                  appString: AppString.ABOUT_PAGE_MESSAGE_TITLE,
                ),
                DynamicInputField(
                  margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                  controller: _messageController,
                  hintText: AppString.ABOUT_PAGE_MESSAGE_HINT,
                  minHeight: 120,
                  textCapitalization: TextCapitalization.sentences,
                ),
                CustomButton(
                  buttonColor: _themeProvider.currentButtonColor,
                  textColor: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 24.0,
                  ),
                  name: AppString.ABOUT_PAGE_BUTTON_HINT,
                  onPressed: () {
                    dataValidation();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
