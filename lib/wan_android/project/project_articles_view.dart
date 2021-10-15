import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/http/LoadState.dart';
import 'package:flutter_study_demo/wan_android/home/wan_home_article_list_item.dart';
import 'package:flutter_study_demo/wan_android/project/project_logic.dart';
import 'package:flutter_study_demo/wan_android/project/wan_article_model.dart';
import 'package:flutter_study_demo/widget/simple_empty_widget.dart';
import 'package:flutter_study_demo/widget/simple_loading_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Flutter GetX框架学习-页面保活 - 懒加载
class ProjectArticlesPage extends StatefulWidget {
  final int id;

  const ProjectArticlesPage({Key key, this.id}) : super(key: key);

  @override
  State<ProjectArticlesPage> createState() => _ProjectArticlesPageState();
}

class _ProjectArticlesPageState extends State<ProjectArticlesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //使用PageView时，所有PageView页面控制器，全被初始化问题
    //PageView页面，初始化位置必须调整
    final controller = Get.put(ProjectLogic(), tag: widget.id.toString());

    controller.setId(widget.id);
    controller.initArticleList();

    return Obx(() {
      if (controller.loadState.value == LoadState.loading) {
        return SimpleLoadingWidget(
          type: StringConfig.SIMPLE_CUPERTINO_LOADING_WIDGET,
        );
      } else if (controller.loadState.value == LoadState.success) {
        return Container(
          child: _buildArticles(controller),
        );
      } else if (controller.loadState.value == LoadState.empty) {
        return SimpleEmptyWidget(
          type: StringConfig.SIMPLE_EMPTY_WIDGET,
          callback: () => controller.initArticleList(),
        );
      } else if (controller.loadState.value == LoadState.fail) {
        return SimpleEmptyWidget(
          type: StringConfig.SIMPLE_ERROR_WIDGET,
          callback: () => controller.initArticleList(),
        );
      }
      return null;
    });
  }

  Widget _buildArticles(ProjectLogic controller) {
    return Container(
      child: Center(
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.refreshArticleList(),
          onLoading: () => controller.loadMoreArticleList(),
          child: ListView(
            children: controller.articles
                .map((element) => _articleListItem(element))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _articleListItem(WanArticleModel item) {
    return Container(
      width: Get.width,
      height: ScreenUtil().setHeight(200),
      color: Colors.grey.withOpacity(0.1),
      child: Center(
        child: WanHomeArticleListItem(item),
      ),
    );
  }
}
