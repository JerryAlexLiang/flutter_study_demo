import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:flutter_study_demo/music/page/home/play_list_card_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class MusicHomePlayListWidget extends StatelessWidget {
  final List<PlaylistItem> playlistList;

  MusicHomePlayListWidget({Key key, this.playlistList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: GridView.builder(
          //去除GridView上方空白
          padding: EdgeInsets.zero,
          // padding: EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 0.7,
          ),
          itemCount: playlistList?.length,
          itemBuilder: (context, index) =>
              recommendMusicItem(playlistList[index]),
        ),
      );
    });
  }

  recommendMusicItem(PlaylistItem playlistItem) {
    return Container(
      // child: Image.network(
      //   playlistItem?.pic,
      //   fit: BoxFit.cover,
      // ),
      child: PlayListCardWidget(
        playlistItem: playlistItem,
      ),
    );
  }
}
