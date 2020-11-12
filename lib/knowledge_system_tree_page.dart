import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_study_demo/automatic_keep_alive_page.dart';

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
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  //重写被释放的方法，只释放TabController
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('保持页面状态'),
            bottom: TabBar(
              controller: _controller,
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
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
          controller: _controller,
          children: [
            AutomaticKeepAlivePage(),
            AutomaticKeepAlivePage(),
            AutomaticKeepAlivePage(),
          ],
        ));
  }
}
