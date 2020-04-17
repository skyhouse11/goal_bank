import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/providers/focus_node_provider.dart';
import 'package:goal_bank/providers/language_provider.dart';

class CustomInputField extends StatefulWidget {
  final Function callback;
  final double width;
  final double height;
  final AppString hintText;
  final TextCapitalization textCapitalization;
  final EdgeInsets margin;
  final EdgeInsets padding;

  final TextEditingController controller;

  final bool maxLines;
  final TextStyle textStyle;
  final TextInputType keyboardType;
  final TextDirection textDirection;
  final BoxDecoration decoration;
  final TextAlign textAlign;

  CustomInputField({
    this.callback,
    this.hintText,
    this.maxLines = false,
    this.textDirection,
    this.textStyle,
    this.controller,
    this.padding = const EdgeInsets.only(left: 16.0, right: 16.0),
    this.margin =
        const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0, bottom: 4.0),
    this.width = 200,
    this.height = 40,
    this.textCapitalization = TextCapitalization.words,
    this.keyboardType = TextInputType.text,
    this.decoration,
    this.textAlign,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomInputFieldState();
  }
}

class _CustomInputFieldState extends State<CustomInputField> {
  FocusNode _focusNode = FocusNode();

  FocusNodeProvider focusProvider;

  void dispose() {
    super.dispose();
    focusProvider.removeListener(_unfocusListener);
  }

  void _unfocusListener() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    focusProvider = Provider.of<FocusNodeProvider>(context)
      ..addListener(_unfocusListener);

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

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        margin: widget.margin,
        padding: widget.padding,
        height: widget.height,
        width: widget.width,
        decoration: widget.decoration ?? decoration,
        child: Selector<LanguageProvider, String>(
          builder: (ctx, val, _) {
            return Center(
              child: TextField(
                textCapitalization: widget.textCapitalization,
                textAlign: widget.textAlign ?? TextAlign.start,
                style: widget.textStyle ?? null,
                focusNode: _focusNode,
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                maxLines: widget.maxLines ? 5 : 1,
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: val ?? '',
                  enabled: true,
                ),
                onChanged: (String value) {
                  widget.callback(value);
                },
              ),
            );
          },
          selector: (ctx, lang) {
            return lang.getCurrentStringValue(widget.hintText);
          },
        ),
      ),
    );
  }
}
