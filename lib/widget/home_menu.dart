import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/widget/dialog_demos.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeMenu extends StatelessWidget {
  HomeMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: _buildMenuItem,
      onSelected: (index) => _onSelected(context, index),
    );
  }

  //根据字符串列表映射按钮菜单子项列表
  List<PopupMenuEntry> _buildMenuItem(BuildContext context) {
    return StringConfig.menuInfo
        .map((e) => PopupMenuItem(
              child: Text(e),
              value: StringConfig.menuInfo.indexOf(e),
            ))
        .toList();
  }

  //选中时回调
  void _onSelected(BuildContext context, value) {
    print('.......>>>>>  $value');
    switch (value) {
      case 0:
        Fluttertoast.showToast(msg: StringConfig.menuInfo[value]);
        break;

      case 1:
        Fluttertoast.showToast(msg: StringConfig.menuInfo[value]);
        //由于该对话框可能要经常修改，而且有时可以复用，因此有必要单独提取出来
        showDialog(
          context: context,
          builder: (context) => DialogDemos(),
        );
        break;

      case 2:
        Fluttertoast.showToast(msg: StringConfig.menuInfo[value]);
        break;
    }
  }
}
