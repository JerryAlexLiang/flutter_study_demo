import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class EyeHomePage extends StatefulWidget {
  const EyeHomePage({Key key}) : super(key: key);

  @override
  _EyeHomePageState createState() => _EyeHomePageState();
}

class _EyeHomePageState extends State<EyeHomePage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text('日报'),
      ),

    );
  }
}
