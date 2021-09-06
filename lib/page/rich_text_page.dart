import 'package:flutter/material.dart';

class RichTextPage extends StatelessWidget {
  RichTextPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RichText'),
      ),
      body: _richTextHome(),
    );
  }

  _richTextHome() {
    return ListView(
      children: [
        showTextSpan(),
        SizedBox(
          height: 10,
        ),
        showTextSpan2(),
        SizedBox(
          height: 10.0,
        ),
        showWidgetSpan(),
      ],
    );
  }

  showTextSpan() {
    var span = TextSpan(
        text: 'RichText \n',
        style: TextStyle(
          color: Colors.red,
        ),
        children: [
          //可以盛放多个TextSpan
          TextSpan(
            text: 'Flutter ',
            style: TextStyle(
              color: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
          ),
          TextSpan(
            text: 'Android ',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'IOS ',
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.normal,
            ),
          ),
        ]);

    return Container(
      padding: EdgeInsets.all(10),
      child: RichText(
        text: span,
      ),
    );
  }

  showTextSpan2() {
    final rainbowMap = {
      Colors.red: "红色",
      Colors.orange: "橙色",
      Colors.yellow: "黄色",
      Colors.green: "绿色",
      Colors.cyan: "青色",
      Colors.blue: "蓝色",
      Colors.purple: "紫色",
    };
    //map遍历生成TextSpan列表
    var span = rainbowMap.keys
        .map((e) => TextSpan(
              text: '${rainbowMap[e]}  ',
              style: TextStyle(fontSize: 20, color: e),
            ))
        .toList();
    return Container(
      padding: EdgeInsets.all(10.0),
      child: RichText(
        text: TextSpan(
          text: '七彩字\n',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
          children: span,
        ),
      ),
    );
  }

  showWidgetSpan() {
    //需要将各种Widget拼在一行时，可以用WidgetSpan，它是InlineSpan的实现类，
    // 所以用WidgetSpan来包裹一个组件就可以作为TextSpan的子组件显示
    var span = [
      TextSpan(
        text: 'Flutter',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
      WidgetSpan(
        alignment: PlaceholderAlignment.aboveBaseline,
        baseline: TextBaseline.ideographic,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset(
            'images/core_icon_bg_weather.png',
            width: 30,
            height: 30,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      TextSpan(
        text: 'Android',
        style: TextStyle(
          color: Colors.green,
          fontSize: 18,
        ),
      ),
      WidgetSpan(
        child: Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Icon(
            Icons.face,
            color: Colors.red,
          ),
        ),
      ),
    ];
    return Container(
      padding: EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          text: 'WidgetSpan \n',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
          children: span,
        ),
      ),
    );
  }
}
