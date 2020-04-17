import 'package:flutter/material.dart';
import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/enums/sort_enum.dart';
import 'package:goal_bank/providers/shared_preference_provider.dart';
import 'package:goal_bank/widgets/checkbox_item.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:provider/provider.dart';

class SortWidget extends StatefulWidget {
  bool isOpen;
  final Function callback;

  SortWidget({this.isOpen, this.callback});

  @override
  _SortWidgetState createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  bool finished = false;
  bool decreasing = false;
  SortStatus sortStatus = SortStatus.OFF;
  
  Color nameColor       = Colors.grey;
  Color sumColor        = Colors.grey;
  Color createDateColor = Colors.grey;
  Color finishDateColor = Colors.grey;

  SharedPreferencesProvider _sharedPreferencesProvider;

  sortByName() {
    if (sortStatus == SortStatus.NAME_INCREASING)
      setState(() {
        decreasing = true;
        sortStatus = SortStatus.NAME_DECREASING;
      });
    else if (sortStatus == SortStatus.NAME_DECREASING)
      setState(() {
        decreasing = false;
        sortStatus = SortStatus.OFF;
      });
    else
      setState(() {
        decreasing = false;
        sortStatus = SortStatus.NAME_INCREASING;
      });
  }

  Color setNameColor() {
    if (sortStatus == SortStatus.NAME_INCREASING ||
        sortStatus == SortStatus.NAME_DECREASING) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }

  sortBySum() {
    if (sortStatus == SortStatus.SUM_INCREASING)
      setState(() {
        decreasing = true;
        sortStatus = SortStatus.SUM_DECREASING;
      });
    else if (sortStatus == SortStatus.SUM_DECREASING)
      setState(() {
        decreasing = false;
        sortStatus = SortStatus.OFF;
      });
    else
      setState(() {
        decreasing = false;
        sortStatus = SortStatus.SUM_INCREASING;
      });
  }

  Color setSumColor() {
    if (sortStatus == SortStatus.SUM_INCREASING ||
        sortStatus == SortStatus.SUM_DECREASING) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }

  sortByCreateDate() {
    if (sortStatus == SortStatus.CREATE_DATE_INCREASING)
      setState(() {
        decreasing = true;
        sortStatus = SortStatus.CREATE_DATE_DECREASING;
      });
    else if (sortStatus == SortStatus.CREATE_DATE_DECREASING)
      setState(() {
        decreasing = false;
        sortStatus = SortStatus.OFF;
      });
    else
      setState(() {
        decreasing = false;
        sortStatus = SortStatus.CREATE_DATE_INCREASING;
      });
  }

  Color setCreateDateColor() {
    if (sortStatus == SortStatus.CREATE_DATE_INCREASING ||
        sortStatus == SortStatus.CREATE_DATE_DECREASING) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }

  sortByFinishDate() {
    if (sortStatus == SortStatus.FINISH_DATE_INCREASING)
      setState(() {
        decreasing = true;
        sortStatus = SortStatus.FINISH_DATE_DECREASING;
      });
    else if (sortStatus == SortStatus.FINISH_DATE_DECREASING)
      setState(() {
        decreasing = false;
        sortStatus = SortStatus.OFF;
      });
    else
      setState(() {
        decreasing = false;
        sortStatus = SortStatus.FINISH_DATE_INCREASING;
      });
  }

  Color setFinishDateColor() {
    if (sortStatus == SortStatus.FINISH_DATE_INCREASING ||
        sortStatus == SortStatus.FINISH_DATE_DECREASING) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }

  Widget sortElement({AppString item, Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            if (item == AppString.MAIN_PAGE_NAME_SORT) sortByName();
            else if (item == AppString.MAIN_PAGE_SUM_SORT) sortBySum();
            else if (item == AppString.MAIN_PAGE_CREATE_DATE_SORT) sortByCreateDate();
            else if (item == AppString.MAIN_PAGE_FINISH_DATE_SORT) sortByFinishDate();

            _sharedPreferencesProvider.sortList(sortStatus);

            if (widget.callback != null) widget.callback();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomTextSelector(
                  name: item,
                  freeText: ":",
                  style: TextStyle(
                    height: 1.3,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: color,
                    fontSize: 16,
                  ),
                ),
              ),
              color == Colors.white
                  ? (decreasing
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ))
                  : Container(),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget finishedSortElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              finished = !finished;
            });
            if(finished) {
              _sharedPreferencesProvider.sortList(SortStatus.SHOW_FINISHED);
            } else {
              _sharedPreferencesProvider.sortList(SortStatus.OFF);
            }
            if (widget.callback != null) widget.callback();
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomTextSelector(
                  name: AppString.MAIN_PAGE_FINISHED,
                  freeText: ":",
                  style: TextStyle(
                    height: 1.3,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              CheckboxItem(finished),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(context);

    return AnimatedContainer(
      curve: Curves.easeInOut,
      color: Color.fromRGBO(55, 55, 55, 1),
      duration: Duration(milliseconds: 500),
      height: widget.isOpen ? 280 : 0,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 8),
            child: CustomTextSelector(
              name: AppString.MAIN_PAGE_SORT_BY,
              freeText: ":",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              sortElement(item: AppString.MAIN_PAGE_NAME_SORT,        color: setNameColor()),
              sortElement(item: AppString.MAIN_PAGE_SUM_SORT,         color: setSumColor()),
              sortElement(item: AppString.MAIN_PAGE_CREATE_DATE_SORT, color: setCreateDateColor()),
              sortElement(item: AppString.MAIN_PAGE_FINISH_DATE_SORT, color: setFinishDateColor()),
              finishedSortElement(),
            ],
          ),
        ],
      ),
    );
  }
}
