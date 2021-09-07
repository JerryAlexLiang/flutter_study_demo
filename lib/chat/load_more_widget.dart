import 'package:flutter/material.dart';

///由于加载更多的样式以后可以定制，所以抽离出LoadMoreWidget组件方便今后的修改及管理。
///这样做一方面使ChatPage的逻辑变得简单，另一方面当需要类似的界面时可以直接拿来复用，而非重写一遍.

class LoadMoreWidget extends StatelessWidget {
  LoadMoreWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(28),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
