import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/providers/language_provider.dart';

class CustomDatePicker extends StatefulWidget {
  final EdgeInsets padding;
  final double height;
  final double width;
  DateTime dateTime;
  final Function callback;

  CustomDatePicker({
    this.padding,
    this.height = 40,
    this.width = 180,
    this.dateTime,
    this.callback,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration = BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ],
    );

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.amber,
      ),
      child: InkWell(
        onTap: () async {
          await showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height  * 0.33,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now().add(Duration(days: 1)),
                  minimumDate: DateTime.now(),
                  maximumDate: DateTime.utc(2100),
                  onDateTimeChanged: (DateTime pickedTime) {
                    setState(() {
                      widget.dateTime = pickedTime;
                      widget.callback(pickedTime);
                    });
                  },
                ),
              );
            },
          );
        },
        child: Container(
          padding: widget.padding,
          height: widget.height,
          width: widget.width,
          decoration: decoration,
          child: Center(
            child: Text(
              widget.dateTime == null
                  ? Provider.of<LanguageProvider>(context).getCurrentStringValue(AppString.CREATE_GOAL_PAGE_CURRENT_DATE_HINT)
                  : '${widget.dateTime.day} / ${widget.dateTime.month} / ${widget.dateTime.year}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.dateTime != null ? Colors.black : Colors.black54,
                height: 1.3,
                fontWeight: FontWeight.normal,
                letterSpacing: -0.37,
                fontSize: 16,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
