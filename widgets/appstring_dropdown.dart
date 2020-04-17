import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'package:goal_bank/enums/app_string.dart';

import 'package:goal_bank/models/app_class.dart';
import 'package:goal_bank/models/dto/language_dto.dart';

import 'package:goal_bank/providers/focus_node_provider.dart';
import 'package:goal_bank/providers/language_provider.dart';
import 'package:goal_bank/providers/shared_preference_provider.dart';

import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:goal_bank/widgets/text.dart';

class CustomDropdown extends StatefulWidget {
  List list;
  var initialValue;
  final double width;
  final double height;
  final EdgeInsets margin;

  final Widget buttonChild;
  final Alignment alignment;
  final OverlayEntry overlayEntry;
  final LayerLink layerLink = LayerLink();
  final Function callBack;

   ValueNotifier<bool> isOpenLanguage;
   ValueNotifier<bool> isOpenCurrency;

  CustomDropdown({
    @required this.list,
    @required this.initialValue,
    this.width = 300,
    this.height = 48,
    this.margin = const EdgeInsets.only(
      top: 20.0,
      left: 16,
      right: 16,
      bottom: 0,
    ),
    this.alignment,
    this.buttonChild,
    this.overlayEntry,
    this.callBack,
    this.isOpenCurrency,
    this.isOpenLanguage,
  });

  @override
  State createState() {
    return initialValue is Language
        ? _LanguageDropdownState()
        : _CurrencyDropdownState();
  }
}

class _LanguageDropdownState extends State<CustomDropdown> {
  bool isOpen = false;

  String currentName;

  double height;

  Color itemColor = Colors.white;
  OverlayEntry overlayEntry;

  FocusNodeProvider focusProvider;
  LanguageProvider languageProvider;

  AppClass get appClass => GetIt.instance<AppClass>();

  void initState() {
    super.initState();
    languageProvider ??= Provider.of<LanguageProvider>(context, listen: false);
    if (widget.initialValue.name is String) {
      currentName = widget.initialValue.name;
    } else if (widget.initialValue.name is AppString) {
      currentName = languageProvider.getCurrentStringValue(widget.initialValue.name);
    }
    height = widget.height;
  }

  void dispose() {
    _unfocusListener();
    super.dispose();
  }

  void _unfocusListener() {
    widget.isOpenLanguage.value = false;
    if (widget.callBack != null && mounted) {
      widget.callBack();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isOpen) {
        overlayEntry.remove();
        isOpen = false;
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    double listHeight = height * (widget.list != null ? widget.list.length : 0);
    if (widget.list.length > 4) {
      listHeight = height * 4;
    }
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: widget.layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            borderOnForeground: false,
            type: MaterialType.transparency,
            elevation: 1.0,
            child: Container(
              margin: EdgeInsets.only(
                left: widget?.margin?.left ?? 0.0,
                right: widget?.margin?.right ?? 0.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              height: listHeight,
              child: ListView.builder(
                physics: widget.list.length <= 3 ? NeverScrollableScrollPhysics() : null,
                padding: EdgeInsets.all(0.0),
                itemCount: widget.list != null ? widget.list.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: Color.fromRGBO(200, 200, 1, 1),
                    highlightColor: Color.fromRGBO(200, 200, 1, 1),
                    onTap: () => _setNewLanguageValue(index),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        border: (index + 1) == widget.list.length ? null : Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(237, 236, 236, 1),
                            width: 1.0,
                          ),
                        ),
                      ),
                      height: 36.0,
                      child: Container(
                        alignment:
                            Localizations.localeOf(context).languageCode == 'he'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: CustomText(
                          widget.list[index].name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setNewLanguageValue(index) async {
    setState(() {
      widget.initialValue = widget.list[index];

      if (widget.initialValue.name is String) {
        currentName = widget.initialValue.name;
      } else if (widget.initialValue.name is AppString) {
        currentName = languageProvider.getCurrentStringValue(widget.initialValue.name);
      }

      isOpen = !isOpen;
      widget.isOpenLanguage.value = false;
    });
    appClass.currentLanguage = widget.list[index];
    languageProvider.setNewLanguage(widget.list[index]);
    overlayEntry.remove();

    if (widget.callBack != null) {
      widget.callBack();
    }
  }

  void _action() {
    if (widget.isOpenCurrency.value) {
      widget.isOpenCurrency.value = false;
      if (widget.callBack != null) {
        widget.callBack();
      }
      focusProvider.onTap();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isOpen) {
        overlayEntry.remove();
      } else {
        this.overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this.overlayEntry);
      }
      setState(() {
        widget.isOpenLanguage.value = !widget.isOpenLanguage.value;
        isOpen = !isOpen;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      focusProvider ??= Provider.of<FocusNodeProvider>(context, listen: false)
        ..addListener(_unfocusListener);

    return CompositedTransformTarget(
      link: widget.layerLink,
      child: Container(
        margin: widget.margin,
        height: widget.height,
        width: widget.width,
        child: InkWell(
          onTap: _action,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.isOpenLanguage.value
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    )
                  : BorderRadius.all(
                      Radius.circular(10.0),
                    ),
              color: Colors.white,
            ),
            height: widget.height,
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: CustomText(
                      currentName,
                      style: TextStyle(
                        height: 1.25,
                        letterSpacing: -0.17,
                        color: widget.isOpenLanguage.value ? Color.fromRGBO(48, 132, 255, 1) : Color.fromRGBO(55, 55, 55, 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Icon(
                    widget.isOpenLanguage.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrencyDropdownState extends State<CustomDropdown> {
  bool isOpen = false;

  String currentName;

  double height;

  Color itemColor = Colors.white;
  OverlayEntry overlayEntry;

  FocusNodeProvider focusProvider;
  SharedPreferencesProvider _sharedPreferencesProvider;
  LanguageProvider _languageProvider;

  AppClass get appClass => GetIt.instance<AppClass>();

  void initState() {
    super.initState();
    _languageProvider ??= Provider.of<LanguageProvider>(context, listen: false);
    _sharedPreferencesProvider ??= Provider.of<SharedPreferencesProvider>(context, listen: false);

    if (widget.initialValue.name is String) {
      currentName = widget.initialValue.name + " " + widget.initialValue.symbol;
    } else if (widget.initialValue.name is AppString) {
      currentName = _languageProvider.getCurrentStringValue(widget.initialValue.name) + " " + widget.initialValue.symbol;
    }

    height = widget.height;
  }

  void dispose() {
    _unfocusListener();
    super.dispose();
  }

  void _unfocusListener() {
    widget.isOpenCurrency.value = false;
    if (widget.callBack != null && mounted) {
      widget.callBack();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isOpen) {
        overlayEntry.remove();
        isOpen = false;
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    double listHeight = height * (widget.list != null ? widget.list.length : 0);
    if (widget.list.length > 4) {
      listHeight = height * 4;
    }
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: widget.layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            borderOnForeground: false,
            type: MaterialType.transparency,
            elevation: 1.0,
            child: Container(
              margin: EdgeInsets.only(
                left: widget?.margin?.left ?? 0.0,
                right: widget?.margin?.right ?? 0.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              height: listHeight,
              child: ListView.builder(
                physics: widget.list.length <= 3 ? NeverScrollableScrollPhysics() : null,
                padding: EdgeInsets.all(0.0),
                itemCount: widget.list != null ? widget.list.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: Color.fromRGBO(200, 200, 1, 1),
                    highlightColor: Color.fromRGBO(200, 200, 1, 1),
                    onTap: () => _setNewCurrencyValue(index),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(237, 236, 236, 1),
                            width: 1.0,
                          ),
                        ),
                      ),
                      height: 36.0,
                      child: Container(
                        alignment:
                        Localizations.localeOf(context).languageCode == 'he'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: CustomTextSelector(
                          name: widget.list[index].name,
                          freeText: " " + widget.list[index].symbol,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setNewCurrencyValue(index) async {
    setState(() {
      widget.initialValue = widget.list[index];

      if (widget.initialValue.name is String) {
        currentName = widget.initialValue.name + " " + widget.initialValue.symbol;
      } else if (widget.initialValue.name is AppString) {
        currentName = _languageProvider.getCurrentStringValue(widget.initialValue.name) + " " + widget.initialValue.symbol;
      }

      isOpen = !isOpen;
      widget.isOpenCurrency.value = false;
    });
    appClass.currentCurrency = widget.list[index];
    _sharedPreferencesProvider.setCurrency(widget.list[index]);
    overlayEntry.remove();

    if (widget.callBack != null) {
      widget.callBack();
    }
  }

  void _action() {
    if (widget.isOpenLanguage.value) {
      widget.isOpenLanguage.value = false;
      if (widget.callBack != null) {
        widget.callBack();
      }
      focusProvider.onTap();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isOpen) {
        overlayEntry.remove();
      } else {
        this.overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this.overlayEntry);
      }
      setState(() {
        widget.isOpenCurrency.value = !widget.isOpenCurrency.value;
        isOpen = !isOpen;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      focusProvider ??= Provider.of<FocusNodeProvider>(context, listen: false)
        ..addListener(_unfocusListener);

    currentName = _languageProvider.getCurrentStringValue(widget.initialValue.name) + " " + widget.initialValue.symbol;

    return CompositedTransformTarget(
      link: widget.layerLink,
      child: Container(
        margin: widget.margin,
        height: widget.height,
        width: widget.width,
        child: InkWell(
          onTap: _action,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.isOpenCurrency.value
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    )
                  : BorderRadius.all(
                      Radius.circular(10.0),
                    ),
              color: Colors.white,
            ),
            height: widget.height,
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: CustomText(
                      currentName,
                      style: TextStyle(
                        height: 1.25,
                        letterSpacing: -0.17,
                        color: widget.isOpenCurrency.value ? Color.fromRGBO(48, 132, 255, 1) : Color.fromRGBO(55, 55, 55, 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Icon(
                    widget.isOpenCurrency.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
