import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/providers/theme_provider.dart';
import 'package:goal_bank/widgets/custom_button.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:goal_bank/widgets/pop_up/popup_background_layout.dart';
import 'package:provider/provider.dart';

class ErrorPopup extends StatelessWidget {
  final List<AppString> listOfErrors;

  ErrorPopup({this.listOfErrors});

  ThemeProvider _themeProvider;

  @override
  Widget build(BuildContext context) {
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return PopupBackgroundLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: listOfErrors.map((item) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 9),
                          width: 20,
                          height: 20,
                          child: Icon(
                            Icons.error_outline,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: CustomTextSelector(
                              name: item,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                height: 1.25,
                                letterSpacing: 0.165,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Container(
                  margin: EdgeInsets.only( top: 16),
                  child: CustomButton(
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: -0.17,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    buttonColor: _themeProvider.currentButtonColor,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
