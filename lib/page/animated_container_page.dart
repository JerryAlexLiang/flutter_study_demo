import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AnimatedContainerPage extends StatefulWidget {
  AnimatedContainerPage({Key key}) : super(key: key);

  @override
  _AnimatedContainerPageState createState() {
    return _AnimatedContainerPageState();
  }
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {
  final imageUrl1 = "http://gank.io/images/dc75cbde1d98448183e2f9514b4d1320";
  final imageUrl2 = "http://gank.io/images/6b2efa591564475fb8bc32291fb0007c";

  final Decoration startDecoration = BoxDecoration(
    color: Colors.blue,
    image: DecorationImage(
      image: NetworkImage(
          "http://gank.io/images/dc75cbde1d98448183e2f9514b4d1320"),
      fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  final Decoration endDecoration = BoxDecoration(
    color: Colors.red,
    image: DecorationImage(
      image: NetworkImage(
          "http://gank.io/images/6b2efa591564475fb8bc32291fb0007c"),
      fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.all(Radius.circular(50)),
  );

  final Alignment startAlignment = Alignment.center;
  final Alignment endAlignment = Alignment.bottomRight;

  final startHeight = 100.0;
  final endHeight = 50.0;

  Decoration _decoration;
  double _height;
  Alignment _alignment;

  @override
  void initState() {
    super.initState();
    //初始化
    _decoration = startDecoration;
    _height = startHeight;
    _alignment = startAlignment;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedContainer'),
        primary: true,
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 3),
            curve: Curves.fastOutSlowIn,
            alignment: _alignment,
            color: Colors.grey.withAlpha(30),
            height: 500,
            child: UnconstrainedBox(
              child: AnimatedContainer(
                duration: Duration(seconds: 3),
                curve: Curves.fastOutSlowIn,
                decoration: _decoration,
                onEnd: () => Fluttertoast.showToast(msg: 'end'),
                height: _height,
                width: _height,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          _buildSwitchWidget(),
        ],
      ),
    );
  }

  _buildSwitchWidget() {
    return Switch(
      value: _height == endHeight,
      onChanged: (v) {
        setState(() {
          _height = v ? endHeight : startHeight;
          _decoration = v ? endDecoration : startDecoration;
          _alignment = v ? endAlignment : startAlignment;
        });
      },
    );
  }
}
