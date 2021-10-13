import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:get/get.dart';

class RankMusicRectangleWidget extends StatelessWidget {
  final RankItem rankItem;
  final int index;

  RankMusicRectangleWidget({Key key, this.rankItem, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.MUSIC_RANK_DETAIL_PAGE2,
        arguments: {'id': rankItem?.typeId, 'label': rankItem?.label},
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        width: Get.width,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 140,
                    right: 5,
                  ),
                  child: _rankMusicNameList(),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 35,
              child: Hero(
                tag: rankItem?.label,
                // tag: index,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'images/icon_music_bg.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.assetNetwork(
                  width: 120,
                  height: 120,
                  placeholder: 'images/icon_music_bg.jpg',
                  fit: BoxFit.cover,
                  image: rankItem?.picIcon ?? StringConfig.DEFAULT_IMAGE_URL,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rankMusicNameList() {
    List<Widget> songList = [];

    //label
    songList.add(_songRankLabel());

    //音乐榜单
    var list = rankItem.list;
    if (list != null && list.length > 0) {
      var list2 = list.map((e) => _rankMusic(e, list.indexOf(e))).toList();
      songList.addAll(list2);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: songList,
    );
  }

  Widget _songRankLabel() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${rankItem.label}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _rankMusic(RankMusicItem e, int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '${index + 1}. ${e.name} - ${e.artistName}',
        style: TextStyle(
          fontSize: 13,
          color: index == 0 ? Colors.red : Colors.black,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
