import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/page/home/music_home_page.dart';
import 'package:flutter_study_demo/page/automatic_keep_alive_page.dart';
import 'package:flutter_study_demo/wan_android/home/wan_home_page.dart';
import 'package:flutter_study_demo/wan_android/navigation/navigation_view.dart';
import 'package:flutter_study_demo/wan_android/project/project_view.dart';
import 'package:get/get.dart';

import '../automatic_keep_alive_page2.dart';
import '../automatic_keep_alive_page3.dart';
import 'home_page_view_logic.dart';

/// 首页导航-懒加载
class HomePageViewPage extends StatefulWidget {
  @override
  State<HomePageViewPage> createState() => _HomePageViewPageState();
}

class _HomePageViewPageState extends State<HomePageViewPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<HomePageViewLogic>();

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // @override
  // bool get wantKeepAlive => true;

  /// 内容页
  Widget buildPageView() {
    return PageView(
      //禁止滑动
      // physics: NeverScrollableScrollPhysics(),
      children: [
        AutomaticKeepAlivePage(),
        AutomaticKeepAlivePage2(),
        AutomaticKeepAlivePage3(),
      ],
      controller: controller.pageController,
      onPageChanged: (index) => controller.handlePageChanged(index),
    );
  }

  /// 底部导航栏
  Widget _buildBottomNavigationBar() {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      child: GetX<HomePageViewLogic>(
        init: controller,
        builder: (_) => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.page,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          selectedItemColor: Color.fromARGB(255, 73, 187, 65),
          onTap: (index) => controller.handleNavBarTap(index),
        ),
      ),
    );
  }
}
