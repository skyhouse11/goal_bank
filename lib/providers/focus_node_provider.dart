import 'package:flutter/material.dart';

class FocusNodeProvider extends ChangeNotifier {
  bool isOpen = false;

  void onTap() {
    notifyListeners();
  }

  void openDropdown() {
    isOpen = true;
  }

  void closeDropdown() {
    isOpen = false;
  }

  void checkDropdown() {
    if (!isOpen) {
      return;
    }
    isOpen = false;
    onTap();
  }
}
