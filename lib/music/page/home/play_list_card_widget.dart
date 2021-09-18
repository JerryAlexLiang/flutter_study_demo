import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PlayListCardWidget extends StatelessWidget {
  final PlaylistItem playlistItem;

  PlayListCardWidget({Key key, this.playlistItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var newCountPlay =
        (double.parse(playlistItem.countPlay) / 10000).toStringAsFixed(1);
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Fluttertoast.showToast(msg: '${playlistItem.name}'),
          child: Container(
            padding: EdgeInsets.only(
              top: 5,
              left: 5,
              right: 5,
            ),
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        // padding: EdgeInsets.only(bottom: 5),
                        child: PhysicalModel(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          clipBehavior: Clip.antiAlias,
                          child: FadeInImage(
                            placeholder: AssetImage('images/icon_music_bg.jpg'),
                            image: NetworkImage(playlistItem.pic),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              // bottomLeft: Radius.circular(10),
                              // topRight: Radius.circular(10),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 6,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 13,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                // '${playlistItem.countPlay}',
                                '$newCountPlay万',
                                style: Get.theme.primaryTextTheme.overline,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text(
                    '${playlistItem?.name ?? '动感音乐'}',
                    style: Get.theme.textTheme.bodyText2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
