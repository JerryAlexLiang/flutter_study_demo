import 'package:flutter/material.dart';
import 'package:flutter_study_demo/chat/chat_item.dart';
import 'package:flutter_study_demo/chat/circle_image.dart';
import 'package:flutter_study_demo/chat/nine_point_box.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatWidget extends StatelessWidget {
  final ChatItem chatItem;

  ChatWidget({Key key, this.chatItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //是否在右侧
    ChatType chatType = chatItem.chatType;
    return Container(
      //根据左右来构建UI组件
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      // child: chatMessage(isRight),
      child: chatMessageWidget(chatType),
    );
  }

  Row chatMessage(ChatItem chatItem) {
    bool isRight = chatItem.chatType == ChatType.right;
    return Row(
      mainAxisAlignment:
          isRight ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //灵活之处
        if (isRight)
          Flexible(
            child: rightBox(chatItem),
          ),
        headImage(isRight),
        if (!isRight)
          Flexible(
            child: leftBox(chatItem),
          ),
      ],
    );
  }

  chatMessageWidget(ChatType chatType) {
    if (ChatType.center == chatItem.chatType) {
      return centerMessageWidget();
    } else {
      return chatMessage(chatItem);
    }
  }

  centerMessageWidget() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87.withOpacity(0.1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        alignment: Alignment.center,
        width: 100,
        height: 30,
        child: Text(
          chatItem.chatContent,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  rightBox(ChatItem chatItem) {
    return NinePointBox(
      image: AssetImage('images/right_chat.png'),
      sliceRect: Rect.fromLTRB(6, 28, 60, 29),
      padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
      margin: EdgeInsets.only(left: 30),
      // child: Text(
      //   chatItem.chatContent,
      //   style: TextStyle(fontSize: 16),
      // ),
      child: messageContainer(chatItem),
      // child: Image.network(chatItem.headIconUrl,width: 80,height: 100,),
      onTap: () => Fluttertoast.showToast(msg: chatItem.chatContent),
    );
  }

  leftBox(ChatItem chatItem) {
    return NinePointBox(
      image: AssetImage('images/left_chat.png'),
      sliceRect: Rect.fromLTRB(14, 27, 69, 28),
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      margin: EdgeInsets.only(right: 30),
      // child: Text(
      //   chatItem.chatContent,
      //   style: TextStyle(fontSize: 16),
      // ),
      child: messageContainer(chatItem),
      onTap: () => Fluttertoast.showToast(msg: chatItem.chatContent),
    );
  }

  messageContainer(ChatItem chatItem) {
    //消息内容类型
    String chatContentType = chatItem.chatContentType;
    //消息图片Url
    String chatContentImageUrl = chatItem.chatContentImageUrl;
    if (chatContentType == StringConfig.CHAT_TYPE_TEXT) {
      return Text(
        chatItem.chatContent,
        style: TextStyle(fontSize: 16),
      );
    } else if (chatContentType == StringConfig.CHAT_TYPE_IMAGE) {
      return Image.network(
        chatContentImageUrl,
        width: 100,
        height: 120,
        fit: BoxFit.cover,
      );
    }
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
