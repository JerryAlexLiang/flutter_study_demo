import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeMenu extends StatelessWidget {
  HomeMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: _buildMenuItem,
      onSelected: _onSelected,
    );
  }

  //根据字符串列表映射按钮菜单子项列表
  List<PopupMenuEntry> _buildMenuItem(BuildContext context) {
    return StringConfig.menuInfo.map((e) =>
        PopupMenuItem(
          child: Text(e), value: StringConfig.menuInfo.indexOf(e),
        )
    ).toList();
  }

  //选中时回调
  void _onSelected(value) {
    print('.......>>>>>  $value');
    switch(value){
      case 0:
        Fluttertoast.showToast(msg: StringConfig.menuInfo[value]);
        break;

      case 1:
        Fluttertoast.showToast(msg: StringConfig.menuInfo[value]);
        break;

      case 2:
        Fluttertoast.showToast(msg: StringConfig.menuInfo[value]);
        break;
    }
  }
}

