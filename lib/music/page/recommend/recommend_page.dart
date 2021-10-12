import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/music/page/home/music_home_playlist_widget.dart';
import 'package:flutter_study_demo/music/page/recommend/recommend_controller.dart';
import 'package:flutter_study_demo/widget/simple_empty_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendPage extends GetView<RecommendController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('推荐歌单'),
        actions: [
          recommendMusicType(),
        ],
      ),
      body: Obx(() {
        if (controller.loadState.value == LoadState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.loadState.value == LoadState.success) {
          return Container(
            child: recommendMusicView(),
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
    );
  }

  Obx recommendMusicType() {
    return Obx(() {
      return Row(
        children: [
          ChoiceChip(
            label: Text('热门'),
            selected: controller.recommendType.value == "热门",
            onSelected: (bool b) {
              return controller.recommendType("热门");
            },
          ),
          SizedBox(
            width: 3,
          ),
          ChoiceChip(
            label: Text('最新'),
            selected: controller.recommendType.value == "最新",
            onSelected: (bool b) => controller.recommendType("最新"),
          ),
          SizedBox(
            width: 3,
          ),
          ChoiceChip(
            label: Text('测试'),
            selected: controller.recommendType.value == "测试",
            onSelected: (bool b) => controller.recommendType("测试"),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      );
    });
  }

  Center recommendMusicView() {
    return Center(
      child: SmartRefresher(
        controller: controller?.refreshController,
        onRefresh: () => controller?.loadData(true),
        child: ListView(
          children: [
            SizedBox(
              height: 5,
            ),
            MusicHomePlayListWidget(
              playlistList: controller.recommendList,
            ),
          ],
        ),
      ),
    );
  }
}
