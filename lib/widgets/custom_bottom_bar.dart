import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/data/svg_icons_icons.dart';
import 'package:goal_bank/providers/theme_provider.dart';


class CustomBottomBar extends StatefulWidget {
  final Color bottomAppBarColor;
  final List<BottomNavigationBarItem> items;
  final bool hasNotch;
  final Function callback;
  int currentIndex;

  CustomBottomBar({
    this.bottomAppBarColor,
    this.items,
    this.hasNotch = false,
    this.currentIndex,
    this.callback,
  });

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(
      builder: (context, theme, child) {
        return BottomAppBar(
          shape: widget.hasNotch ? CircularNotchedRectangle() : null,
          notchMargin: 6,
          color: theme.currentBottomAppBarColor,
          elevation: 0.0,
          clipBehavior: Clip.antiAlias,
          child: CupertinoTabBar(
            backgroundColor: theme.currentBottomAppBarColor,
            activeColor: theme.currentButtonColor,
            currentIndex: widget.currentIndex,
            onTap: widget.callback,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  SvgIcons.info,
                  size: 24,
                ),
                title: Text(
                  '',
                  style: TextStyle(height: 0),
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: theme.currentBottomAppBarColor,
                icon: Icon(
                  SvgIcons.house,
                  size: 24,
                ),
                activeIcon: Icon(null),
                title: Text(
                  '',
                  style: TextStyle(height: 0),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  SvgIcons.settings_tapbar,
                  size: 24,
                ),
                title: Text(
                  '',
                  style: TextStyle(height: 0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
