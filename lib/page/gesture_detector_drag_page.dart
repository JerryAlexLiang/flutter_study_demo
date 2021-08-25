import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GestureDetectorDragPage extends StatefulWidget {
  GestureDetectorDragPage({Key key}) : super(key: key);

  @override
  _GestureDetectorDragPageState createState() {
    return _GestureDetectorDragPageState();
  }
}

class _GestureDetectorDragPageState extends State<GestureDetectorDragPage> {
  //实例化本地存储对象
  //Flutter中获取SharedPreferences的单例方法是一个异步方法，所以在使用时需要注意使用await获取其真实对象
  //使用SharedPreferences对象的方法只能存储int、double、bool、string和stringList类型的数据。
  // 另外，出于读取、写入的性能原因，SharedPreferences对象的方法不能存储较大的数据量
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  double _top = 0;
  double _left = 0;

  double _width = 100;
  double _height = 100;

  Color _color = Colors.blue;
  String _name = "肖战";

  @override
  void initState() {
    super.initState();
    //从缓存中获取信息
    initFromCache();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GestureDetector - Drag'),
        primary: true,
      ),
      body: _DragGestureWidget(),
      // body: _ScaleGestureWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clearCacheReset();
        },
        child: Icon(Icons.clear),
        backgroundColor: Colors.red,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _DragGestureWidget() {
    return Stack(
      children: [
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: Container(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundColor: _color,
                child: Text(
                  _name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            //处理二维拖曳手势的属性
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails details) {
              //打印手指按下的位置（相对于屏幕）
              print("用户手指在${details.globalPosition}处按下");
            },
            //用户接触屏幕并开始移动时触发
            onPanStart: (d) {
              // DragStartDetails
              print("用户手指在${d.globalPosition}处开始移动");
            },
            //用户手指滑动时触发
            onPanUpdate: (d) {
              // DragUpdateDetails
              //用户手指滑动时，更新偏移量，重新构建
              setState(() {
                _left += d.delta.dx;
                _top += d.delta.dy;
                _color = Colors.red;

                _name = "肖战 无羁";

                saveToCache();
              });
            },
            //用户胡手指移动后、用户手指抬起时触发
            onPanEnd: (d) {
              // DragEndDetails
              //打印滑动结束时在x、y轴上的速度
              print("拖动以${d.velocity.toString()}的速度移动结束");
              setState(() {
                _color = Colors.blue;
                _name = "肖战";
              });
            },
          ),
        ),
      ],
    );
  }

  void initFromCache() async {
    //Flutter中获取SharedPreferences的单例方法是一个异步方法，所以在使用时需要注意使用await获取其真实对象
    final SharedPreferences preferences = await _prefs;
    //根据健key获取本地存储的值value
    final double top = preferences.getDouble("gesture_top");
    final double left = preferences.getDouble("gesture_left");
    //获取到缓存中的值后，使用setState更新界面信息
    setState(() {
      _top = top == null ? 0 : top;
      _left = left == null ? 0 : left;
    });
  }

  void saveToCache() async {
    final SharedPreferences preferences = await _prefs;
    preferences.setDouble("gesture_top", _top);
    preferences.setDouble("gesture_left", _left);
  }

  void clearCacheReset() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('提示'),
          content: Text('重置还原位置?'),
          actions: <Widget>[
            MaterialButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            MaterialButton(
              child: Text('确定'),
              onPressed: () async {
                final SharedPreferences preferences = await _prefs;
                // preferences.setDouble("gesture_top", 0);
                // preferences.setDouble("gesture_left", 0);
                //SharedPreferences对象的remove()方法可以实现将本地保存的键值对数据清空的功能
                preferences.remove('gesture_top');
                preferences.remove('gesture_left');
                setState(() {
                  _left = 0;
                  _top = 0;
                });
                Fluttertoast.showToast(msg: '重置还原');
                //关闭弹窗
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  _ScaleGestureWidget() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: _width,
          height: _height,
          color: Colors.yellow,
          child: Center(
            child: Text('陈星旭'),
          ),
        ),
        //处理缩放手势的相关属性
        //onScaleStart 当手指屏幕接触并建立焦点时触发，初始缩放比例为1.0
        onScaleStart: (ScaleStartDetails details) {
          print("用户手指在${details.localFocalPoint.toString()}处开始缩放");
        },
        //onScaleUpdate 当手指呈缩放手势时触发
        onScaleUpdate: (ScaleUpdateDetails details) {
          //缩放比例介于0.8-10
          setState(() {
            _width = _width * details.scale.clamp(0.8, 10.0);
            _height = _height * details.scale.clamp(.8, 10.0);
          });
        },
        //onScaleEnd 当手指离开屏幕时触发
        onScaleEnd: (ScaleEndDetails details) {
          print("缩放以${details.velocity.toString()}的速度移动结束");
        },
      ),
    );
  }
}
