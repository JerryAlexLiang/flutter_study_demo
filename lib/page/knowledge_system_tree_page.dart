import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_study_demo/model/tab_item.dart';
import 'package:flutter_study_demo/page/automatic_keep_alive_page.dart';
import 'package:flutter_study_demo/page/net_work_request_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KnowledgeSystemPage extends StatefulWidget {
  @override
  _KnowledgeSystemPageState createState() => _KnowledgeSystemPageState();
}

// with是dart的关键字，意思是混入的意思，
// 就是说可以将一个或者多个类的功能添加到自己的类无需继承这些类，
// 避免多重继承导致的问题。
// SingleTickerProviderStateMixin 主要是我们初始化TabController时，
// 需要用到async ，垂直属性，然后传递this
class _KnowledgeSystemPageState extends State<KnowledgeSystemPage>
    with SingleTickerProviderStateMixin {
  //存放各个可选项的数组
  List<TabItem> tabItems = [];

  //创建切换控制器，TabController对象可以监听选项卡切换的各种操作
  TabController _controller;

  @override
  void initState() {
    super.initState();
    tabItems.add(TabItem(
      '1 肖战',
      Icons.directions_car,
    ));
    tabItems.add(TabItem('2 马天宇', Icons.directions_transit));
    tabItems.add(TabItem('3 丁程鑫', Icons.directions_bike));
    tabItems.add(TabItem('4 刘耀文', Icons.directions_boat));
    tabItems.add(TabItem('5 李天泽', Icons.directions_walk));
    tabItems.add(TabItem('6 贺峻霖', Icons.directions_bus));
    tabItems.add(TabItem('7 姚景元', Icons.directions_ferry));
    tabItems.add(TabItem('8 费启鸣', Icons.directions_off));
    tabItems.add(TabItem('9 陈星旭', Icons.directions_outlined));

    //初始化控制器，接收选项卡数量和TickerProvider对象
    //这里我们在状态类中使用with关键词混入SingleTickerProviderStateMixin，
    //使这个状态对象成为TickerProvider的实现类，从而帮助选项卡实现切换的动画效果.
    // _controller = TabController(length: 9, vsync: this);
    _controller = TabController(length: 9, vsync: this)
      ..addListener(() {
        Fluttertoast.showToast(
            msg:
                '当前第: ${_controller.index + 1} 页 ${tabItems[_controller.index]?.title}');
      });
  }

  //重写被释放的方法，只释放TabController
  @override
  void dispose() {
    //释放资源
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('保持页面状态'),
          bottom: TabBar(
            //选项是否可滚动
            isScrollable: true,
            //为TabBar配置控制器
            controller: _controller,
            // tabs: [
            //   Tab(
            //     icon: Icon(Icons.directions_car),
            //     text: '1',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.directions_transit),
            //     text: '2',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.directions_bike),
            //     text: '3',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.directions_car),
            //     text: '4',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.directions_transit),
            //     text: '5',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.directions_bike),
            //     text: '6',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.directions_car),
            //     text: '7',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.directions_transit),
            //     text: '8',
            //   ),
            //   Tab(
            //     icon: Icon(Icons.directions_bike),
            //     text: '9',
            //   ),
            // ],
            //通过tabItems数据的map方法循环遍历其中的每一项，并根据每一项创建Tab组件，最终可以通过toList()方法构建一组Tab组件
            tabs: tabItems
                .map((e) => Tab(
                      text: e.title,
                      icon: Icon(e.iconData),
                    ))
                .toList(),
            labelColor: Colors.red,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.yellow,
          )),
      // body: TabBarView(
      //   controller: _controller,
      //   children: [
      //     Center(
      //       child: Text('111'),
      //     ),
      //     Center(
      //       child: Text('222'),
      //     ),
      //     Center(
      //       child: Text('333'),
      //     ),
      //   ],
      // ));
      body: TabBarView(
        //为TabBarView配置与TabBar相同的控制器
        controller: _controller,
        children: [
          AutomaticKeepAlivePage(),
          AutomaticKeepAlivePage(),
          // AutomaticKeepAlivePage(),
          NetworkRequestPage(),
          NetworkRequestPage(),
          NetworkRequestPage(),
          NetworkRequestPage(),
          NetworkRequestPage(),
          NetworkRequestPage(),
          NetworkRequestPage(),
        ],
      ),
    );
  }
}
