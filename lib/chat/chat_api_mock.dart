import 'dart:math';

import 'package:flutter_study_demo/chat/chat_item.dart';

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

    var content2 = content.reversed;

    for (int i = 0; i < content2.length; i++) {
      _chatList.add(ChatItem(
          headIconUrl: (i.isEven ? leftImageUrl : rightImageUrl),
          // chatContent: content[random.nextInt(content.length)],
          chatContent: content2.toList()[i],
          chatType: (i.isEven ? ChatType.left : ChatType.right)));
    }
    return this;
  }
}
