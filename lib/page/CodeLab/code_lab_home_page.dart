import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CodeLabHomePage extends StatefulWidget {
  CodeLabHomePage({Key key}) : super(key: key);

  @override
  _CodeLabHomePageState createState() {
    return _CodeLabHomePageState();
  }
}

class _CodeLabHomePageState extends State<CodeLabHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //遵循从头至尾 leading-to-trailing 的先后顺序
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              semanticLabel: 'menu',
            ),
            onPressed: () {
              Fluttertoast.showToast(msg: 'menu');
            }),
        title: Text('首页'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                semanticLabel: 'search',
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'search');
              }),
          IconButton(
              icon: Icon(
                Icons.tune,
                semanticLabel: 'tune',
              ),
              onPressed: () {
                Fluttertoast.showToast(msg: 'tune');
              }),
        ],
      ),
      body: GridView.count(
        //指定每横行展示多少条目
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        //以宽高比（宽除以高）的形式定义了条目的大小,GridView 里每个条目的大小默认都是一样的
        childAspectRatio: 8.0 / 9.0,
        children: _buildGridCards(context, 10),
      ),
    );
  }

  List<Card> _buildGridCards(BuildContext context, int count) {

    final ThemeData themeData = Theme.of(context);

    List<Card> cards = List.generate(
      count,
      (index) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //图片形状由 AspectRatio 决定，而不是提供的图片本身的形状。
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.network(
                'https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title'),
                    SizedBox(height: 8.0),
                    Text('Secondary Text'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return cards;
  }
}
