import 'package:flutter/material.dart';

///底部导航状态管理器
class CurrentIndexProvide with ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
