import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlayListCardWidget extends StatelessWidget {
  final PlaylistItem playlistItem;

  PlayListCardWidget({Key key, this.playlistItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: () => Fluttertoast.showToast(msg: '${playlistItem.name}'),
          child: Container(
            child: Column(
              children: [
                PhysicalModel(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Container(
                        child: FadeInImage(

                        ),
                      ),
                    ],
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
