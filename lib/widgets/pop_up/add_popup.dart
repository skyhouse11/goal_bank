import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/providers/language_provider.dart';
import 'package:goal_bank/widgets/pop_up/congratulations_popup.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/models/app_class.dart';
import 'package:goal_bank/models/goal_class.dart';

import 'package:goal_bank/providers/shared_preference_provider.dart';

import 'package:goal_bank/widgets/custom_button.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:goal_bank/widgets/input_field.dart';
import 'package:goal_bank/widgets/pop_up/popup_background_layout.dart';

class AddDialog extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  static AppClass get appClass => GetIt.instance<AppClass>();

  final Goal goal;

  AddDialog(this.goal);

  void updateGoalSum(context) {
    Provider.of<SharedPreferencesProvider>(context, listen: false)
        .updateGoal(goal.id, int.parse(controller.text));
  }

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
                    left: 40.0,
                    right: 40.0,
                    bottom: 12.0,
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
                            color: Color.fromRGBO(55, 55, 55, 0.9),
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
                            TextSpan(
                              text: _temp[2],
                            ),
                            TextSpan(
                              text: goal.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    selector: (content, lang) {
                      return lang.getCurrentStringValue(AppString.ADD_POP_UP_CONTENT);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 12,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomTextSelector(
                        name: AppString.ADD_POP_UP_CURRENT_SUM,
                        freeText: ': ${goal.currentSum}${appClass.currentCurrency.symbol}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          height: 1.25,
                          letterSpacing: -0.17,
                        ),
                      ),
                      CustomTextSelector(
                        name: AppString.ADD_POP_UP_SUM_LEFT,
                        freeText: ': ${goal.neededSum - goal.currentSum}${appClass.currentCurrency.symbol}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(48, 132, 255, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          height: 1.25,
                          letterSpacing: -0.17,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomInputField(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  controller: controller,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1.25,
                    fontFamily: 'Montserrat',
                    letterSpacing: -0.17,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 14,
                    right: 14,
                    bottom: 22,
                    top: 22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomButton(
                        buttonColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shadows: [],
                        height: 40,
                        child: Container(
                          alignment: Alignment.center,
                          width: 136,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black),
                          ),
                          child: CustomTextSelector(
                            name: AppString.ADD_POP_UP_CANCEL_BUTTON,
                            style: TextStyle(
                              fontSize: 14.0,
                              letterSpacing: -0.17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CustomButton(
                        padding: EdgeInsets.zero,
                        height: 40,
                        child: Container(
                          alignment: Alignment.center,
                          width: 136,
                          child: CustomTextSelector(
                            name: AppString.ADD_POP_UP_ADD_BUTTON,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              letterSpacing: -0.17,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          updateGoalSum(context);
                          Navigator.of(context, rootNavigator: true).pop();
                          if ((goal.currentSum + int.parse(controller.text)) >= goal.neededSum) {
                            await showDialog(
                              context: context,
                              builder: (context) => CongratulationsPopup(),
                            );
                          }
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
