import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RankMusicRectangleWidget extends StatelessWidget {
  final RankItem rankItem;

  RankMusicRectangleWidget({Key key, this.rankItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Fluttertoast.showToast(msg: 'msg2'),
      child: Container(
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
                child: Center(
                  child: Text('dd'),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.assetNetwork(
                  width: 100,
                  height: 100,
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
}
