import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/providers/language_provider.dart';
import 'package:goal_bank/providers/shared_preference_provider.dart';

import 'package:goal_bank/widgets/custom_button.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';

class DeleteGoalPopup extends StatelessWidget {
  final String id;
  Function callback;

  DeleteGoalPopup({this.id, this.callback});

  @override
  Widget build(BuildContext context) {
    return PopupBackgroundLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 16.0,
                    left: 32.0,
                    right: 32.0,
                    bottom: 8.0,
                  ),
                  child: Selector<LanguageProvider, String>(
                    builder: (content, language, child) {
                      List<String> _temp = language.split('*');

                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat',
                            height: 1.25,
                            letterSpacing: -0.17,
                            fontSize: 18,
                            color: Color.fromRGBO(55, 55, 55, 1),
                          ),
                          children: [
                            TextSpan(
                              text: _temp[0],
                            ),
                            TextSpan(
                              text: _temp[1],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    selector: (content, lang) {
                      return lang.getCurrentStringValue(AppString.DELETE_POP_UP_CONTENT);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 22.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomButton(
                        buttonColor: Colors.white,
                        height: 40,
                        padding: EdgeInsets.all(0),
                        shadows: [],
                        splashColor: Colors.black12,
                        child: Container(
                          width: 136,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: Alignment.center,
                          child: CustomTextSelector(
                            name: AppString.DELETE_POP_UP_CANCEL_BUTTON,
                            style: TextStyle(
                              color: Color.fromRGBO(55, 55, 55, 1),
                              fontSize: 14.0,
                              letterSpacing: -0.17,
                              height: 1.25,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CustomButton(
                        borderRadius: BorderRadius.circular(10.0),
                        height: 40,
                        child: Container(
                          width: 136,
                          alignment: Alignment.center,
                          child: CustomTextSelector(
                            name: AppString.DELETE_POP_UP_REMOVE_BUTTON,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              letterSpacing: -0.17,
                              height: 1.25,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        onPressed: () {
                          Provider.of<SharedPreferencesProvider>(context, listen: false).deleteFromList(id);

                          if (callback != null) callback();

                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopupBackgroundLayout extends StatelessWidget {
  final Widget child;

  PopupBackgroundLayout({this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(0, 0, 0, 0.4),
      child: child,
    );
  }
}
