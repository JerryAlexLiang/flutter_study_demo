import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'home_list_page.dart';
import 'knowledge_system_tree_page.dart';
import 'net_work_request_page.dart';
import './provide/current_Index_provide.dart';
import 'simple_list_page.dart';
import 'study_demo_navigation_page.dart';

class MainNewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
      // home: IndexPageProvide(),
    );
  }
}

class IndexPageProvide extends StatelessWidget {
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
    // SimpleListPage(),
    StudyDemoNavigationPage(),
    NetworkRequestPage()
  ];

  IndexPageProvide({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<CurrentIndexProvide>(
      builder: (context, child, val) {
        int currentIndex =
            Provide.value<CurrentIndexProvide>(context).currentIndex;

        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              //Provide状态管理
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabPageBodies,
          ),
        );
      },
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
    // SimpleListPage(),
    StudyDemoNavigationPage(),
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
      body: currentPage,
    );
  }
}
