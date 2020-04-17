import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/enums/sort_enum.dart';

import 'package:goal_bank/models/goal_class.dart';

import 'package:goal_bank/pages/theme_container.dart';

import 'package:goal_bank/providers/shared_preference_provider.dart';
import 'package:goal_bank/providers/theme_provider.dart';

import 'package:goal_bank/widgets/custom_app_bar.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:goal_bank/widgets/goal_widget/goal_widget.dart';
import 'package:goal_bank/widgets/onboarding_icon.dart';
import 'package:goal_bank/widgets/pop_up/app_bar_sum_widget.dart';
import 'package:goal_bank/widgets/sort_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SortStatus sortStatus = SortStatus.OFF;
  bool isSortOpen = false;

  int index;

  @override
  initState() {
    super.initState();
    sortStatus = SortStatus.OFF;
  }

  Widget build(BuildContext context) {
    return ThemeBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          appString: AppString.MAIN_PAGE_TITLE,
          showSort: true,
          leadingWidget: AppBarSumWidget(),
          callback: () {
            setState(() {
              isSortOpen = !isSortOpen;
            });
          },
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              isSortOpen = false;
            });
          },
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size?.width ?? 50.0,
                height: MediaQuery.of(context).size?.height ?? 50.0,
                child: Provider.of<SharedPreferencesProvider>(context)?.goalsList?.isEmpty ?? [].isEmpty
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 20.0),
                              child: CustomTextSelector(
                                name: AppString.MAIN_PAGE_CREATE_FIRST,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                  height: 1.25,
                                  letterSpacing: -0.17,
                                  fontSize: 18,
                                  color: Provider.of<ThemeProvider>(context).currentTextColor,
                                ),
                              ),
                            ),
                            Container(
                              child: SvgPicture.asset(
                                'assets/svg/cta.svg',
                                height: (MediaQuery.of(context).size.height / 1.4) - 100,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
              Column(
                children: <Widget>[
                  SortWidget(
                    isOpen: isSortOpen,
                    callback: () {
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Selector<SharedPreferencesProvider, List<Goal>>(
                      builder: (context, value, _) {
                        return ListView.builder(
                          itemCount: value != null ? value.length : 0,
                          physics: (value == null || value.isEmpty) ? NeverScrollableScrollPhysics() : null,
                          itemBuilder: (context, int i) {
                            return GoalWidget(
                              callback: (int value) => setState(() {
                                index = value;
                              }),
                              index: i,
                              currentIndex: index,
                              goal: value[i],
                            );
                          },
                        );
                      },
                      selector: (context, sharedPref) {
                        return sharedPref.goalsList;
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  OnBoardingIcon(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
