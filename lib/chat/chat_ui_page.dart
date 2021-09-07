import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study_demo/chat/chat_api_mock.dart';
import 'package:flutter_study_demo/chat/chat_item.dart';
import 'package:flutter_study_demo/chat/chat_widget.dart';

class ChatUIPage extends StatelessWidget {
  ChatUIPage({Key key}) : super(key: key);

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    //获取数据
    var chatList = ChatApiMock().addMock().chatList;

    _scrollToBottom(chatList);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat UI'),
        primary: true,
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
      reverse: true,
      // controller: _controller,
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
