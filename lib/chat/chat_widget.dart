import 'package:flutter/material.dart';
import 'package:flutter_study_demo/chat/chat_item.dart';
import 'package:flutter_study_demo/chat/circle_image.dart';
import 'package:flutter_study_demo/chat/nine_point_box.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatWidget extends StatelessWidget {
  final ChatItem chatItem;

  ChatWidget({Key key, this.chatItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //是否在右侧
    bool isRight = chatItem.chatType == ChatType.right;
    return Container(
      //根据左右来构建UI组件
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: chatMessage(isRight),
    );
  }

  Row chatMessage(bool isRight) {
    return Row(
      mainAxisAlignment:
          isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //灵活之处
        if (isRight)
          Flexible(
            child: rightBox(),
          ),
        headImage(isRight),
        if (!isRight)
          Flexible(
            child: leftBox(),
          ),
      ],
    );
  }

  rightBox() {
    return NinePointBox(
      image: AssetImage('images/right_chat.png'),
      sliceRect: Rect.fromLTRB(6, 28, 60, 29),
      padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
      margin: EdgeInsets.only(left: 30),
      child: Text(
        chatItem.chatContent,
        style: TextStyle(fontSize: 16),
      ),
      onTap: () => Fluttertoast.showToast(msg: chatItem.chatContent),
    );
  }

  leftBox() {
    return NinePointBox(
      image: AssetImage('images/left_chat.png'),
      sliceRect: Rect.fromLTRB(14, 27, 69, 28),
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      margin: EdgeInsets.only(right: 30),
      child: Text(
        chatItem.chatContent,
        style: TextStyle(fontSize: 16),
      ),
      onTap: () => Fluttertoast.showToast(msg: chatItem.chatContent),
    );
  }

  headImage(bool isRight) {
    if (isRight) {
      return CircleImage(
        imageUrl: chatItem.headIconUrl,
        roundColor: Colors.red,
        shadowColor: Colors.yellow,
      );
    } else {
      return CircleImage(
        imageUrl: chatItem.headIconUrl,
        roundColor: Colors.blue,
        shadowColor: Colors.pink,
      );
    }
  }
}
