import 'package:flutter/material.dart';

import 'home_list_page.dart';
import 'knowledge_system_tree_page.dart';
import 'net_work_request_page.dart';
import 'simple_list_page.dart';

class MainNewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() {
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: '知识',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: '列表',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.network_check),
      label: '网络',
    )
  ];

  final List<Widget> tabPageBodies = [
    HomeListPage(),
    KnowledgeSystemPage(),
    SimpleListPage(),
    NetworkRequestPage()
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    //初始化默认选中Page
    currentPage = tabPageBodies[currentIndex];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          //动态组件改变组建样式使用setState()
          setState(() {
            currentIndex = index;
            currentPage = tabPageBodies[currentIndex];
          });
        },
      ),
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: tabPageBodies,
      // ),
      body: currentPage,
    );
  }
}
