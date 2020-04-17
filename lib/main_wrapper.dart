import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/providers/theme_provider.dart';

ValueNotifier<double> bottomPadding = ValueNotifier(0.0);
ValueNotifier<bool> isLoaded = ValueNotifier(false);

class MainWrapper extends StatefulWidget {
  final Widget child;

  MainWrapper(this.child);

  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  double _safeAreaHeight;
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _safeAreaHeight = MediaQuery.of(context).padding.bottom;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0.0;

    if (isKeyboardVisible && _safeAreaHeight > 0.0) {
      setState(() {
        _safeAreaHeight = 0.0;
      });
    } else if (!isKeyboardVisible && _safeAreaHeight == 0.0) {
      setState(() {
        _safeAreaHeight = MediaQuery.of(context).padding.bottom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoaded,
      builder: (context, _, __) {
        return ValueListenableBuilder(
          valueListenable: bottomPadding,
          builder: (context, _, __) {
            return Stack(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  child: widget.child,
                  padding: EdgeInsets.only(
                    bottom: isKeyboardVisible ? 0.0 : bottomPadding.value,
                  ),
                ),
                AnimatedPositioned(
                  curve: Curves.easeInOut,
                  left: !isLoaded.value ? 0.0 : MediaQuery.of(context).size.width + 24,
                  duration: Duration(milliseconds: 600),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Provider.of<ThemeProvider>(context).currentButtonColor,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.24),
                          offset: Offset(-1, 0),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset('assets/icon.png'),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
