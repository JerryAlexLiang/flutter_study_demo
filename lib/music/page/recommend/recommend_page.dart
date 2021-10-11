import 'package:flutter_study_demo/music/model/music_recommend_model.dart';
import 'package:flutter_study_demo/music/page/recommend/recommend_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendPage extends GetView<RecommendController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.loadState.value == LoadState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.loadState.value == LoadState.success) {
          return Center(
            // child: homeBody(controller.playlistList),
            child: SmartRefresher(
              controller: controller?.refreshController,
              // child: ListView.builder(
              //   itemCount: controller?.recommendList?.length,
              //   itemBuilder: (context, index) =>
              //       _recommendWidget(controller.recommendList, index),
              // ),

              child: ListView(
                children: _buildList(controller.recommendList),
              ),
            ),
          );
        } else if (controller.loadState.value == LoadState.empty) {
          return Center(
            child: Text('暂时无数据'),
          );
        } else if (controller.loadState.value == LoadState.fail) {
          return Center(
            child: Text('数据请求失败'),
          );
        }
        return null;
      }),
    );
  }

  _recommendWidget(RxList<PrettyList> recommendList, int index) {
    var model = recommendList[index];
    var name = model.name;

    return Container(
      child: Center(
        child: Text(name),
      ),
    );
  }

  List<Widget> _buildList(RxList<PrettyList> recommendList) {
    var list = recommendList
        .map((element) => Container(
              color: Colors.red,
              child: Center(
                child: Text(element.name),
              ),
            ))
        .toList();

    return list;
  }
}
