import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///底部导航状态管理器
class CurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;

  // CurrentIndexProvider(this.currentIndex);

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    //这个方法是通知用到CurrentIndexProvider对象的Widget刷新用的
    notifyListeners();
  }

  int get index => currentIndex;
}


//1、这里需要混入ChangeNotifier
//2、写一个增加的方法，然后需要调用notifyListeners();这个方法是通知用到CurrentIndexProvider对象的widget刷新用的。
//3、get方法