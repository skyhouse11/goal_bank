import 'package:flutter/material.dart';
import 'package:goal_bank/data/svg_icons_icons.dart';
import 'package:goal_bank/widgets/onboaridng_slider.dart';

class OnBoardingIcon extends StatelessWidget {
  final Color iconColor;

  OnBoardingIcon({this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        color: iconColor ?? Colors.white,
        iconSize: 24,
        icon: Icon(SvgIcons.onboardings),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => OnBoardingSlider(),
          );
        },
      ),
    );
  }
}
