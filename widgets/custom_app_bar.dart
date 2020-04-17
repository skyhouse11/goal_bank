import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/providers/theme_provider.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  ThemeProvider _themeProvider;

  final Widget leadingWidget;
  final bool showSort;
  final AppString appString;
  final Function callback;
  final bool automaticallyImplyLeading;
  final bool forceCenter;

  CustomAppBar({
    this.leadingWidget,
    this.showSort = false,
    this.appString,
    this.callback,
    this.automaticallyImplyLeading = false,
    this.forceCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    _themeProvider ??= Provider.of<ThemeProvider>(context, listen: true);

    return AppBar(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      elevation: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: leadingWidget ??
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: _themeProvider.currentTextColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
          ),
          Spacer(
            flex: forceCenter ? 7 : 2,
          ),
          CustomTextSelector(
            name: appString,
            style: TextStyle(
              height: 1.25,
              color: _themeProvider.currentTextColor,
              fontSize: 24,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(
            flex: forceCenter ? 6 : 3,
          ),
        ],
      ),
      actions: showSort
          ? <Widget>[
              InkWell(
                onTap: () {
                  callback();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    child: SvgPicture.asset(
                      'assets/svg/sort-by-attributes-interface-button-option.svg',
                      height: 24,
                      color: _themeProvider.currentTextColor,
                    ),
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
