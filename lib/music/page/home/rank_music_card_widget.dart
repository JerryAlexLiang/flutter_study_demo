import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RankMusicCardWidget extends StatelessWidget {
  final RankItem rankItem;

  RankMusicCardWidget({Key key, this.rankItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Fluttertoast.showToast(msg: 'msg1'),
      child: Container(
        padding: EdgeInsets.all(6),
        width: (Get.width - 10 * 2) / 3 - 4,
        height: (Get.width - 10 * 2) / 3 - 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Container(
                child: Opacity(
                  opacity: 1,
                  child: FadeInImage.assetNetwork(
                    width: (Get.width - 5 * 2) / 3 - 4,
                    height: (Get.width - 5 * 2) / 3 - 4,
                    placeholder: 'images/icon_music_bg.jpg',
                    fit: BoxFit.cover,
                    image: rankItem?.picIcon ?? StringConfig.DEFAULT_IMAGE_URL,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Center(
                  // child: Text(
                  //   rankItem?.label ?? "致一音乐榜",
                  //   style: Get.theme.textTheme.bodyText1,
                  // ),
                  child: Icon(
                    Icons.music_note,
                    color: Colors.yellow.withOpacity(0.5),
                  ),
                ),
              ),
              Positioned(
                width: (Get.width - 10 * 2) / 3 - 10,
                left: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0.3),
                  ),
                  padding: EdgeInsets.only(
                    top: 3,
                    bottom: 3,
                    left: 3,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      //居左对齐
                      Icon(
                        Icons.music_note,
                        size: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        '${rankItem.total}首',
                        style: Get.theme.primaryTextTheme.bodyText2,
                      ),
                      //自动扩展挤压
                      Expanded(
                        child: SizedBox(),
                      ),
                      //右对齐
                      Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
