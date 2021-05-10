import 'package:flutter/material.dart';

import 'home_list_page.dart';
import 'knowledge_system_tree_page.dart';
import 'net_work_request_page.dart';

class MainNewHomePage extends StatelessWidget {
  const MainNewHomePage({Key key}) : super(key: key);

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '知识'),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Network'),
  ];

  final List<Widget> tabBodies = [
    HomeListPage(),
    KnowledgeSystemPage(),
    NetworkRequestPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   currentIndex: cu,
        // ),
      ),
    );
  }
}
