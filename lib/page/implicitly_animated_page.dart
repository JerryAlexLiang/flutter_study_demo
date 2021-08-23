import 'package:flutter/material.dart';
import 'package:flutter_study_demo/custom_router.dart';
import 'package:flutter_study_demo/model/study_demo_navigator_model.dart';
import 'package:flutter_study_demo/page/animated_container_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImplicitlyAnimatedPage extends StatelessWidget {
  ImplicitlyAnimatedPage({Key key}) : super(key: key);

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
    StudyDemoNavigatorModel("AnimatedContainer", 0, "image"),
    StudyDemoNavigatorModel("Flutter2中文网Demo2 Flutter布局基础", 1, "image"),
    StudyDemoNavigatorModel("Flutter2中文网Demo3 Flutter CodeLab", 2, "image"),
    StudyDemoNavigatorModel("网络数据", 3, "image"),
    StudyDemoNavigatorModel("Provide状态管理", 4, "image"),
    StudyDemoNavigatorModel("ListView", 5, "image"),
    StudyDemoNavigatorModel("ListView2", 6, "image"),
    StudyDemoNavigatorModel("StatefulWidget", 7, "image"),
    StudyDemoNavigatorModel("extends custom widget", 8, "image"),
    StudyDemoNavigatorModel("ScopedModel数据共享与传递", 9, "image"),
    StudyDemoNavigatorModel("EventBus数据共享与传递", 10, "image"),
    StudyDemoNavigatorModel("shared_preferences存储数据", 11, "image"),
    StudyDemoNavigatorModel("路由的基本使用", 12, "image"),
    StudyDemoNavigatorModel(
        "可滚动的布局1 SliverAppBar + SliverList + SliverToBoxAdapter", 13, "image"),
    StudyDemoNavigatorModel(
        "可滚动的布局2 SliverAppBar + SliverGrid + SliverToBoxAdapter", 14, "image"),
    StudyDemoNavigatorModel("SliverPersistentHeader组件", 15, "image"),
    StudyDemoNavigatorModel("AnimationWidget组件", 16, "image"),
    StudyDemoNavigatorModel("隐式动画组件ImplicitlyAnimatedWidget", 17, "image"),
  ];

  final imageUrl =
      // "https://img1.baidu.com/it/u=2620121525,3057821586&fm=26&fmt=auto&gp=0.jpg";
      "http://gank.io/images/6b2efa591564475fb8bc32291fb0007c";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliversAppBar(),
          _buildSliverList(),
        ],
      ),
    );
  }

  _buildSliversAppBar() {
    return SliverAppBar(
      // title: Container(
      //   // alignment: Alignment.centerLeft,
      //   child: Text(
      //     '隐式动画',
      //     maxLines: 1,
      //     overflow: TextOverflow.ellipsis,
      //   ),
      // ),
      title: Text(
        '隐式动画',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      pinned: true,
      expandedHeight: 300.0,
      flexibleSpace: GestureDetector(
        child: FlexibleSpaceBar(
          background: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          // title: Text(
          //   '隐式动画',
          //   style: TextStyle(color: Colors.white),
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          // ),
          collapseMode: CollapseMode.parallax,
        ),
        onTap: () => Fluttertoast.showToast(msg: '隐式动画'),
      ),
      backgroundColor: Colors.pink,
      actions: [
        IconButton(
          padding: EdgeInsets.all(10),
          icon: Icon(Icons.star_border),
          onPressed: () => Fluttertoast.showToast(msg: 'right click1'),
        ),
        IconButton(
          icon: Icon(Icons.sort),
          onPressed: () => Fluttertoast.showToast(msg: 'right click2'),
        ),
      ],
    );
  }

  _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            alignment: Alignment.center,
            height: 100,
            color: data[index],
            child: ListTile(
              title: Text(
                dataList[index].name,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationThickness: 1.5,
                  decorationColor: Colors.yellow,
                ),
              ),
              onTap: () => _listViewClickListener(context, index),
            ),
          );
        },
        childCount: dataList.length,
      ),
    );
  }

  _listViewClickListener(BuildContext context, int index) {
    switch (dataList[index].id) {
      case 0:
        Navigator.push(context, CustomRoute(AnimatedContainerPage()));
        break;

      // case 1:
      //   Navigator.push(context, CustomRoute(MyWidget()));
      //   break;
      //
      // case 2:
      //   Navigator.push(context, CustomRoute(CodeLabLoginPage()));
      //   break;
      //
      // case 3:
      //   Navigator.push(context, CustomRoute(NetworkRequestPage()));
      //   break;
      //
      // case 8:
      //   Navigator.push(context, CustomRoute(CustomWidgetPages()));
      //   break;
      //
      // case 9:
      // // Navigator.push(context,
      // //     MaterialPageRoute(builder: (context) {
      // //   return ScopedModelPage();
      // // }));
      //   break;
      //
      // case 10:
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return EventBusOnePage();
      //   }));
      //   break;
      //
      // case 11:
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return SharedPreferencesPage();
      //   }));
      //   break;
      //
      // case 12:
      //   Navigator.push(context, CustomRoute(SharedPreferencesPage()));
      //   break;
      //
      // case 13:
      //   Navigator.push(context, CustomRoute(SliverListPage()));
      //   break;
      //
      // case 14:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => SliverGridPage(),
      //     ),
      //   );
      //   break;
      //
      // case 15:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => SliverPersistentHeaderPage()),
      //   );
      //   break;
      //
      // case 16:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => AnimationPage()),
      //   );
      //   break;
      //
      // case 17:
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => ImplicitlyAnimatedPage(),
      //       ));
      //   break;
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
