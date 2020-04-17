import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget{
  final Widget child;
  final Function onTap;
  final Color splashColor;
  final Color highlightColor;
  final bool excludeFromSemantics;
  final bool enableFeedback;
  final BorderRadius borderRadius;
  final InteractiveInkFeatureFactory splashFactory;


  CustomInkWell({
    this.child,
    this.onTap,
    this.highlightColor = const Color.fromRGBO(254, 203, 51, 0.1),
    this.splashColor = const Color.fromRGBO(254, 203, 51, 0.2),
    this.enableFeedback,
    this.excludeFromSemantics,
    this.borderRadius,
    this.splashFactory = InkRipple.splashFactory
  });


  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: splashFactory,
          splashColor: splashColor,
          highlightColor: highlightColor,
          excludeFromSemantics: true,
          enableFeedback: true,
          borderRadius: borderRadius,
          onTap: onTap,
          child: child,
        )
    );
  }
}
