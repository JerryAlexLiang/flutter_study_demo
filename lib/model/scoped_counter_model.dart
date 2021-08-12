import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///定义ScopedModel，用来存储输数据
class ScopedCounterModel extends Model {
  //定义属性
  int _counter = 0;

  //获取counter的方法
  int get counter => _counter;

  //定义改变值的方法
  void incrementCounter() {
    _counter++;
    //刷新数据
    notifyListeners();
  }

  //也可以通过以下方法来获取对象，调用里面的方法和属性
  static ScopedCounterModel of(BuildContext context) {
    return ScopedModel.of<ScopedCounterModel>(context);
  }
}
