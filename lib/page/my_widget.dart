import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

const owl_url =
    'https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg';

const _duration = Duration(milliseconds: 400);

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter布局基础'),
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flexible(
                //   fit: FlexFit.loose,
                //   flex: 2,
                //   child: BlueBox(),
                // ),
                // Flexible(
                //   //当 flex 属性互相比较时，它们的 flex 值的比率决定了 Flexible widget 自身所占剩余空间的比例。
                //   fit: FlexFit.tight,
                //   flex: 1,
                //   child: BlueBox(),
                // ),
                // Flexible(
                //   fit: FlexFit.tight,
                //   flex: 1,
                //   child: BlueBox(),
                // ),

                BlueBox(),
                //使用 Flexible 在 Row 或 Column 中重新调整 widgets 的大小。
                // 这样，你就可以调整子 widget 的间距同时保持其相对于父 widget 的大小。
                // Expanded改变子窗口小部件的约束，所以它会填补全部空白空间。
                Expanded(
                    child: Column(
                  children: [
                    BlueBox(),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: BlueBox(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                      child: Container(color: Colors.red, width: 50),
                    ),
                    BlueBox(),
                    BlueBox(),
                  ],
                )),
                SizedBox(width: 5, height: 300),
                BlueBox(),
                //SizedBox widget 的两种用途之一就是创建精确的尺寸。
                // 当 SizedBox 包裹了一个 widget 时，它会使用 height 和 width 调整其大小。
                // 如果它没有包裹 widget，它可以使用height和width属性创造空的空间。
                // SizedBox(width: 30),
                //SizedBox 和 Spacer 有何不同？
                // 如果你想用 flex 属性创建一段空间，请使用 Spacer。
                // 如果你想创建一个拥有特定逻辑像素值的空间，请使用 SizedBox。
                Spacer(flex: 1),
                SizedBox(
                  width: 100,
                  child: BlueBox(),
                ),
                SizedBox(width: 30),
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Icon(
                    Icons.widgets,
                    size: 50,
                    color: Colors.red,
                  ),
                  Text(
                    '丁程鑫',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Futura',
                      color: Colors.pink,
                    ),
                  ),
                  //InkWell
                  InkWell(
                    child: Image.network(
                      'https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg',
                    ),
                    onTap: () => Fluttertoast.showToast(msg: '美女'),
                  ),

                  Text(
                    '姚景元',
                    style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'Futura',
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '李天泽',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Futura',
                      color: Colors.blue,
                    ),
                  ),
                  Icon(
                    Icons.widgets,
                    size: 50,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Center(
                child: FadeInDemo(),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Center(
                child: AnimatedContainerDemo(),
              ),
            ),
          ],
        ));
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class FadeInDemo extends StatefulWidget {
  FadeInDemo({Key key}) : super(key: key);

  @override
  _FadeInDemoState createState() {
    return _FadeInDemoState();
  }
}

/// AnimatedOpacity 的特性:
/// 1、AnimatedOpacity 会监听其 opacity 属性的状态变化。
/// 2、当 opacity 属性改变时， AnimatedOpacity 会自动将 opacity 变化到新值，同时使 widget 进行动画跟随变换。
/// 3、AnimatedOpacity 需要一个 duration 参数来确定新旧 opacity 进行动画变换的时长。
/// 注意：
/// 4、AnimatedOpacity 只能将一个 opacity 属性进行动画。

/// 隐式动画只能在父节点是 StatefulWidget 时以动画变换属性。因此，本示例是从继承 StatefulWidget 的 FadeInDemo widget 开始的。

//使用 AnimatedOpacity 来创建一个淡入效果
class _FadeInDemoState extends State<FadeInDemo> {
  //为动画属性初始化一个状态变量
  //将 opacity 的初始值设置为 0 ，以便在用户点击 Show details 前隐藏图片：
  double opacity = 0.0;

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
    return Column(children: <Widget>[
      //想要创建淡入效果，可以使用 AnimatedOpacity widget 对 opacity 属性进行动画
      //只需要设置 opacity 的开始值和结束值。 AnimatedOpacity widget 会自行处理动画过程中的一切。
      AnimatedOpacity(
        duration: Duration(seconds: 2),
        opacity: opacity,
        child: Image.network(owl_url),
      ),
      TextButton(
        child: Text(
          'Show details',
          style: TextStyle(color: Colors.blueAccent),
        ),
        //为动画设置一个触发器，并选择一个结束值
        onPressed: () {
          setState(() {
            opacity = 1;
          });
        },
      ),
      Container(
        child: Column(
          children: <Widget>[
            Text('Type: Owl'),
            Text('Age: 39'),
            Text('Employment: None'),
          ],
        ),
      )
    ]);
  }
}

//使用 AnimatedContainer 让尺寸、颜色和边距产生动画变换
//使用 AnimatedContainer widget 让多个不同类型（double 和 Color）的属性（margin、borderRadius 和 color）同时进行动画变换

double randomBorderRadius() {
  return Random().nextDouble() * 64;
}

double randomMargin() {
  return Random().nextDouble() * 64;
}

Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class AnimatedContainerDemo extends StatefulWidget {
  AnimatedContainerDemo({Key key}) : super(key: key);

  @override
  _AnimatedContainerDemoState createState() {
    return _AnimatedContainerDemoState();
  }
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  Color color;
  double borderRadius;
  double margin;

  @override
  void initState() {
    super.initState();
    color = randomColor();
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void change() {
    setState(() {
      color = randomColor();
      borderRadius = randomBorderRadius();
      margin = randomMargin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 128,
          height: 128,
          //当属性的新旧值发生变化时，AnimatedContainer 会自动在新旧值之间产生动画效果
          child: AnimatedContainer(
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            duration: _duration,
            //隐式动画还允许您在 duration 时长内控制动画的速率变化。用来定义这种速率变化的参数是 curve
            //如果没有指定 curve，所以隐式动画默认使用 线性动画曲线
            curve: Curves.easeInOutBack,
          ),
        ),
        ElevatedButton(
          child: Text('change'),
          onPressed: () => change(),
        ),
      ],
    );
  }
}
