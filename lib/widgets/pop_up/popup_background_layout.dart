import 'package:flutter/material.dart';

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
