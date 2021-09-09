import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study_demo/chat/chat_api_mock.dart';
import 'package:flutter_study_demo/chat/chat_item.dart';
import 'package:flutter_study_demo/chat/chat_widget.dart';
import 'package:flutter_study_demo/chat/load_more_widget.dart';
import 'package:flutter_study_demo/config/string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatUIPage extends StatefulWidget {
  ChatUIPage({Key key}) : super(key: key);

  @override
  _ChatUIPageState createState() => _ChatUIPageState();
}

class _ChatUIPageState extends State<ChatUIPage> {
  ScrollController _scrollController;

  final ChatApiMock api = ChatApiMock().addMock();

  var offstageLoadMoreEnd = false;

  List<ChatItem> chatList = [];
  var rightImageUrl =
      "https://img0.baidu.com/it/u=4188835781,3840659732&fm=26&fmt=auto&gp=0.jpg";

  @override
  void initState() {
    super.initState();
    //初始化数据
    // chatList = ChatApiMock().addMock().chatList;
    chatList = api.chatList;

    _scrollController = ScrollController();
    //当_scrollController.position.pixels和_scrollController.position.maxScrollExtent相等时，说明已经滑到底部。
    // 在builder方法中条目需要增加一个，最后一个条目索引为data.length，单独创建这个组件就行了.
    //添加滑动监听
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (chatList.length <= 20) {
          _loadMore();
        } else {
          Fluttertoast.showToast(msg: '我也是有底线的~');
        }
      }
    });
  }

  @override
  void dispose() {
    //释放控制器
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chatList.length <= 20) {
      offstageLoadMoreEnd = false;
    } else {
      offstageLoadMoreEnd = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat UI'),
        primary: true,
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              setState(() {
                chatList.add(
                  ChatItem(
                    chatType: ChatType.right,
                    chatContent: '肖战 无羁 余生请多指教',
                    headIconUrl: rightImageUrl,
                    chatContentType: StringConfig.CHAT_TYPE_TEXT,
                  ),
                );

                _scrollToBottom(chatList);
                print(
                    '===> ${chatList.map((e) => e.chatContent).toList().toString()}');
              });
            },
          ),
        ],
      ),
      body: chatPageHome(chatList),
    );
  }

  chatPageHome(List<ChatItem> chatList) {
    //系统自带的下拉刷新，直接在外层套上RefreshIndicator即可，它的onRefresh方法中需要传入一个异步方法
    //Flutter RefreshIndicator高度不够时不能下拉刷新
    //解决方案:在ListView的physice属性赋值new AlwaysScrollableScrollPhysics()，保持listview任何情况都能滚动，问题解决
    return RefreshIndicator(
      child: chatListView(chatList),
      onRefresh: onRefresh,
    );
  }

  //index == _data.length ? LoadMoreWidget() : ChatWidget(chartItem: _data[index],));

  chatListView(List<ChatItem> chatList) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      // reverse: true,
      physics: AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      // itemCount: chatList.length,
      itemCount: chatList.length + 1,
      //添加底部加载进度条
      itemBuilder: (context, index) {
        // return ChatWidget(
        //   chatItem: chatList[index],
        // );
        //滑动到底部，添加加载组件，最后一个条目索引为data.length
        if (index == chatList.length) {
          return Offstage(
            offstage: offstageLoadMoreEnd,
            child: LoadMoreWidget(),
          );
        } else {
          return ChatWidget(
            chatItem: chatList[index],
          );
        }
      },
      // itemBuilder: (context, index) => index == chatList.length
      //     ? LoadMoreWidget()
      //     : ChatWidget(
      //         chatItem: chatList[index],
      //       )
    );
  }

  void _scrollToBottom(List<ChatItem> chatList) {
    if (chatList.length > 0) {
      // Timer(
      //     Duration(milliseconds: 500),
      //     () => _scrollController
      //         .jumpTo(_scrollController.position.maxScrollExtent));

      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 2),
          curve: Curves.fastLinearToSlowEaseIn);
    }
  }

  //异步请求，更新UI
  Future<void> onRefresh() async {
    await api.addTop();
    setState(() {
      chatList = api.chatList;
    });
  }

  //加载更多，刷新UI
  Future<void> _loadMore() async {
    await api.addBottom();
    setState(() {
      chatList = api.chatList;
      _scrollToBottom(chatList);
    });
  }
}
