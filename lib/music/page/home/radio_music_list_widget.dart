import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class RadioMusicListWidget extends StatelessWidget {
  final List<RadioItem> radioItemList;

  RadioMusicListWidget({Key key, this.radioItemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: radioItemList?.length,
          itemBuilder: (context, index) =>
              _radioItemWidget(radioItemList[index]),
        ),
      );
    });
  }

  _radioItemWidget(RadioItem radioItem) {
    var newCountPlay =
        (double.parse(radioItem.countPlay) / 10000).toStringAsFixed(1);

    return GestureDetector(
      onTap: () => Fluttertoast.showToast(msg: '${radioItem.name}'),
      child: Container(
        width: Get.width / 4 * 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        radioItem.pic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(0.3),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
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
                              '$newCountPlay万',
                              style: Get.theme.primaryTextTheme.overline,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: radioRightList(radioItem),
                  ),
                ),
                SizedBox(
                  width: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> radioRightList(RadioItem radioItem) {
    List<Widget> list = [];

    list.add(
        _radioContent(radioItem.name, Colors.red, 14, TextOverflow.ellipsis));
    list.add(_radioContent(radioItem.desc, Colors.black, 12, null));
    list.add(_radioContent(
        radioItem.artistName, Colors.black, 12, TextOverflow.ellipsis));

    return list;
  }

  Widget _radioContent(
      String value, Color color, double fontSize, TextOverflow textOverflow) {
    return Text(
      '$value',
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
      overflow: textOverflow,
    );
  }
}
