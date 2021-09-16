import 'package:flutter/material.dart';
import 'package:flutter_study_demo/page/home_list_page.dart';
import 'package:flutter_study_demo/page/knowledge_system_tree_page.dart';

import '../custom_router.dart';
import 'simple_list_page.dart';

/// 主页面
class WanAndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeMainPage());
  }
}

class HomeMainPage extends StatefulWidget {
  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  var currentPage = 0;

  PageController _pageController;

  final appBarTitles = ['知识', '视频'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF2962FF),
        accentColor: Color(0xFF2962FF),
        textTheme: TextTheme(
          //设置Material的默认字体样式
          bodyText1: TextStyle(
            color: Color(0xFF888888),
            fontSize: 16.0,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF2962FF), size: 25.0),
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     appBarTitles[currentPage],
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(
        //         Icons.search,
        //         color: Colors.white,
        //       ),
        //       onPressed: null,
        //     )
        //   ],
        // ),
        body: getHomeMainBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => SimpleListPage()),
                CustomRoute(SimpleListPage()));
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                tooltip: '首页',
                // highlightColor: Colors.blue,
                // splashColor: Colors.blue,
                onPressed: () {
                  setState(() {
                    currentPage = 0;
                    //直接转到相应页面,没得啥动画效果   并且不会经过中间的页面,上面的那个会经过中间页
                    _pageController.jumpToPage(currentPage);
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.movie),
                tooltip: '视频',
                // highlightColor: Colors.blue,
                // splashColor: Colors.blue,
                onPressed: () {
                  setState(() {
                    currentPage = 1;
                    //直接转到相应页面,没得啥动画效果   并且不会经过中间的页面,上面的那个会经过中间页
                    _pageController.jumpToPage(currentPage);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getHomeMainBody() {
    return Column(
      children: [
        //上面把空间占满
        Expanded(
          child: PageView(
            children: [
              HomeListPage(),
              KnowledgeSystemPage(),
            ],
            //设置controller，可以控制PageView的当前页
            controller: _pageController,
            //滑动切换控制
            //BouncingScrollPhysics是用来适用于
            //允许滚动偏移超出内容范围，然后将内容反弹到那些范围边缘的环境的滚动物理。iOS上经常有这种效果
            physics: BouncingScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
          ),
        ),
        // //底部的BottomNavigationBar
        // BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       title: Text(appBarTitles[0]),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.movie),
        //       title: Text(appBarTitles[1]),
        //     ),
        //   ],
        //   // selectedItemColor: Colors.red,
        //   onTap: (page) {
        //     //滑动到相应页面   curve是动画效果
        //     // _pageController.animateToPage(page,
        //     //     duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        //     //直接转到相应页面,没得啥动画效果   并且不会经过中间的页面,上面的那个会经过中间页
        //     _pageController.jumpToPage(page);
        //   },
        //   currentIndex: currentPage,
        // ),

        //底部的BottomNavigationBar

        //底部工具栏BottomAppBar，比BottomNavigationBar widget灵活很多，可以放置文字和图标，当然也可以放置容器
      ],
    );
  }
}
