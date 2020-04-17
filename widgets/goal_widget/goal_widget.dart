import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/data/svg_icons_icons.dart';

import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/enums/open_status_enum.dart';
import 'package:goal_bank/enums/status_enum.dart';

import 'package:goal_bank/models/app_class.dart';
import 'package:goal_bank/models/custom_style.dart';
import 'package:goal_bank/models/goal_class.dart';

import 'package:goal_bank/providers/theme_provider.dart';

import 'package:goal_bank/widgets/custom_inkwell.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:goal_bank/widgets/goal_widget/status_bar.dart';
import 'package:goal_bank/widgets/pop_up/add_popup.dart';
import 'package:goal_bank/widgets/pop_up/remove_goal_pop_up.dart';

class GoalWidget extends StatefulWidget {
  final Function callback;
  final int index;
  final int currentIndex;
  Goal goal;

  GoalWidget({
    this.callback,
    this.index,
    this.currentIndex,
    this.goal,
  });

  @override
  _GoalWidgetState createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  AppClass get appClass => GetIt.instance<AppClass>();

  CustomStyle customStyle;

  GoalAnimationStatus _animationStatus;
  GoalStatus goalStatus;
  double _height;
  double _buttonSize;

  Color _color = Colors.white;
  EdgeInsets _margin;
  List<BoxShadow> _shadows;

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(10);

//image block
  double _imageWidth;
  double _imageHeight;

//text block
  double _textWidth;
  double _textHeight;
  Alignment _textAlignment;

//status margin
  EdgeInsets _statusBarMargin;
  EdgeInsets _dateMargin;

// Date time
  double _dateHeight;
  BorderRadius _imageBorder;

// button block
  double _buttonOpacity;
  double _successIconHeight;
  Alignment _successAlignment = Alignment.center;

  setDefault() {
    setState(() {
      _margin = EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0);
      _dateHeight = 0.0;

      _height = 112.0;
      _buttonSize = 0.0;
      _imageWidth = 136.0;
      _imageHeight = 112.0;

      _shadows = [
        BoxShadow(
          blurRadius: 4,
          color: Color.fromRGBO(0, 0, 0, 0.2),
          offset: Offset(0.0, 4.0),
        ),
      ];

      _textHeight = _imageHeight;
      _textWidth = (MediaQuery.of(context).size.width - _imageWidth) - 16 * 2;
      _textAlignment = getAlignment(Alignment.centerRight);

      _statusBarMargin = EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0);
      _dateMargin = null;
      _imageBorder = getBorder(
        BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      );

      _buttonOpacity = 0.0;
      _successIconHeight = 50.0;

      _animationStatus = GoalAnimationStatus.CLOSED;
    });
  }

  getBorder(BorderRadius borderRadius) {
    Locale myLocale = Localizations.localeOf(context);
    Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);

    switch (myLocale.toString()) {
      case 'he':
        return BorderRadius.only(
          bottomLeft: borderRadius.bottomRight,
          topLeft: borderRadius.topRight,
          bottomRight: borderRadius.bottomLeft,
          topRight: borderRadius.topLeft,
        );
        break;
      case 'en':
        return borderRadius;
      case 'ru':
        return borderRadius;
      default:
        return borderRadius;
    }
  }

  getAlignment(Alignment alignment) {
    Locale myLocale = Localizations.localeOf(context);
    Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);

    switch (myLocale.toString()) {
      case 'he':
        if (alignment == Alignment.centerLeft) {
          return Alignment.centerRight;
        }
        if (alignment == Alignment.topLeft) {
          return Alignment.topRight;
        }
        if (alignment == Alignment.bottomLeft) {
          return Alignment.bottomRight;
        }

        if (alignment == Alignment.centerRight) {
          return Alignment.centerLeft;
        }
        if (alignment == Alignment.topRight) {
          return Alignment.topLeft;
        }
        if (alignment == Alignment.bottomRight) {
          return Alignment.bottomLeft;
        }
        break;
      case 'en':
        return alignment;
      case 'ru':
        return alignment;
      default:
        return alignment;
    }
  }

  //animation functions
  openCard() {
    setState(() {
      _height = 319.0;
      _imageWidth = MediaQuery.of(context).size.width;
      _imageHeight = 176.0;

      _textHeight = _height;
      _buttonSize = 48.0;
      _textWidth = MediaQuery.of(context).size.width - 16 * 2;
      _textAlignment = Alignment.bottomCenter;

      _statusBarMargin = EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0);
      _dateHeight = 16.0;
      _dateMargin = EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0);
      _imageBorder = getBorder(
        BorderRadius.only(
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      );
      _buttonOpacity = 1.0;
      _successIconHeight = 75.0;

      _animationStatus = GoalAnimationStatus.OPEN;
    });
  }

  closeCard() {
    setState(() {
      _dateHeight = 0.0;
      _buttonSize = 0.0;
      _height = 112.0;
      _imageWidth = 136.0;
      _imageHeight = 112.0;

      _textHeight = _imageHeight;
      _textWidth = (MediaQuery.of(context).size.width - _imageWidth) - 16 * 2;
      _textAlignment = getAlignment(Alignment.centerRight);

      _statusBarMargin = EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0);
      _dateMargin = null;

      _imageBorder = getBorder(
        BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      );

      _buttonOpacity = 0.0;
      _successIconHeight = 50.0;

      _animationStatus = GoalAnimationStatus.CLOSED;
    });
  }

  checkAnimationStatus() {
    if (_animationStatus == GoalAnimationStatus.OPEN) {
      closeCard();
      return;
    }

    if (_animationStatus == GoalAnimationStatus.CLOSED) {
      openCard();
      return;
    }
  }

//animations functions

//popups-
  void addDialog(context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AddDialog(widget.goal);
      },
    );
  }

  void deleteDialog(context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return DeleteGoalPopup(
          id: widget.goal.id,
        );
      },
    );
  }

//popups-

  Widget deleteButton(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      opacity: _buttonOpacity,
      child: Container(
        margin: EdgeInsets.only(
          top: 24,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: _animationStatus == GoalAnimationStatus.OPEN ? () {
            deleteDialog(context);
          } : null,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  right: 4,
                ),
                child: Icon(
                  SvgIcons.delete,
                  color: Colors.red,
                  size: 16,
                ),
              ),
              CustomTextSelector(
                name: AppString.DELETE_POP_UP_REMOVE_BUTTON,
                style: TextStyle(
                  shadows: _shadows,
                  color: Colors.white,
                  letterSpacing: -0.17,
                  height: 1.25,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_margin == null) setDefault();

    if (widget.currentIndex != widget.index) {
      _animationStatus = GoalAnimationStatus.CLOSED;
      closeCard();
    }

    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      margin: _margin,
      height: _height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: _borderRadius,
        boxShadow: _shadows,
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: () {
          checkAnimationStatus();
          widget.callback(widget.index);
        },
        child: Stack(
          children: <Widget>[
            AnimatedAlign(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              alignment: _textAlignment,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: _textWidth,
                height: _textHeight,
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      top: _animationStatus == GoalAnimationStatus.CLOSED ? 0 : _imageHeight - 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: AnimatedContainer(
                        alignment: getAlignment(Alignment.centerLeft),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 8.0,
                        ),
                        width: _animationStatus == GoalAnimationStatus.CLOSED ? _textWidth - 48 : _textWidth - 32 -_buttonSize,
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          text: TextSpan(
                            text: widget.goal.name,
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Color.fromRGBO(55, 55, 55, 1),
                              fontSize: 18,
                              height: 1.25,
                              letterSpacing: -0.17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment:
                      _animationStatus == GoalAnimationStatus.CLOSED
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 22,
                                    width: 22,
                                  ),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    opacity: _buttonOpacity,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 16.0,
                                        right: 16.0,
                                      ),
                                      child: Text(
                                        '${widget.goal.neededSum} ${widget.goal.symbol}',
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(55, 55, 55, 1),
                                          fontFamily: 'Ubuntu',
                                          fontSize: 14,
                                          height: 1.25,
                                          letterSpacing: -0.17,
                                        ),
                                      ),
                                    ),
                                  ),
                                  widget.goal.endDate != null ? AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    height: _dateHeight,
                                    margin: _dateMargin,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        AnimatedOpacity(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                          opacity: _buttonOpacity,
                                          child: Container(
                                            child: SvgPicture.asset(
                                              'assets/svg/date.svg',
                                              color: Color.fromRGBO(55, 55, 55, 0.5),
                                              height: 16,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 4, right: 4),
                                          child: CustomTextSelector(
                                            name: AppString.MAIN_PAGE_EXPERIENCE,
                                            freeText: ' ${widget.goal?.endDate?.day}.${widget.goal?.endDate?.month}.${widget.goal?.endDate?.year}',
                                            style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 12,
                                              color: Color.fromRGBO(55, 55, 55, 1),
                                              height: 1.25,
                                              letterSpacing: -0.17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) : AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    height: _dateHeight,
                                    margin: _dateMargin,
                                  ),
                                ],
                              ),
                            ),
                            widget.goal.status == GoalStatus.ACTIVE
                                ? AnimatedOpacity(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    opacity: _buttonOpacity,
                                    child: CustomInkWell(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        margin: EdgeInsets.only(
                                          right: 16.0,
                                          left: 16.0,
                                        ),
                                        width: _buttonSize,
                                        height: _buttonSize,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(0, 25, 64, 0.25),
                                              blurRadius: 5,
                                              offset: Offset(0.0, 5.0),
                                            ),
                                          ],
                                          color: Provider.of<ThemeProvider>(context).currentButtonColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/icon.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                      ),
                                      onTap: _animationStatus == GoalAnimationStatus.CLOSED ? null
                                          : () {
                                              addDialog(context);
                                            },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        StatusBarWidget(
                          amount: widget.goal.neededSum,
                          current: widget.goal.currentSum,
                          width: _textWidth,
                          margin: _statusBarMargin,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _imageWidth,
              height: _imageHeight,
              decoration: BoxDecoration(
                borderRadius: _imageBorder,
                image: DecorationImage(
                  image: MemoryImage(widget.goal.photoFile),
                  fit: BoxFit.cover,
                  colorFilter: widget.goal.status == GoalStatus.FINISHED
                      ? ColorFilter.mode(
                          Color.fromRGBO(48, 132, 255, 0.5),
                          BlendMode.hardLight,
                        )
                      : ColorFilter.mode(
                          Color.fromRGBO(0, 0, 0, 0.2),
                          BlendMode.darken,
                        ),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    opacity: _buttonOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: _imageBorder,
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.01),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  widget.goal.status == GoalStatus.FINISHED
                      ? AnimatedAlign(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          alignment: _successAlignment,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: _successIconHeight,
                            margin: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/congrads.svg',
                            ),
                          ),
                        )
                      : Container(),
                  deleteButton(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
