import 'package:flutter/material.dart';
import 'package:goal_bank/providers/focus_node_provider.dart';
import 'package:provider/provider.dart';

class InputScaffold extends StatelessWidget {
  final Widget child;
  final AppBar appBar;

  InputScaffold({
    this.appBar,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    FocusNodeProvider focus =
        Provider.of<FocusNodeProvider>(context, listen: false);

    return InkWell(
      child: Scaffold(
        appBar: appBar,
        body: child,
      ),
      onTap: focus.onTap,
    );
  }
}
