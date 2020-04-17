import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/providers/theme_provider.dart';

import 'package:goal_bank/widgets/custom_button.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:goal_bank/widgets/pop_up/popup_background_layout.dart';

class CongratulationsPopup extends StatefulWidget {
  @override
  _CongratulationsPopupState createState() => _CongratulationsPopupState();
}

class _CongratulationsPopupState extends State<CongratulationsPopup> {
  ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: Duration(seconds: 5))..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _controller,
      numberOfParticles: 10,
      blastDirection: 0.6,
      emissionFrequency: 0.05,
      displayTarget: true,
      child: PopupBackgroundLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: CustomTextSelector(
                      name: AppString.CONGRATULATIONS_POP_UP_TITLE,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.165,
                        shadows: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(
                      bottom: 8,
                      top: 8,
                    ),
                  ),
                  Container(
                    child: CustomTextSelector(
                      name: AppString.CONGRATULATIONS_POP_UP_CONTENT,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 0.165,
                        shadows: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 8,
                      top: 4,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/congrads.svg',
                      height: 80,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    child: CustomButton(
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      buttonColor: Provider.of<ThemeProvider>(context, listen: false).currentButtonColor,
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
      ),
    );
  }
}
