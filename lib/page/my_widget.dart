import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_study_demo/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter布局基础'),
      ),
      body: Column(
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
        ],
      ),
    );
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
