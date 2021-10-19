import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageViewLogic extends GetxController {
  /// 响应式成员变量
  /// 当前页面index
  final _page = 0.obs;

  set page(value) => this._page.value = value;

  get page => this._page.value;

  /// PageView页面控制器
  PageController pageController;

  /// 底部BottomNavigationBarItem
  List<BottomNavigationBarItem> bottomTabs;

  /// 底部tap点击切换PageView
  void handleNavBarTap(int currentPage){
    pageController.jumpToPage(currentPage);
  }

  /// tab栏PageView页面index切换
  void handlePageChanged(int currentPage){
    page = currentPage;
  }

  /// 生命周期
  ///在 widget 内存中分配后立即调用。
  ///可以用它来为控制器初始化 initialize 一些东西。
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: page);

    /// 初始静态数据
    bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.article_outlined,
          color: Color.fromARGB(255, 145, 145, 145),
          size: 23,
        ),
        activeIcon: Icon(
          Icons.article_rounded,
          color: Color.fromARGB(255, 73, 187, 65),
          size: 32,
        ),
        label: '首页',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.music_note_outlined,
          color: Color.fromARGB(255, 145, 145, 145),
          size: 23,
        ),
        activeIcon: Icon(
          Icons.music_note_rounded,
          color: Color.fromARGB(255, 73, 187, 65),
          size: 32,
        ),
        label: '音乐',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.navigation_outlined,
          color: Color.fromARGB(255, 145, 145, 145),
          size: 23,
        ),
        activeIcon: Icon(
          Icons.navigation_rounded,
          color: Color.fromARGB(255, 73, 187, 65),
          size: 32,
        ),
        label: '导航',
      ),
    ];
  }

  ///在 onInit() 之后调用 1 帧。这是进入的理想场所
  ///导航事件，例如 snackbar、对话框或新route，或async 异步请求。
  @override
  void onReady() {
    super.onReady();
    // async 拉取数据
  }

  ///在 [onDelete] 方法之前调用。 [onClose] 可能用于
  ///处理控制器使用的资源。就像 closing events 一样，
  ///或在控制器销毁之前的流。
  ///或者处置可能造成一些内存泄漏的对象，
  ///像 TextEditingControllers、AnimationControllers。
  ///将一些数据保存在磁盘上也可能很有用。
  @override
  void onClose() {
    super.onClose();
    // 1 stop & close 关闭对象
    // 2 save 持久化数据
  }

  ///dispose 释放内存
  @override
  void dispose() {
    // dispose释放对象
    pageController.dispose();
    super.dispose();
  }
}
