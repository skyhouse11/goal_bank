import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:goal_bank/enums/open_status_enum.dart';

import 'package:goal_bank/models/app_class.dart';

const StatusBar20 = Color.fromRGBO(255, 48, 58, 1);
const StatusBar40 = Color.fromRGBO(255, 122, 58, 1);
const StatusBar60 = Color.fromRGBO(255, 222, 58, 1);
const StatusBar80 = Color.fromRGBO(48, 255, 205, 1);
const StatusBar99 = Color.fromRGBO(48, 168, 255, 1);
const StatusBar100 = Color.fromRGBO(48, 132, 255, 1);

class StatusBarWidget extends StatelessWidget {
  final int amount;
  final int current;
  final double width;
  final EdgeInsets margin;
  final GoalAnimationStatus status;

  Color _color;
  double _statusWidth;
  double _progress;

  AppClass get appClass => GetIt.instance<AppClass>();

  StatusBarWidget({
    this.amount,
    this.current,
    this.width,
    this.margin,
    this.status,
  });

  void countWidth() {
    double _idealPercent = amount / 100;
    _progress = current / _idealPercent;

    if (_progress <= 20.0) {
      _color = StatusBar20;
    } else if (_progress > 20.0 && _progress <= 40.0) {
      _color = StatusBar40;
    } else if (_progress > 40.0 && _progress <= 60.0) {
      _color = StatusBar60;
    } else if (_progress > 60.0 && _progress <= 80.0) {
      _color = StatusBar80;
    } else if (_progress > 80.0 && _progress < 100.0) {
      _color = StatusBar99;
    } else if (_progress >= 100) {
      _color = StatusBar100;
    }

    _statusWidth = ((width - margin.left * 2) / 100) * _progress;
  }

  Widget build(BuildContext context) {
    countWidth();
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 56.0,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 5.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '$current' + appClass.currentCurrency.symbol,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: _color,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '$amount' + appClass.currentCurrency.symbol,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Color.fromRGBO(55, 55, 55, 0.2),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(55, 55, 55, 0.2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(85.0),
                        ),
                      ),
                    ),
                    Container(
                      height: 4.0,
                      width: _statusWidth,
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.all(
                          Radius.circular(85.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _statusWidth + 12,
            constraints: BoxConstraints(
              minWidth: 18,
            ),
            curve: Curves.easeInOut,
            child: Container(
              constraints: BoxConstraints(
                minWidth: 30,
              ),
              alignment: Alignment.centerRight,
              child: Text(
                '${_progress.floor()}%',
                style: TextStyle(
                  color: Color.fromRGBO(55, 55, 55, 1),
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  fontFamily: 'Ubuntu',
                  height: 1.25,
                  letterSpacing: -0.17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
