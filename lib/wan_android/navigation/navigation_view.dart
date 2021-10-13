import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/http/LoadState.dart';
import 'package:flutter_study_demo/model/wan_home_article_bean.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:flutter_study_demo/utils/get_random_color.dart';
import 'package:flutter_study_demo/wan_android/navigation/wan_navigation_model.dart';
import 'package:flutter_study_demo/widget/simple_empty_widget.dart';
import 'package:get/get.dart';

import 'navigation_logic.dart';

class NavigationPage extends StatelessWidget {
  final controller = Get.put(NavigationLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('导航'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.loadState.value == LoadState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.loadState.value == LoadState.success) {
            return Container(
              child: _wanNavigationView(),
            );
          } else if (controller.loadState.value == LoadState.empty) {
            return SimpleEmptyWidget(
              type: StringConfig.SIMPLE_EMPTY_WIDGET,
              callback: () => controller?.loadData(),
            );
          } else if (controller.loadState.value == LoadState.fail) {
            return SimpleEmptyWidget(
              type: StringConfig.SIMPLE_ERROR_WIDGET,
              callback: () => controller?.loadData(),
            );
          }
          return null;
        }),
      ),
    );
  }

  Widget _wanNavigationView() {
    return Row(
      children: [
        Container(
          width: 200.w,
          child: _buildNavigation(),
        ),
        Expanded(
          child: _buildNavigationArticles(),
        ),
      ],
    );
  }

  Widget _buildNavigation() {
    var navigationList = controller.navigationList;
    var currentNavigation = controller.currentNavigation.value;

    var divider = Divider(
      height: 0,
    );

    return ListView.separated(
      itemBuilder: (context, index) {
        ///给InkWell内部的组件设置颜色，会导致给InkWell的点击水波纹效果消失，需要在外面套一层Ink或者MMaterial组件
        return Ink(
          color: navigationList[index].cid == currentNavigation.cid
              ? Colors.white
              : Colors.grey.withOpacity(0.1),
          child: InkWell(
            //点击导航item切换当前导航item值(currentNavigation)
            onTap: () => controller.changeNavigation(navigationList[index]),
            child: Container(
              // padding: EdgeInsets.symmetric(vertical: 20.h),
              height: 80.h,
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Offstage(
                    offstage: navigationList[index].cid == currentNavigation.cid
                        ? false
                        : true,
                    child: Container(
                      width: 5.w,
                      height: 80.h,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        navigationList[index].name ?? "",
                        style: TextStyle(
                          color:
                              navigationList[index].cid == currentNavigation.cid
                                  ? Colors.black
                                  : Colors.black54,
                          fontSize:
                              navigationList[index].cid == currentNavigation.cid
                                  ? 14
                                  : 12,
                          fontWeight:
                              navigationList[index].cid == currentNavigation.cid
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => divider,
      itemCount: navigationList.length,
    );
  }

  Widget _buildNavigationArticles() {
    var navigationDatum = controller.currentNavigation.value;
    if (navigationDatum == null) {
      return SimpleEmptyWidget(
        type: StringConfig.SIMPLE_ERROR_WIDGET,
        callback: () => controller?.loadData(),
      );
    }

    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: ScreenUtil().screenWidth - 200.w,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            color: Colors.white.withOpacity(0.5),
            child: Text(
              navigationDatum.name,
              style: TextStyle(fontSize: 35.sp),
            ),
          ),
          //不滚动标题，只滚动标签流式布局
          /// Column直接套子组件会超出
          Expanded(
            child: (navigationDatum.articles != null &&
                    navigationDatum.articles.length > 0)
                ? SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 10.w,
                      top: 10.h,
                      bottom: 10.h,
                    ),
                    child: _articlesWrap(navigationDatum),
                  )
                : SimpleEmptyWidget(
                    type: StringConfig.SIMPLE_EMPTY_WIDGET,
                    callback: () => controller?.loadData(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _articlesWrap(Datum navigationDatum) {
    List<Widget> wrapList =
        navigationDatum?.articles?.map((e) => _articleTitleWidget(e))?.toList();
    return Wrap(
      children: wrapList,
    );
  }

  Widget _articleTitleWidget(Article article) {
    Datas newArticle = Datas(link: article.link, title: article.title);

    return Container(
      ///使用DecoratedBox+InkWell看不到点击效果，需要使用Ink组件
      padding: EdgeInsets.all(10.w),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(
              AppRoutes.WAN_WEB_VIEW,
              arguments: newArticle,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
            child: Text(
              article.title ?? "",
              style: TextStyle(
                color: getRandomColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
