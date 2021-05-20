import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/provider/current_Index_provider.dart';
import 'package:flutter_study_demo/wan_android/home/wan_home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'home_list_page.dart';
import 'knowledge_system_tree_page.dart';
import 'net_work_request_page.dart';
import 'study_demo_navigation_page.dart';

class MainNewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [

          ],
          // home: IndexPage(),
          home: IndexPageProvider(),
        );
      },
    );
  }
}

class IndexPageProvider extends StatelessWidget {
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
    WanHomePage(),
    // HomeListPage(),
    KnowledgeSystemPage(),
    // SimpleListPage(),
    StudyDemoNavigationPage(),
    NetworkRequestPage()
  ];

  IndexPageProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (val) {
    //     return CurrentIndexProvider();
    //   },
    //   builder: (context, child) {
    //     int currentIndex = Provider.of<CurrentIndexProvider>(context).index;

    //     return Scaffold(
    //       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
    //       bottomNavigationBar: BottomNavigationBar(
    //         type: BottomNavigationBarType.fixed,
    //         currentIndex: currentIndex,
    //         items: bottomTabs,
    //         onTap: (index) {
    //           // 扩展 BuildContext，添加 read 方法，具体看附录
    //           // context.read<T> 实际调用的是 Provider.of<T>

    //           context.read<CurrentIndexProvider>().changeIndex(index);
    //           // Provider.of<CurrentIndexProvider>(context,listen: false).changeIndex(index);

    //           // Provider.of<CurrentIndexProvider>(context,listen: true).changeIndex(index);
    //           // Provider.of<CurrentIndexProvider>(context).changeIndex(index);
    //         },
    //       ),
    //       body: IndexedStack(
    //         index: currentIndex,
    //         children: tabPageBodies,
    //       ),
    //     );
    //   },
    // );

    int currentIndex = Provider.of<CurrentIndexProvider>(context).index;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          // 扩展 BuildContext，添加 read 方法，具体看附录
          // context.read<T> 实际调用的是 Provider.of<T>
          context.read<CurrentIndexProvider>().changeIndex(index);
          // Provider.of<CurrentIndexProvider>(context, listen: false).changeIndex(index);
          // Provider.of<CurrentIndexProvider>(context,listen: true).changeIndex(index);
          // Provider.of<CurrentIndexProvider>(context).changeIndex(index);
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabPageBodies,
      ),
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
