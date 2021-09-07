import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study_demo/chat/chat_api_mock.dart';
import 'package:flutter_study_demo/chat/chat_item.dart';
import 'package:flutter_study_demo/chat/chat_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatUIPage extends StatefulWidget {
  ChatUIPage({Key key}) : super(key: key);

  @override
  _ChatUIPageState createState() => _ChatUIPageState();
}

class _ChatUIPageState extends State<ChatUIPage> {
  ScrollController _controller;

  List<ChatItem> chatList = [];
  var rightImageUrl =
      "https://img0.baidu.com/it/u=4188835781,3840659732&fm=26&fmt=auto&gp=0.jpg";

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    chatList = ChatApiMock().addMock().chatList;
  }

  @override
  Widget build(BuildContext context) {
    _scrollToBottom(chatList);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat UI'),
        primary: true,
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              setState(() {
                chatList.add(ChatItem(
                  chatType: ChatType.right,
                  chatContent: '肖战 无羁 余生请多指教',
                  headIconUrl: rightImageUrl,
                ));
                Fluttertoast.showToast(
                    msg:
                        chatList.map((e) => e.chatContent).toList().toString());
              });
            },
          ),
        ],
      ),
      body: chatPageHome(chatList),
    );
  }

  chatPageHome(List<ChatItem> chatList) {
    return Center(
      child: chatListView(chatList),
    );
  }

  chatListView(List<ChatItem> chatList) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      // reverse: true,
      controller: _controller,
      itemCount: chatList.length,
      itemBuilder: (context, index) {
        return ChatWidget(
          chatItem: chatList[index],
        );
      },
    );
  }

  void _scrollToBottom(List<ChatItem> chatList) {
    if (chatList.length > 0) {
      Timer(Duration(milliseconds: 500),
          () => _controller.jumpTo(_controller.position.maxScrollExtent));
    }
  }
}
