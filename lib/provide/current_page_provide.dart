import 'package:flutter/material.dart';


class CurrentPageProvide with ChangeNotifier{
  int currentIndex = 0;

  changIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}