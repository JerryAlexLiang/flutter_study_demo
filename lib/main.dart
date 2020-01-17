import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();

    return new MaterialApp(
      title: 'Widget',
      home: new Scaffold(
        //Scaffold 是 Material library 中提供的一个widget,
        // 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。widget树可以很复杂。
        appBar: new AppBar(
          title: new Text("Text Widget"),
        ),
        body: new Center(
          child: new Container(
//            height: 200,
//            child: HorizontalListView(),
//            child: VerticalListView(),
            child: MyGridView(),
          ),
        ),
//        body: new Center(
//          child: new Container(
////            child: new Text(
////              'Hello Dart 4 Flutter',
////              textAlign: TextAlign.left, //textAlign 对齐方式
////              maxLines: 3, //行数
////              overflow: TextOverflow.ellipsis, //文本溢出属性
////              style: new TextStyle(
////                  fontSize: 15, color: Color.fromARGB(255, 30, 30, 255)),
////            ),
//            alignment: Alignment.topCenter,
////            color: Colors.red,
////            width: 300,
////            height: 200,
////            padding: const EdgeInsets.all(10),
//            padding: const EdgeInsets.fromLTRB(5, 10, 5, 40),
////            margin: const EdgeInsets.all(10),
//            margin: const EdgeInsets.fromLTRB(5, 10, 5, 40),
//            decoration: new BoxDecoration(
//                gradient: const LinearGradient(colors: [
//                  Colors.lightBlue,
//                  Colors.greenAccent,
//                  Colors.purple
//                ]),
//                border: Border.all(width: 10.0, color: Colors.red)),
//            child: new Image.network(
//              "http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
//              repeat: ImageRepeat.repeat,
//              color: Colors.blue,
//              colorBlendMode: BlendMode.darken,
//            ),
//          ),
////          child: new Text(
////            wordPair.asPascalCase,
////            textAlign: TextAlign.end, //textAlign 对齐方式
////            maxLines: 1, //行数
////            overflow: TextOverflow.ellipsis, //文本溢出属性
////            style: new TextStyle(
////                fontSize: 25, color: Color.fromARGB(255, 30, 30, 255)),
////          ),
//        ),
      ),
    );
  }
}

class MyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1),
      children: <Widget>[
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg",
            fit: BoxFit.cover),
      ],
    );
  }
}

class VerticalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new ListTile(
          leading: new Icon(Icons.access_time),
          title: new Text("access_time"),
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new ListTile(
          leading: new Icon(Icons.access_time),
          title: new Text("access_time"),
        ),
        new ListTile(
            leading: new Icon(Icons.account_balance),
            title: new Text('account_balance')),
        new ListTile(
          leading: new Icon(Icons.hot_tub),
          title: new Text("hot_tub"),
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new ListTile(
          leading: new Icon(Icons.access_time),
          title: new Text("access_time"),
        ),
        new ListTile(
            leading: new Icon(Icons.account_balance),
            title: new Text('account_balance')),
        new ListTile(
          leading: new Icon(Icons.hot_tub),
          title: new Text("hot_tub"),
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new ListTile(
          leading: new Icon(Icons.access_time),
          title: new Text("access_time"),
        ),
        new ListTile(
            leading: new Icon(Icons.account_balance),
            title: new Text('account_balance')),
        new ListTile(
          leading: new Icon(Icons.hot_tub),
          title: new Text("hot_tub"),
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new ListTile(
          leading: new Icon(Icons.access_time),
          title: new Text("access_time"),
        ),
        new ListTile(
            leading: new Icon(Icons.account_balance),
            title: new Text('account_balance')),
        new ListTile(
          leading: new Icon(Icons.hot_tub),
          title: new Text("hot_tub"),
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new ListTile(
          leading: new Icon(Icons.access_time),
          title: new Text("access_time"),
        ),
        new ListTile(
            leading: new Icon(Icons.account_balance),
            title: new Text('account_balance')),
        new ListTile(
          leading: new Icon(Icons.hot_tub),
          title: new Text("hot_tub"),
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new ListTile(
          leading: new Icon(Icons.access_time),
          title: new Text("access_time"),
        ),
        new ListTile(
            leading: new Icon(Icons.account_balance),
            title: new Text('account_balance')),
        new ListTile(
          leading: new Icon(Icons.hot_tub),
          title: new Text("hot_tub"),
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
      ],
    );
  }
}

class HorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Container(
          width: 180,
          color: Colors.red,
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new Container(
          width: 180,
          color: Colors.yellow,
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new Container(
          width: 180,
          color: Colors.blue,
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new Container(
          width: 180,
          color: Colors.greenAccent,
        ),
        new Image.network("http://dpic.tiankong.com/8g/6d/QJ6316822497.jpg"),
        new Container(
          width: 180,
          color: Colors.orange,
        )
      ],
    );
  }
}
