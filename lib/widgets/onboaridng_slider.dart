import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:goal_bank/enums/app_string.dart';
import 'package:goal_bank/widgets/custom_button.dart';
import 'package:goal_bank/widgets/custom_text_selector.dart';

class OnBoardingSlider extends StatefulWidget {
  @override
  _OnBoardingSliderState createState() => _OnBoardingSliderState();
}

class _OnBoardingSliderState extends State<OnBoardingSlider> {
  List<Map> _items = [
    {'index': 1, 'text': AppString.CAROUSEL_FIRST},
    {'index': 2, 'text': AppString.CAROUSEL_SECOND},
    {'index': 3, 'text': AppString.CAROUSEL_THIRD},
  ];

  int _current = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(0, 0, 0, .7),
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            onPageChanged: (index) {
              setState(() {
                _current = index + 1;
              });
            },
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            height: MediaQuery.of(context).size.height,
            items: _items.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04,
                        ),
                        child: CustomTextSelector(
                          name: i['text'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.25,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'assets/on${i['index']}.png',
                            height: MediaQuery.of(context).size.height,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _items.map<Widget>(
                (item) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 2.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == item['index']
                          ? Color.fromRGBO(255, 255, 255, 0.9)
                          : Color.fromRGBO(255, 255, 255, 0.4),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.025,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomButton(
                    onPressed: () => Navigator.pop(context),
                    highlightColor: Color.fromRGBO(0, 0, 0, 0),
                    splashColor: Colors.lightBlue,
                    name: AppString.CAROUSEL_SKIP_NAME,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 64),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
