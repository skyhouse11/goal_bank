import 'package:flutter/material.dart';

class CheckboxItem extends StatelessWidget {
  final bool currentStatus;

  CheckboxItem(this.currentStatus);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        left: 5.0,
        right: 5.0,
        top: 10.0,
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.24),
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            offset: Offset(0, 0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: currentStatus ? Center(
        child: Icon(Icons.check),
      ) : Container(),
    );
  }
}
