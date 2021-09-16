import 'dart:convert';

import 'package:flutter_study_demo/music/api/http/music_http_manager.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MusicHomeController extends GetxController {
  RefreshController refreshController;

  final bannerList = List<BannerItem>.empty(growable: true).obs;
  final playlistList = List<PlaylistItem>.empty(growable: true).obs;

  Rx<Future> futureX = Rx<Future>(null);

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
  }

  @override
  void onReady() {
    super.onReady();
    // loadData();
    loadData2();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  void loadData2() {
    Future future = MusicHttpManager.getMusicHomeModel().then((value) {
      if (value.statusCode == 200) {
        MusicHomeModel model = MusicHomeModel.fromJson(value.data);
        if (model.success) {
          if (model.data != null) {
            bannerList.addAll(model.data.bannerList);
            playlistList.assignAll(model.data.playlistList);
            print('====> music data : ${playlistList[0].name}');
            print('====> music data : ${bannerList[0].detail}');
          }
        } else {
          Get.snackbar('Error', 'load error...');
        }
      } else {
        Get.snackbar('Error', 'load error...');
      }
    }, onError: (e) {
      Get.snackbar('Error', e.toString());
    });
    futureX.value = future;
  }
}
