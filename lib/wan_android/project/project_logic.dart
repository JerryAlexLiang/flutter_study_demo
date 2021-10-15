import 'package:flutter/material.dart';
import 'package:flutter_study_demo/http/LoadState.dart';
import 'package:flutter_study_demo/http/dio_method.dart';
import 'package:flutter_study_demo/http/dio_util.dart';
import 'package:flutter_study_demo/music/page/utils/paging_state.dart';
import 'package:flutter_study_demo/wan_android/project/wan_article_model.dart';
import 'package:flutter_study_demo/wan_android/project/wan_articles_model.dart';
import 'package:flutter_study_demo/wan_android/project/wan_projects_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectLogic extends GetxController with SingleGetTickerProviderMixin {
  final projects = List<ProjectsModel>.empty(growable: true).obs;
  final currentProject = ProjectsModel().obs;
  final articles = List<WanArticleModel>.empty(growable: true).obs;

  var _cid = 0.obs;
  int _pageIndex = 1;

  var loadState = LoadState.loading.obs;

  //分页状态
  PagingState pagingState = PagingState();

  //结果页 tab view 控制器
  TabController tabController;

  //Pull To Refresh Controller 刷新插件控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void setId(int id) {
    _cid.value = id;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: projects.length, vsync: this);
    print('=======> ProjectLogic onInit()');
  }

  @override
  void onReady() {
    super.onReady();
    initProjectList();
    print('=======> ProjectLogic onReady()');
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    refreshController.dispose();

    print('=======> ProjectLogic onClose()');
  }

  initProjectList() async {
    try {
      loadState(LoadState.loading);
      //项目分类 项目为包含一个分类，该接口返回整个分类。 https://www.wanandroid.com/project/tree/json
      var result =
          await DioUtil().request("/project/tree/json", method: DioMethod.get);
      print('========>  init projectList success 0  $result  ');
      var model = WanProjectsModel.fromJson(result);
      print('========>  init projectList success 1  ${model.toJson()}  ');

      if (model != null && model.data != null && model.data.length > 0) {
        projects.assignAll(model.data);
        //默认定位第一个导航栏
        currentProject.value = projects[0];

        tabController = TabController(length: projects.length, vsync: this);

        loadState(LoadState.success);
      } else {
        loadState(LoadState.empty);
      }
    } on Exception catch (e) {
      loadState(LoadState.fail);
      Get.snackbar('Error', 'init projectList error...${e.toString()}');
    }
  }

  initArticleList([canRefreshMore = false]) async {
    try {
      if (!canRefreshMore) {
        loadState(LoadState.loading);
      }

      //项目列表数据 https://www.wanandroid.com/project/list/1/json?cid=294
      //cid 分类的id，上面项目分类接口  页码：拼接在链接中，从1开始。
      //该接口支持传入page_size 控制分页数量，取值为[1-40]，不传则使用默认值，一旦传入了 page_size，后续该接口分页都需要带上，否则会造成分页读取错误。

      //HttpManager.instance.get("project/list/$_pageIndex/json", params: {"cid": _cid.value}, list: true, refresh: refresh),

      var result = await DioUtil().request("/project/list/$_pageIndex/json",
          method: DioMethod.get, params: {"cid": _cid.value});
      print('========>  init articleList success 0  $result  ');

      var model = WanArticlesModel.fromJson(result);
      print('========>  init articleList success 1  ${model.toJson()}  ');

      // if (model != null &&
      //     model.data != null &&
      //     model.data.datas != null &&
      //     model.data.datas.length > 0) {
      //   if (!refresh) {
      //     loadState(LoadState.success);
      //   } else {
      //     refreshController.refreshCompleted();
      //   }
      //   articles.assignAll(model.data.datas);
      // } else {
      //   if (!refresh) {
      //     loadState(LoadState.empty);
      //   } else {
      //     refreshController.refreshCompleted();
      //   }
      // }

      if (_pageIndex == 1) {
        if (model != null &&
            model.data != null &&
            model.data.datas != null &&
            model.data.datas.length > 0) {
          if (!canRefreshMore) {
            loadState(LoadState.success);
          } else {
            refreshController.refreshCompleted();
          }
          articles.assignAll(model.data.datas);
        } else {
          if (!canRefreshMore) {
            loadState(LoadState.empty);
          } else {
            refreshController.refreshFailed();
          }
        }
      } else {
        if (model != null &&
            model.data != null &&
            model.data.datas != null &&
            model.data.datas.length > 0) {
          if (!canRefreshMore) {
            loadState(LoadState.success);
          } else {
            refreshController.loadComplete();
          }
          articles.addAll(model.data.datas);
        } else {
          if (!canRefreshMore) {
            loadState(LoadState.empty);
          } else {
            refreshController.loadNoData();
          }
        }
      }
    } on Exception catch (e) {
      loadState(LoadState.fail);
      refreshController.loadFailed();
      refreshController.refreshFailed();
      Get.snackbar('Error', 'init articleList error...${e.toString()}');
    }
  }

  void refreshArticleList() {
    _pageIndex = 1;
    initArticleList(true);
  }

  void loadMoreArticleList() {
    _pageIndex++;
    initArticleList(true);
  }

// void changeTabListener() {
//   if (tabController != null && tabController.length > 0) {
//     tabController.addListener(() {
//       //TabBar之TabController.addListener bug:
//       //点击切换tab的时候执行了一个动画效果，滑动切换的时候是没有的，在这个过程中触发了一次Listener。
//
//       if (tabController.index == tabController.animation.value) {
//         currentProject.value = projects[tabController.index];
//         print(
//             '=======> ProjectLogic changeTabListener() 1  ${currentProject.value.name}');
//         print(
//             '=======> ProjectLogic changeTabListener() 2  ${projects[tabController.index].name}');
//       }
//
//       initArticleList(currentProject.value.id);
//     });
//   }
// }
}
