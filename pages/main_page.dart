import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:goal_bank/enums/sort_enum.dart';

import 'package:goal_bank/data/settings.dart';

import 'package:goal_bank/pages/about_page.dart';
import 'package:goal_bank/pages/home_page.dart';
import 'package:goal_bank/pages/settings_page.dart';
import 'package:goal_bank/pages/theme_container.dart';

import 'package:goal_bank/service/admob.dart';

import 'package:goal_bank/widgets/custom_bottom_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SortStatus sortStatus = SortStatus.OFF;
  bool isSortOpen = false;

  int currentIndex = 1;

  List<Widget> pages = [
    AboutPage(),
    HomePage(),
    SettingsPage(),
  ];

  Widget build(BuildContext context) {
    GetIt.instance<AdMobService>().createBannerAd();

    return ThemeBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: pages[currentIndex],
        floatingActionButton: currentIndex == 1
            ? FloatingActionButton(
                elevation: 10,
                splashColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.pushNamed(context, CreateGoalPageLink);
                },
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        bottomNavigationBar: CustomBottomBar(
          currentIndex: currentIndex,
          callback: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          hasNotch: currentIndex == 1 ? true : false,
        ),
      ),
    );
  }
}
