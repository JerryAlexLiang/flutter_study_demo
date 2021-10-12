import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/api/http/music_http_manager.dart';
import 'package:flutter_study_demo/music/model/music_rank_detail_model.dart';
import 'package:flutter_study_demo/music/page/utils/paging_state.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum LoadState { loading, fail, success, empty }

class RankDetailController extends GetxController {
  //接收到的传递参数
  String id; //props id
  String label;

  //头部透明比例
  final percent = 0.0.obs;

  //排行榜详情对象Data
  var rankDetailModel = Data().obs;
  var rankDetailList = List<ListElement>.empty(growable: true).obs;

  var isLoading = true.obs;

  var loadState = LoadState.loading.obs;

  //滚动控制器
  ScrollController scrollController = ScrollController();

  //下拉刷新控制器
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  //分页加载状态管理
  PagingState pagingState = PagingState();

  @override
  void onInit() {
    super.onInit();
    //接收到的传递参数
    id = Get.arguments['id'];
    label = Get.arguments['label'];
    //滑动监听
    scrollController.addListener(() {
      double scrollerPercent = scrollController.offset / 140;
      if (scrollerPercent < 0) {
        scrollerPercent = 0;
      } else if (scrollerPercent > 1.0) {
        scrollerPercent = 1.0;
      }
      percent.value = scrollerPercent;
      print('=======> 滑动监听: ${percent.value}');
    });
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  //首次加载数据
  void loadData() async {
    try {
      loadState(LoadState.loading);
      var response = await MusicHttpManager.getRankDetailModel(id,
          pn: pagingState.page, rn: pagingState.pageNum);
      print(
          '=============> rank detail id: $id pn: ${pagingState.page}  rn:  ${pagingState.pageNum}');
      if (response.statusCode == 200) {
        // var musicRankDetailModel = MusicRankDetailModel.fromJson(response.data);
        var musicRankDetailModel =
            musicRankDetailModelFromJson(response.toString());

        if (musicRankDetailModel.success) {
          if (musicRankDetailModel != null &&
              musicRankDetailModel.data != null) {
            loadState(LoadState.success);
            rankDetailModel.value = musicRankDetailModel.data;
            rankDetailList.assignAll(musicRankDetailModel.data.list);
            // pagingState.total = musicRankDetailModel.data.total as int;
            pagingState.total = int.parse(musicRankDetailModel.data.total);
          } else {
            loadState(LoadState.empty);
            Get.snackbar('Empty', 'data empty...');
          }
        } else {
          loadState(LoadState.fail);
          Get.snackbar('Error', 'load error...');
        }
      } else {
        loadState(LoadState.fail);
        Get.snackbar('Error', 'load error...');
        print('rank detail fail');
      }
    } on Exception catch (e) {
      loadState(LoadState.fail);

      Get.snackbar('Error', 'load error...${e.toString()}');
      print('=============>  rank detail error ${e.toString()}');
    }
  }

  //下拉刷新
  void refreshData() async {
    pagingState.reset();
    try {
      var response = await MusicHttpManager.getRankDetailModel(id,
          pn: pagingState.page, rn: pagingState.pageNum);
      print(
          '=============> rank detail refresh id: $id pn: ${pagingState.page}  rn:  ${pagingState.pageNum}');
      if (response.statusCode == 200) {
        var model = musicRankDetailModelFromJson(response.toString());
        if (model.success) {
          if (model != null && model.data != null) {
            refreshController.refreshCompleted();
            //使用 "assign "和" assignAll "。 "assign "会清除你的List，并添加一个单个对象。 "assignAll "将清除现有的List，并添加任何可迭代对象。
            rankDetailModel.value = model.data;
            rankDetailList.assignAll(model.data.list);
          } else {
            refreshController.refreshFailed();
            Get.snackbar('Empty', 'data empty...');
          }
        } else {
          refreshController.refreshFailed();
          Get.snackbar('Error', 'load refresh error...');
        }
      } else {
        refreshController.refreshFailed();
        Get.snackbar('Error', 'load refresh error...');
      }
    } on Exception catch (e) {
      refreshController.refreshFailed();
      Get.snackbar('Error', 'load refresh error...${e.toString()}');
      print('=============>  rank detail refresh error ${e.toString()}');
    }
  }

  //加载更多数据
  void loadMoreData() async {
    pagingState.nextPage();

    if (pagingState.isEnd) return refreshController.loadNoData();

    try {
      var response = await MusicHttpManager.getRankDetailModel(id,
          pn: pagingState.page, rn: pagingState.pageNum);
      print(
          '=============> rank detail loadMore id: $id pn: ${pagingState.page}  rn:  ${pagingState.pageNum}');
      if (response.statusCode == 200) {
        var model = musicRankDetailModelFromJson(response.toString());
        if (model.success) {
          if (model != null && model.data != null) {
            refreshController.loadComplete();
            rankDetailModel.value = model.data;
            rankDetailList.addAll(model.data.list);
          } else {
            refreshController.loadFailed();
            pagingState.page--;
            Get.snackbar('Empty', 'data empty...');
          }
        } else {
          refreshController.loadFailed();
          pagingState.page--;
          Get.snackbar('Error', 'loadMore error...');
        }
      } else {
        refreshController.loadFailed();
        pagingState.page--;
        Get.snackbar('Error', 'loadMore error...');
      }
    } on Exception catch (e) {
      refreshController.loadFailed();
      pagingState.page--;
      Get.snackbar('Error', 'loadMore error...');
      print('=============>  rank detail loadMore error ${e.toString()}');
    }
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    refreshController.dispose();
  }
}
