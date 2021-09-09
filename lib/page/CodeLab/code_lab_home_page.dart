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
  var _crossAxisCount = 2;

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
              setState(() {
                _crossAxisCount = 2;
              });
            }),
        title: Text('首页'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                semanticLabel: 'search',
              ),
              onPressed: () {
                setState(() {
                  _crossAxisCount = 3;
                });
              }),
          IconButton(
              icon: Icon(
                Icons.tune,
                semanticLabel: 'tune',
              ),
              onPressed: () {
                setState(() {
                  _crossAxisCount = 1;
                });
              }),
        ],
      ),
      body: GridView.count(
        //指定每横行展示多少条目
        crossAxisCount: _crossAxisCount,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //图片形状由 AspectRatio 决定，而不是提供的图片本身的形状。
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Container(
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.rectangle,
                  //   borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(8),
                  //     topRight: Radius.circular(8),
                  //   ),
                  // ),
                  // child: Image.network(
                  //   'https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg',
                  //   fit: BoxFit.cover,
                  // ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.network(
                      'https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Title',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                            text: 'Secondary  ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 11,
                            ),
                            children: [
                              TextSpan(
                                text: 'Text  ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 8,
                                ),
                              ),
                              TextSpan(
                                text: 'TextSpan',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 8,
                                ),
                              ),
                            ]),
                      ),
                    ),
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
