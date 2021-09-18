import 'dart:math';

import 'package:flutter_study_demo/chat/chat_item.dart';
import 'package:flutter_study_demo/config/string_config.dart';

class ChatApiMock {
  var random = Random();
  List<ChatItem> _chatList = [];

  List<ChatItem> get chatList => _chatList;

  var leftImageUrl =
      "https://img1.baidu.com/it/u=704980258,4060281424&fm=26&fmt=auto&gp=0.jpg";
  var rightImageUrl =
      "https://img0.baidu.com/it/u=4188835781,3840659732&fm=26&fmt=auto&gp=0.jpg";

  ChatApiMock addMock() {
    var content = [
      '1、醉里挑灯看剑，',
      '2、梦回吹角连营。',
      '3、八百里分麾下炙，',
      '4、五十弦翻塞外声，',
      '5、沙场秋点兵。',
      '6、马作的卢飞快，',
      '7、弓如霹雳弦惊。',
      '8、了却君王天下事，',
      '9、赢得生前身后名。',
      '10、可怜白发生!',
      '11、我偷了个宇宙送给你  °    ，  ☀️·    🛸     🌏 °  🌓 •  .°•   🚀 ✯    ✯   ★ *  🛰 °·  .   • °★ •▁▂▃▄▅▆▇▇▆▅▄▃▁▂▃.',
      '12、也许这个世界上人人都爱钱。但爱钱的痛苦在于，钱并不万能。而且钱这东西，不是你想得到就能得到的，也不是你只要争取就能争取到的。所以爱钱的结果，大多是终日的焦灼和最终的失落。',
    ];

    var contentMulti = [
      ChatItem(
        chatType: ChatType.center,
        chatContent: "系统消息",
      ),
      ChatItem(
        chatType: ChatType.left,
        chatContent: "1、醉里挑灯看剑，",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.right,
        chatContent: "2、梦回吹角连营。",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.right,
        chatContentImageUrl: rightImageUrl,
        chatContentType: StringConfig.CHAT_TYPE_IMAGE,
      ),
      ChatItem(
        chatType: ChatType.left,
        chatContent: "3、八百里分麾下炙，",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.right,
        chatContent: "4、五十弦翻塞外声，",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.center,
        chatContent: "系统消息",
      ),
      ChatItem(
        chatType: ChatType.left,
        chatContent: "5、沙场秋点兵。",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.left,
        chatContentImageUrl: leftImageUrl,
        chatContentType: StringConfig.CHAT_TYPE_IMAGE,
      ),
      ChatItem(
        chatType: ChatType.right,
        chatContent: "6、马作的卢飞快，",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.center,
        chatContent: "系统消息",
      ),
      ChatItem(
        chatType: ChatType.left,
        chatContent: "7、弓如霹雳弦惊。",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.right,
        chatContent: "8、了却君王天下事，",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.right,
        chatContentImageUrl: rightImageUrl,
        chatContentType: StringConfig.CHAT_TYPE_IMAGE,
      ),
      ChatItem(
        chatType: ChatType.center,
        chatContent: "系统消息",
      ),
      ChatItem(
        chatType: ChatType.left,
        chatContent: "9、赢得生前身后名。",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.left,
        chatContentImageUrl: leftImageUrl,
        chatContentType: StringConfig.CHAT_TYPE_IMAGE,
      ),
      ChatItem(
        chatType: ChatType.right,
        chatContent: "10、可怜白发生!",
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
      ChatItem(
        chatType: ChatType.center,
        chatContent: "系统消息",
      ),
      ChatItem(
        chatType: ChatType.left,
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
        chatContent:
            "11、我偷了个宇宙送给你  °    ，  ☀️·    🛸     🌏 °  🌓 •  .°•   🚀 ✯    ✯   ★ *  🛰 °·  .   • °★ •▁▂▃▄▅▆▇▇▆▅▄▃▁▂▃.",
      ),
      ChatItem(
        chatType: ChatType.right,
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
        chatContent:
            "12、也许这个世界上人人都爱钱。但爱钱的痛苦在于，钱并不万能。而且钱这东西，不是你想得到就能得到的，也不是你只要争取就能争取到的。所以爱钱的结果，大多是终日的焦灼和最终的失落。",
      ),
    ];

    // var content2 = content.reversed;
    //
    // for (int i = 0; i < content2.length; i++) {
    //   _chatList.add(ChatItem(
    //       headIconUrl: (i.isEven ? leftImageUrl : rightImageUrl),
    //       // chatContent: content[random.nextInt(content.length)],
    //       chatContent: content2.toList()[i],
    //       chatType: (i.isEven ? ChatType.left : ChatType.right)));
    // }

    // for (int i = 0; i < content.length; i++) {
    //   _chatList.add(ChatItem(
    //       headIconUrl: (i.isEven ? leftImageUrl : rightImageUrl),
    //       // chatContent: content[random.nextInt(content.length)],
    //       chatContent: content.toList()[i],
    //       chatType: (i.isEven ? ChatType.left : ChatType.right)));
    // }
    //
    // _chatList.add(ChatItem(chatType: ChatType.center, chatContent: '系统消息'));

    for (var value in contentMulti) {
      ChatType chatType = value.chatType;
      String chatContent = value.chatContent;

      print('=======>    chatType $chatType');
      print('=======>    chatContent $chatContent');

      // if (chatType == ChatType.left) {
      //   _chatList.add(ChatItem(
      //     headIconUrl: leftImageUrl,
      //     chatContent: chatContent,
      //     chatType: ChatType.left,
      //   ));
      // } else if (chatType == ChatType.right) {
      //   _chatList.add(ChatItem(
      //     headIconUrl: rightImageUrl,
      //     chatContent: chatContent,
      //     chatType: ChatType.right,
      //   ));
      // } else if (chatType == ChatType.center) {
      //   _chatList.add(ChatItem(
      //     chatContent: chatContent,
      //     chatType: ChatType.center,
      //   ));
      // }

      if (chatType == ChatType.left) {
        value.headIconUrl = leftImageUrl;
        _chatList.add(value);
      } else if (chatType == ChatType.right) {
        value.headIconUrl = rightImageUrl;
        _chatList.add(value);
      } else if (chatType == ChatType.center) {
        _chatList.add(value);
      }
    }
    return this;
  }

  Future<void> addTop() async {
    //模拟耗时操作
    await Future.delayed(Duration(seconds: 2));
    _chatList.insert(
      0,
      ChatItem(
        headIconUrl: leftImageUrl,
        chatContent: '下拉刷新 春花秋月何时了，往事知多少。',
        chatType: ChatType.left,
        chatContentType: StringConfig.CHAT_TYPE_TEXT,
      ),
    );
  }

  Future<void> addBottom() async {
    //模拟耗时操作
    await Future.delayed(Duration(seconds: 2));
    _chatList.add(ChatItem(
      headIconUrl: rightImageUrl,
      chatContent: '上拉加载更多 小楼昨夜又东风，故国不堪回首月明中。',
      chatType: ChatType.right,
      chatContentType: StringConfig.CHAT_TYPE_TEXT,
    ));
  }
}
