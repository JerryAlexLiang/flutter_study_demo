import 'package:flutter/material.dart';
import 'package:flutter_study_demo/custom_router.dart';
import 'package:flutter_study_demo/model/study_demo_navigator_model.dart';
import 'package:flutter_study_demo/page/CodeLab/code_lab_login_page.dart';
import 'package:flutter_study_demo/page/custom_widget_pages.dart';
import 'package:flutter_study_demo/page/event_bus_one_page.dart';
import 'package:flutter_study_demo/page/my_widget.dart';
import 'package:flutter_study_demo/page/net_work_request_page.dart';
import 'package:flutter_study_demo/page/shared_preferences_page.dart';
import 'package:flutter_study_demo/page/sliver_grid_page.dart';
import 'package:flutter_study_demo/page/study_first_demo_page.dart';
import 'package:flutter_study_demo/widget/custom_toolbar.dart';
import 'package:flutter_study_demo/widget/sliver_appbar_delegate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SliverPersistentHeaderPage extends StatelessWidget {
  SliverPersistentHeaderPage({Key key}) : super(key: key);

  final data = <Color>[
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[50],
    Colors.purple[100],
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
    StudyDemoNavigatorModel(
        "可滚动的布局1 SliverAppBar + SliverList + SliverToBoxAdapter",
        "11",
        "image"),
    StudyDemoNavigatorModel(
        "可滚动的布局2 SliverAppBar + SliverGrid + SliverToBoxAdapter",
        "12",
        "image"),
    StudyDemoNavigatorModel("SliverPersistentHeader组件", "13", "image"),
  ];

  final imageUrl =
      // "https://img1.baidu.com/it/u=2620121525,3057821586&fm=26&fmt=auto&gp=0.jpg";
      "http://gank.io/images/d6bba8cf5b8c40f9ad229844475e9149";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomToolBar(
      //   onTapLeft: () {
      //     Navigator.pop(context);
      //   },
      //   onTapRight: () {
      //     Fluttertoast.showToast(msg: 'menu click');
      //   },
      //   navigationBarBackgroundColor: Colors.blue,
      // ),
      body: CustomScrollView(
        slivers: [
          _buildSliversAppBar(),
          _buildSliverListHorizon3(),
          _buildPersistentHeader('SliverPersistentHeader'),
          // _buildSliverList(),
          _buildSliverList2(),
        ],
      ),
    );
  }

  Widget _buildSliverListHorizon3() {
    //横向滑动ListView
    // SliverToBoxAdapter Sliver适配器，可以容纳一个普通的组件，并将其转化成Sliver家族组件的适配器
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                width: 100,
                child: Card(
                  color: data[index],
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        dataList[index].name,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () => Fluttertoast.showToast(msg: dataList[index].name),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSliverList2() {
    return SliverList(
      //对于Sliver组件，通常可以找到与之对应的普通组件
      //SliverList组件对应的是ListView组件
      //方法1：直接传入各列表项，因为已经确定数量，所以这里就不用做内部优化

      //方法2：通过构建函数可以设置一个可以无限滚动的列表
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
      expandedHeight: 300.0,
      //影深 double
      elevation: 5,
      //延展空间 FlexibleSpaceBar
      flexibleSpace: InkWell(
        child: FlexibleSpaceBar(
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
            fit: BoxFit.cover,
          ),
          title: Text(
            'SliverAppBar + SliverList + SliverToBoxAdapter',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          //视差效果
          collapseMode: CollapseMode.parallax,
          // collapseMode: CollapseMode.pin,
        ),
        onTap: () => Fluttertoast.showToast(msg: '妹子'),
      ),
      //背景色
      backgroundColor: Colors.red,
      // //左侧组件
      // leading: Icon(Icons.menu),
      //尾部组件列表 List<Widget>
      actions: [
        IconButton(
          padding: EdgeInsets.all(10.0),
          icon: Icon(Icons.star),
          onPressed: () => Fluttertoast.showToast(msg: 'star'),
        ),
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
        Navigator.push(context, CustomRoute(SliverPersistentHeaderPage()));
        break;

      case 14:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SliverGridPage(),
          ),
        );
        break;

      case 15:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SliverPersistentHeaderPage()),
        );
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

  _buildPersistentHeader(String s) {
    //SliverPersistentHeader 通常用于CustomScrollView中，可以让一个组件在滑动中停留在顶部，不会滑动消失
    return SliverPersistentHeader(
      //pinned 是否伸展并顶部停留
      pinned: true,
      // //floating 是否浮动
      // floating: false,
      //delegate 代理
      delegate: SliverAppBarDelegate(
        50.0,
        100.0,
        Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text(
            'SliverPersistentHeader - StudyList',
            style: GoogleFonts.oswald(
              color: Colors.white,
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
