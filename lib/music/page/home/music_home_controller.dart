import 'package:flutter_study_demo/model/wan_home_article_bean.dart';
import 'package:flutter_study_demo/music/api/http/music_http_manager.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:flutter_study_demo/music/page/utils/wan_article_music_home_paging_state.dart';
import 'package:flutter_study_demo/wan_android/project/wan_article_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum LoadState { loading, fail, success, empty }

class MusicHomeController extends GetxController {
  RefreshController refreshController;

  var bannerList = List<BannerItem>.empty(growable: true).obs;
  var playlistList = List<PlaylistItem>.empty(growable: true).obs;
  var rankList = List<RankItem>.empty().obs;
  var radioList = List<RadioItem>.empty().obs;

  var articleBean = WanHomeArticleBean().obs;
  var articleList = List<WanArticleModel>.empty(growable: true).obs;

  Rx<Future> futureX = Rx<Future>(null);

  var isLoading = true.obs;

  var loadState = LoadState.loading.obs;

  //分页加载状态管理
  PagingState2 pagingState = PagingState2();

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  void loadData() async {
    // Future future = MusicHttpManager.getMusicHomeModel().then((value) {
    //       if (value.statusCode == 200) {
    //         MusicHomeModel model = MusicHomeModel.fromJson(value.data);
    //         if (model.success) {
    //           if (model.data != null) {
    //             bannerList.addAll(model.data.bannerList);
    //             playlistList.assignAll(model.data.playlistList);
    //             print('====> music data : ${playlistList[0].name}');
    //             print('====> music data : ${bannerList[0].detail}');
    //           }
    //         } else {
    //           Get.snackbar('Error', 'load error...');
    //         }
    //       } else {
    //         Get.snackbar('Error', 'load error...');
    //       }
    //     }, onError: (e) {
    //       Get.snackbar('Error', e.toString());
    //     });
    //     futureX.value = future;
    //   }

    // try {
    //   // isLoading(true);
    //   isLoading.value = true;
    //   var response = await MusicHttpManager.getMusicHomeModel();
    //   if (response.statusCode == 200) {
    //     var musicHomeModel = MusicHomeModel.fromJson(response.data);
    //     if (musicHomeModel.success) {
    //       if (musicHomeModel != null && musicHomeModel.data != null) {
    //         if (musicHomeModel.data.playlistList != null) {
    //           playlistList.assignAll(musicHomeModel.data.playlistList);
    //         }
    //         print('===========> music data: ${json.encode(playlistList)}');
    //       }
    //     } else {
    //       Get.snackbar('Error', 'load error...');
    //     }
    //   } else {
    //     Get.snackbar('Error', 'load error...');
    //   }
    // } finally {
    //   // isLoading(false);
    //   isLoading.value = false;
    // }

    try {
      loadState(LoadState.loading);
      // loadState.value = LoadState.loading;
      var response = await MusicHttpManager.getMusicHomeModel();
      if (response.statusCode == 200) {
        var musicHomeModel = MusicHomeModel.fromJson(response.data);
        if (musicHomeModel.success) {
          // //模拟空数据
          // musicHomeModel = null;
          // musicHomeModel.data = null;
          if (musicHomeModel != null && musicHomeModel.data != null) {
            loadState(LoadState.success);
            bannerList.assignAll(musicHomeModel.data.bannerList);
            playlistList.assignAll(musicHomeModel.data.playlistList);
            rankList.assignAll(musicHomeModel.data.rankList);
            radioList.assignAll(musicHomeModel.data.radioList);

            print('========> initData bannerList: ${bannerList.length}');
            print('========> initData playlistList: ${playlistList.length}');
            print('========> initData rankList: ${rankList.length}');
            print('========> initData radioList: ${radioList.length}');
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
      }
    } on Exception catch (e) {
      loadState(LoadState.fail);
      Get.snackbar('Error', 'load error...${e.toString()}');
    }
  }

  refreshData() async {
    pagingState.reset();

    try {
      var response = await MusicHttpManager.getMusicHomeModel();
      if (response.statusCode == 200) {
        var musicHomeModel = MusicHomeModel.fromJson(response.data);
        if (musicHomeModel.success) {
          if (musicHomeModel != null && musicHomeModel.data != null) {
            refreshController.refreshCompleted();
            //使用 "assign "和" assignAll "。 "assign "会清除你的List，并添加一个单个对象。 "assignAll "将清除现有的List，并添加任何可迭代对象。
            bannerList.assignAll(musicHomeModel.data.bannerList);
            playlistList.assignAll(musicHomeModel.data.playlistList);
            rankList.assignAll(musicHomeModel.data.rankList);
            radioList.assignAll(musicHomeModel.data.radioList);

            articleBean.value = null;
            articleList.clear();

            print('========> refreshData bannerList: ${bannerList.length}');
            print('========> refreshData playlistList: ${playlistList.length}');
            print('========> refreshData rankList: ${rankList.length}');
            print('========> refreshData radioList: ${radioList.length}');
          } else {
            refreshController.refreshFailed();
            Get.snackbar('Empty', 'data empty...');
          }
        } else {
          refreshController.refreshFailed();
          Get.snackbar('Error', 'load error...');
        }
      } else {
        refreshController.refreshFailed();
        Get.snackbar('Error', 'load error...');
      }
    } on Exception catch (e) {
      refreshController.refreshFailed();
      Get.snackbar('Error', 'load error...${e.toString()}');
    }
  }

  void loadMoreArticleList() async {

    print('=============> wan article loadMore page1 : ${pagingState.page}');

    pagingState.nextPage();

    // if (pagingState.isEnd) return refreshController.loadNoData();
    try {
      var response = await MusicHttpManager.getWanHomeArticleList(
          pagingState.page, pagingState.pageNum);
      print('=============> wan article loadMore page2 : ${pagingState.page}');
      if (response.statusCode == 200) {
        var model = WanHomeArticleBean.fromJson(response.data);
        refreshController.loadComplete();
        articleBean.value = model;
        articleList.addAll(model.data.datas);
        pagingState.total = model.data.total;
        if (pagingState.isEnd) return refreshController.loadNoData();
        print(
            '=============>  wan article loadMore success1 ${model.data.datas.length}');
        print(
            '=============>  wan article loadMore success2 ${articleList.length}');
      } else {
        refreshController.loadFailed();
        pagingState.page--;
        Get.snackbar('Error', 'wan article loadMore error...');
        print('=============>  wan article loadMore error');
      }
    } on Exception catch (e) {
      refreshController.loadFailed();
      pagingState.page--;
      Get.snackbar('Error', 'wan article loadMore error...');
      print('=============>  wan article loadMore error ${e.toString()}');
    }
  }
}
