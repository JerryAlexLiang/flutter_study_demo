import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string.dart';
import 'package:flutter_study_demo/page/home_button.dart';
import 'package:flutter_study_demo/page/home_left_drawer.dart';
import 'package:flutter_study_demo/page/home_right_drawer.dart';
import 'package:flutter_study_demo/page/sliver_grid_page.dart';
import 'package:flutter_study_demo/page/sliver_list_page.dart';
import 'package:flutter_study_demo/todoList/todo_list_page.dart';
import 'package:flutter_study_demo/widget/home_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnackBarBottomSheetPage extends StatelessWidget {
  SnackBarBottomSheetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //标签和页面联动效果，涉及的组件是TabBar和TabBarView。
    // 两者需要同一个TabController标签控制器来结合，
    // 可以使用DefaultTabController组件将Scaffold包裹起来。
    // 这时不指定控制器，TabBar和TabBarView会使用默认的TabController。
    return DefaultTabController(
      length: StringConfig.homeTabs.length, //标签个数
      child: Scaffold(
        appBar: AppBar(
          title: Text('SnackBar和BottomSheet'),
          actions: [
            HomeMenu(),
          ],
          bottom: _buildHomeTabBar(),
        ),
        body: _homeContent(),
        drawer: HomeLeftDrawer(),
        endDrawer: HomeRightDrawer(),
        floatingActionButton: HomeButton(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => Fluttertoast.showToast(msg: '丁程鑫'),
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }

  _buildHomeTabBar() {
    return TabBar(
      labelStyle: TextStyle(fontSize: 15),
      labelColor: Colors.red, //当前选中文字颜色
      unselectedLabelColor: Color(0xffeeeeee), //为选中文字颜色
      tabs: StringConfig.homeTabs
          .map((e) => Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(e),
              ))
          .toList(),
    );
  }

  _homeContent() {
    //根据列表创建界面列表
    return TabBarView(
      children: StringConfig.homeTabs
          .map((e) => _buildTabBarViewContent(StringConfig.homeTabs.indexOf(e)))
          .toList(),
    );
  }

  Widget _buildTabBarViewContent(int index) {
    switch (index) {
      case 0:
        return TodoListPage('Flutter');
        break;

      case 1:
        return SliverListPage();
        break;

      case 2:
        return SliverGridPage();
        break;
    }
    return null;
  }
}
