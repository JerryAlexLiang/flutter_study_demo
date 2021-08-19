import 'package:flutter/material.dart';
import 'package:flutter_study_demo/custom_router.dart';
import 'package:flutter_study_demo/model/study_demo_navigator_model.dart';
import 'package:flutter_study_demo/page/CodeLab/code_lab_login_page.dart';
import 'package:flutter_study_demo/page/custom_widget_pages.dart';
import 'package:flutter_study_demo/page/event_bus_one_page.dart';
import 'package:flutter_study_demo/page/my_widget.dart';
import 'package:flutter_study_demo/page/net_work_request_page.dart';
import 'package:flutter_study_demo/page/shared_preferences_page.dart';
import 'package:flutter_study_demo/page/study_first_demo_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SliverListPage extends StatelessWidget {
  SliverListPage({Key key}) : super(key: key);

  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  final List<StudyDemoNavigatorModel> dataList = [
    StudyDemoNavigatorModel("Flutter2中文网Demo1", "0", "image"),
    StudyDemoNavigatorModel("Flutter2中文网Demo2 Flutter布局基础", "1", "image"),
    StudyDemoNavigatorModel("Flutter2中文网Demo3 Flutter CodeLab", "2", "image"),
    StudyDemoNavigatorModel("网络数据", "1", "image"),
    StudyDemoNavigatorModel("Provide状态管理", "2", "image"),
    StudyDemoNavigatorModel("ListView", "3", "image"),
    StudyDemoNavigatorModel("ListView2", "4", "image"),
    StudyDemoNavigatorModel("StatefulWidget", "5", "image"),
    StudyDemoNavigatorModel("extends custom widget", "6", "image"),
    StudyDemoNavigatorModel("ScopedModel数据共享与传递", "7", "image"),
    StudyDemoNavigatorModel("EventBus数据共享与传递", "8", "image"),
    StudyDemoNavigatorModel("shared_preferences存储数据", "9", "image"),
    StudyDemoNavigatorModel("路由的基本使用", "10", "image"),
    StudyDemoNavigatorModel("可滚动的布局1 SliverAppBar + SliverList", "11", "image"),
  ];

  final imageUrl =
      "https://img1.baidu.com/it/u=2620121525,3057821586&fm=26&fmt=auto&gp=0.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliversAppBar(),
          // _buildSliverList(),
          _buildSliverList2(),
        ],
      ),
    );
  }

  Widget _buildSliverList2() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            alignment: Alignment.center,
            height: 100,
            color: data[index],
            // child: Text(
            //   dataList[index].name,
            //   style: TextStyle(
            //     color: Colors.red,
            //     fontSize: 16,
            //   ),
            // ),
            child: ListTile(
              title: Text(
                dataList[index].name,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                _listViewClickListener(context, index);
              },
            ),
          );
        },
        childCount: dataList.length,
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          alignment: Alignment.center,
          width: 100,
          height: 60,
          color: data[index],
          child: Text(
            '$index',
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(0.5, 0.5),
                  blurRadius: 2,
                )
              ],
            ),
          ),
        );
      }, childCount: data.length),
    );
  }

  Widget _buildSliversAppBar() {
    return SliverAppBar(
      //是否顶部停留
      pinned: true,
      //是否浮动
      // floating: true,
      //是否半收展 snap为true时必须floating为true
      // snap: true,
      //延展高度 double
      expandedHeight: 120.0,
      //影深 double
      elevation: 5,
      //延展空间 FlexibleSpaceBar
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        //标题边距
        // titlePadding: EdgeInsets.only(
        //   left: 55,
        //   bottom: 55,
        // ),
        // background: Image.asset(
        //   "images/core_icon_bg_header.png",
        //   fit: BoxFit.fill,
        // ),
        background: Image.network(
          imageUrl,
          fit: BoxFit.fill,
        ),
        title: Text(
          'SliverAppBar + SliverList',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        //视差效果
        collapseMode: CollapseMode.parallax,
        // collapseMode: CollapseMode.pin,
      ),
      //背景色
      backgroundColor: Colors.red,
      // //左侧组件
      // leading: Icon(Icons.menu),
      //尾部组件列表 List<Widget>
      actions: [
        Icon(Icons.star),
      ],
    );
  }

  _listViewClickListener(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, CustomRoute(StudyFirstDemoPage()));
        break;

      case 1:
        Navigator.push(context, CustomRoute(MyWidget()));
        break;

      case 2:
        Navigator.push(context, CustomRoute(CodeLabLoginPage()));
        break;

      case 3:
        Navigator.push(context, CustomRoute(NetworkRequestPage()));
        break;

      case 8:
        Navigator.push(context, CustomRoute(CustomWidgetPages()));
        break;

      case 9:
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) {
        //   return ScopedModelPage();
        // }));
        break;

      case 10:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EventBusOnePage();
        }));
        break;

      case 11:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SharedPreferencesPage();
        }));
        break;

      case 12:
        Navigator.push(context, CustomRoute(SharedPreferencesPage()));
        break;

      case 13:
        Navigator.push(context, CustomRoute(SliverListPage()));
        break;
    }
    Fluttertoast.showToast(
        msg: '你点击了${dataList[index].name}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
