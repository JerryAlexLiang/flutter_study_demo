import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/config/service_url.dart';
import 'package:flutter_study_demo/custom_router.dart';
import 'package:flutter_study_demo/model/wan_home_article_bean.dart';
import 'package:flutter_study_demo/model/wan_home_banner_bean.dart';
import 'package:flutter_study_demo/service/service_method.dart';
import 'package:flutter_study_demo/todoList/todo_list_page.dart';
import 'package:flutter_study_demo/wan_android/home/home_eye_subject_page.dart';
import 'package:flutter_study_demo/wan_android/home/wan_home_article_list_item.dart';
import 'package:flutter_study_demo/wan_android/home/wan_home_swiper_banner.dart';
import 'package:flutter_study_demo/wan_android/project/wan_article_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'eye_category_list_page.dart';
import 'my_drawer.dart';

class WanHomePage extends StatefulWidget {
  WanHomePage({Key key}) : super(key: key);

  @override
  _WanHomePageState createState() {
    return _WanHomePageState();
  }
}

//混入AutomaticKeepAliveClientMixin，这是保持状态的关键
//然后重写wantKeepAlive 的值为true
class _WanHomePageState extends State<WanHomePage>
    with AutomaticKeepAliveClientMixin {
  String wanHomeBanner = '首页Banner';

  int page = 1;

  EasyRefreshController _controller = EasyRefreshController();

  List<WanArticleModel> articleDataList = [];

  // @override
  // bool get wantKeepAlive{
  //   return true;
  // }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // getWanHomeTopBanner().then((value) {
    //   setState(() {
    //     wanHomeBanner = value.toString();
    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('首页'),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Text(wanHomeBanner),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //FutureBuilder Widget 是 Flutter内置的组件，是用来等待异步请求的
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        // automaticallyImplyLeading: false,
        // leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () => Navigator.push(
              context,
              CustomRoute(TodoListPage('SQLite数据库 TodoList')),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getWanHomeTopBanner(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Flutter Dart 报错 '_InternalLinkedHashMap dynamic,
            // dynamic' is not a subtype of type'
            //类型转换错误，使用如下转换就可以了: new Map<String, dynamic>.from(params)
            Map map = new Map<String, dynamic>.from(snapshot.data);
            print('======>  =====>  =====>1   ${snapshot.data.toString()}');
            WanHomeBannerBean bean = WanHomeBannerBean.fromJson(map);
            print('======>  =====>  =====>2   $bean');

            // return SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       WanHomeSwiperBanner(bean),
            //       EyeCategoryListPage(),
            //       HomeEyeSubjectPage(),
            //       Container(
            //         color: Colors.white,
            //         height: 200,
            //         child: Center(
            //           child: Text('demo'),
            //         ),
            //       )
            //     ],
            //   ),
            // );

            //EasyRefresh很容易就能在Flutter应用上实现下拉刷新以及上拉加载操作，
            // 它支持几乎所有的Flutter控件，但前提是需要包裹成ScrollView。
            // 它的功能与Android的SmartRefreshLayout很相似，同样也吸取了很多三方库的优点。
            return EasyRefresh(
              firstRefresh: true,
              controller: _controller,
              child: ListView(
                shrinkWrap: true,
                //解决滑动事件冲突
                physics: NeverScrollableScrollPhysics(),
                children: [
                  WanHomeSwiperBanner(bean),
                  EyeCategoryListPage(),
                  HomeEyeSubjectPage(),
                  Container(
                    height: 5,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  _articleListPage(),
                ],
              ),
              onRefresh: () async {
                print('开始下拉刷新 currentPage: $page');

                await requestGet(WanAndroidApi.homeArticleList + "$page/json")
                    .then((value) {
                  WanHomeArticleBean bean = WanHomeArticleBean.fromJson(value);
                  List<WanArticleModel> list = bean.data.datas;

                  setState(() {
                    page = 1;
                    articleDataList.clear();
                    articleDataList.addAll(list);
                  });

                  _controller.finishRefresh(success: true);

                  print('下拉刷新成功 currentPage: $page');
                  print('开始加载更多 currentPage: $bean');
                });
              },
              onLoad: () async {
                print('开始加载更多 currentPage: $page');

                // await requestGet(WanAndroidApi.homeArticleList + "$page/json")
                //     .then((value) {
                //   WanHomeArticleBean bean = WanHomeArticleBean.fromJson(value);
                //   List<Datas> list = bean.data.datas;
                //
                //   setState(() {
                //     articleDataList.addAll(list);
                //     page++;
                //   });
                //
                //   _controller.finishLoad(success: true);
                //
                //   print('加载更多成功 currentPage: $page');
                //   print('加载更多成功 currentPage: $bean');
                // });

                var value2 = await requestGet(
                    WanAndroidApi.homeArticleList + "$page/json");
                WanHomeArticleBean bean = WanHomeArticleBean.fromJson(value2);
                List<WanArticleModel> list = bean.data.datas;

                setState(() {
                  articleDataList.addAll(list);
                  page++;
                });

                _controller.finishLoad(success: true);

                print('加载更多成功 currentPage: $page');
                print('加载更多成功 currentPage: $bean');
              },
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
      //抽屉菜单 drawer属性接受一个需要在抽屉栏中显示的抽屉组件，MyDrawer是自定义的无状态组件
      drawer: MyDrawer(),
    );
  }

  Widget _articleListPage() {
    if (articleDataList != null) {
      List<Widget> listWidget =
          articleDataList.map((e) => _articleListItem(e)).toList();

      return Wrap(
        spacing: 1,
        children: listWidget,
      );
    } else {
      return Center(
        child: Text('暂时没有文章数据~'),
      );
    }
  }

  Widget _articleListItem(WanArticleModel item) {
    // return InkWell(
    //   onTap: () {
    //     Fluttertoast.showToast(msg: item.title);
    //   },
    //   child: Container(
    //     // margin: EdgeInsets.only(bottom: 5),
    //     width: ScreenUtil().setWidth(750),
    //     height: ScreenUtil().setHeight(200),
    //     // color: Colors.blue,
    //     child: Center(
    //       child: WanHomeArticleListItem(item),
    //     ),
    //   ),
    // );
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(200),
      color: Colors.grey.withOpacity(0.1),
      child: Center(
        child: WanHomeArticleListItem(item),
      ),
    );
  }
}
