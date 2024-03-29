import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/chat/chat_ui_page.dart';
import 'package:flutter_study_demo/model/bottom_bar_choice.dart';
import 'package:flutter_study_demo/page/sliver_list_page.dart';
import 'package:flutter_study_demo/provider/current_Index_provider.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:flutter_study_demo/todoList/todo_list_page.dart';
import 'package:flutter_study_demo/wan_android/home/wan_home_page.dart';
import 'package:flutter_study_demo/wan_android/navigation/navigation_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class MainNewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () {
        // return MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   localizationsDelegates: [],
        //   // home: IndexPage(),
        //   home: IndexPageProvider(),
        //   //借助MaterialApp的theme属性，可以为应用程序管理全局主题
        //   // theme属性接受一个ThemeData对象，在ThemeData对象中，可以通过配置各个属性来确定各个主题值
        //   theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //   ),
        // );

        //在代码中定义OKToast组件，包裹你的 MaterialApp,不是包裹你的 Scaffold
        // return OKToast(
        //   child: MaterialApp(
        //     debugShowCheckedModeBanner: false,
        //     localizationsDelegates: [],
        //     // home: IndexPage(),
        //     home: IndexPageProvider(),
        //     //借助MaterialApp的theme属性，可以为应用程序管理全局主题
        //     // theme属性接受一个ThemeData对象，在ThemeData对象中，可以通过配置各个属性来确定各个主题值
        //     theme: ThemeData(
        //       primarySwatch: Colors.blue,
        //     ),
        //   ),
        // );

        //使用FlutterEasyLoading组件包裹App组件
        //子组件通常为 [MaterialApp] 或者 [CupertinoApp].
        //这样做是为了确保loading组件能覆盖在其他组件之上.
        return FlutterEasyLoading(
          child: OKToast(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [],
              // home: IndexPage(),
              home: IndexPageProvider(),
              //借助MaterialApp的theme属性，可以为应用程序管理全局主题
              // theme属性接受一个ThemeData对象，在ThemeData对象中，可以通过配置各个属性来确定各个主题值
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
            ),
          ),
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
      icon: Icon(Icons.navigation_outlined),
      label: '导航',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: '聊天',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: '学习',
    ),
  ];

  final bottomIconList = [
    BottomBarChoice(title: "首页", icon: Icons.home),
    BottomBarChoice(title: "导航", icon: Icons.navigation_outlined),
    BottomBarChoice(),
    BottomBarChoice(title: "聊天", icon: Icons.chat),
    BottomBarChoice(title: "学习", icon: Icons.list),
  ];

  final List<Widget> tabPageBodies = [
    WanHomePage(),
    // TodoListPage('TodoList'),
    NavigationPage(),
    SizedBox(),
    ChatUIPage(),
    SliverListPage(),
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

    DateTime _lastDateTime;

    return Scaffold(
      // 底部凸起凹陷导航栏
      floatingActionButton: FloatingActionButton(
        heroTag: "BottomAppBar",
        onPressed: () => Get.toNamed(AppRoutes.MUSIC_HOME_PAGE),
        child: Icon(
          Icons.music_note_rounded,
        ),
      ),
      // 底部凸起凹陷导航栏位置
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),

      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: currentIndex,
      //   items: bottomTabs,
      //   onTap: (index) {
      //     // 扩展 BuildContext，添加 read 方法，具体看附录
      //     // context.read<T> 实际调用的是 Provider.of<T>
      //     context.read<CurrentIndexProvider>().changeIndex(index);
      //     // Provider.of<CurrentIndexProvider>(context, listen: false).changeIndex(index);
      //     // Provider.of<CurrentIndexProvider>(context,listen: true).changeIndex(index);
      //     // Provider.of<CurrentIndexProvider>(context).changeIndex(index);
      //   },
      // ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: bottomTabs2(context, currentIndex),
        ),
      ),
      body: WillPopScope(
        child: IndexedStack(
          index: currentIndex,
          children: tabPageBodies,
        ),
        onWillPop: () {
          if (_lastDateTime == null ||
              DateTime.now().difference(_lastDateTime) > Duration(seconds: 1)) {
            _lastDateTime = DateTime.now();
            showToast(
              "再次点击退出程序",
              backgroundColor: Theme.of(context).primaryColor,
              position: ToastPosition.center,
            );
            return Future.value(false);
          }
          return Future.value(true);
        },
      ),
    );
  }

  List<Widget> bottomTabs2(BuildContext context, int currentIndex) {
    var list = bottomIconList
        .map((e) => bottomTabsWidget(e, currentIndex, context))
        .toList();

    return list;
  }

  Widget bottomTabsWidget(
      BottomBarChoice e, int currentIndex, BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<CurrentIndexProvider>()
          .changeIndex(bottomIconList.indexOf(e)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Offstage(
          offstage: e.title != null ? false : true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                e.icon ?? null,
                color: currentIndex == bottomIconList.indexOf(e)
                    ? Colors.blue
                    : Colors.grey,
              ),
              Text(
                e.title ?? "",
                style: TextStyle(
                  color: currentIndex == bottomIconList.indexOf(e)
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class IndexPage extends StatefulWidget {
//   IndexPage({Key key}) : super(key: key);
//
//   @override
//   _IndexPageState createState() {
//     return _IndexPageState();
//   }
// }
//
// class _IndexPageState extends State<IndexPage> {
//   final List<BottomNavigationBarItem> bottomTabs = [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home),
//       label: '首页',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.book),
//       label: '知识',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.list),
//       label: '列表',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.network_check),
//       label: '网络',
//     )
//   ];
//
//   final List<Widget> tabPageBodies = [
//     HomeListPage(),
//     KnowledgeSystemPage(),
//     // SimpleListPage(),
//     StudyDemoNavigationPage(),
//     NetworkRequestPage()
//   ];
//
//   int currentIndex = 0;
//   var currentPage;
//
//   @override
//   void initState() {
//     //初始化默认选中Page
//     currentPage = tabPageBodies[currentIndex];
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         items: bottomTabs,
//         onTap: (index) {
//           //动态组件改变组建样式使用setState()
//           setState(() {
//             currentIndex = index;
//             currentPage = tabPageBodies[currentIndex];
//           });
//         },
//       ),
//       body: currentPage,
//     );
//   }
// }
