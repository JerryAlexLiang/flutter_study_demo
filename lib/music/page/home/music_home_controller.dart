import 'dart:convert';

import 'package:flutter_study_demo/music/api/http/music_http_manager.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum LoadState { loading, fail, success, empty }

class MusicHomeController extends GetxController {
  RefreshController refreshController;

  var bannerList = List<BannerItem>.empty(growable: true).obs;
  var playlistList = List<PlaylistItem>.empty(growable: true).obs;
  var rankList = List<RankItem>.empty().obs;
  var radioList = List<RadioItem>.empty().obs;

  Rx<Future> futureX = Rx<Future>(null);

  var isLoading = true.obs;

  var loadState = LoadState.loading.obs;

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

            print('========> initData: ${bannerList.length}');
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
    try {
      var response = await MusicHttpManager.getMusicHomeModel();
      if (response.statusCode == 200) {
        var musicHomeModel = MusicHomeModel.fromJson(response.data);
        if (musicHomeModel.success) {
          if (musicHomeModel != null && musicHomeModel.data != null) {
            refreshController.refreshCompleted();
            bannerList.assignAll(musicHomeModel.data.bannerList);
            playlistList.assignAll(musicHomeModel.data.playlistList);

            print('========> refreshData: ${bannerList.length}');
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
}
