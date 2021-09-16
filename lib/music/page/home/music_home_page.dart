import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:flutter_study_demo/music/page/home/music_home_controller.dart';
import 'package:get/get.dart';

class MusicHomePage extends GetView<MusicHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// SafeArea：适配刘海屏和底部导航栏。否则内容会被遮住
      body: SafeArea(
        //使homeBodyntroller数据变化
        child: Obx(
          () => FutureBuilder(
            future: controller.futureX.value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    // child: Obx(() => homeBody(controller.playlistList)),
                    child: homeBody(controller.playlistList),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  homeBody(RxList<PlaylistItem> playlistList) {
    // ignore: invalid_use_of_protected_member
    var list = playlistList.value.map((e) => Text(e.name)).toList();
    return ListView(
      children: list,
    );
  }
}
