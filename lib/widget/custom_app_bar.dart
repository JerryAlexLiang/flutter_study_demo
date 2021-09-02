import 'package:flutter/material.dart';

customAppBar(
  String title, {
  bool showBack = true,
  bool centerTitle,
  List<Widget> actions,
  Color backgroundColor,
  Color titleColor,
  Color backButtonColor,
  PreferredSizeWidget bottom,
}) {
  return AppBar(
    //明暗模式
    brightness: Brightness.light,
    //导航栏右侧
    actions: actions,
    //title位置是否居中
    centerTitle: centerTitle != null ? centerTitle : true,
    //阴影高度
    elevation: 0,
    //背景色
    backgroundColor: backgroundColor != null ? backgroundColor : Colors.white,
    //导航栏最左侧Widget: 是否显示返回按钮
    leading: showBack ? BackButton(color: backButtonColor) : null,
    //title文字和样式
    title: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        color: titleColor != null ? titleColor : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    //底部组件PreferredSizeWidget
    bottom: bottom,
  );
}
