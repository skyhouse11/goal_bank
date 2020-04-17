import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/providers/focus_node_provider.dart';
import 'package:goal_bank/providers/language_provider.dart';

class DynamicInputField extends StatefulWidget {
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final double minHeight;
  final AppString hintText;
  final Function callback;

  final EdgeInsets margin;
  final EdgeInsets padding;

  DynamicInputField({
    this.hintText,
    this.minHeight = 48,
    this.margin = const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
    this.padding = const EdgeInsets.only(left: 16.0, right: 16.0, top: 2.0, bottom: 2.0),
    this.textCapitalization = TextCapitalization.sentences,
    this.controller,
    this.callback,
  });

  @override
  _DynamicInputFieldState createState() => _DynamicInputFieldState();
}

class _DynamicInputFieldState extends State<DynamicInputField> {
  FocusNode _focusNode = FocusNode();
  FocusNodeProvider focusNodeProvider;
  String hintTextString = '';

  //-------Size Params-----
  double titleBoxHeight = 50;

  //------Other Paprams----
  int formLinesCount = 1;
  int counter;

  @override
  void initState() {
    super.initState();

    hintTextString = Provider.of<LanguageProvider>(context, listen: false).getCurrentStringValue(widget.hintText);

    countOfSplits(hintTextString);

    titleBoxHeight = widget.minHeight + (hintTextString.length / 40) * 15.5 + counter * 15.5;

    formLinesCount = 1;
    counter = 0;
  }

  void countOfSplits(String value) {
    setState(() {
      counter = 0;
    });
    for (int i = 0; i < value.length; i++) {
      if (value[i] == '\n') {
        setState(() {
          counter++;
        });
      }
    }
  }

  void dispose() {
    super.dispose();
    focusNodeProvider.removeListener(_listener);
  }

  void _listener() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    focusNodeProvider = Provider.of<FocusNodeProvider>(context)
      ..addListener(_listener);

    BoxDecoration decoration = BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );

    return Container(
      margin: widget.margin,
      height: titleBoxHeight,
      padding: widget.padding,
      decoration: decoration,
      child: TextField(
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.39,
        ),
        focusNode: _focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintTextString,
        ),
        textCapitalization: widget.textCapitalization,
        expands: true,
        minLines: null,
        maxLines: null,
        onChanged: (String value) {
          if ((value.length % 40 == 0 || (value.length / 35) > 1) ||
              value.endsWith('\n')) {
            setState(() {
              countOfSplits(value);
              titleBoxHeight = widget.minHeight +
                  (value.length / 40) * 15.5 +
                  counter * 15.5;
            });
            widget.callback(value);
          }
        },
      ),
    );
  }
}
