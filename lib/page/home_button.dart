import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//如果想弹一个信息，或者从底部弹出操作，这时可以考虑使用showSnackBar和showBottomSheet方法。
// 通过Scaffold.of(context)可以获取ScaffoldState对象，两个方法便在ScaffoldState对象中，使用起来很简单，将想要展示的组件放在其中即可。
class HomeButton extends StatelessWidget {
  // HomeButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onPressed(context),
      child: Icon(Icons.menu_book),
      backgroundColor: Colors.blue,
      splashColor: Colors.red,
      foregroundColor: Colors.white,
      mini: false,
      tooltip: 'SnackBar',
      //Hero对象中的tag必须唯一
      heroTag: 'second',
    );
  }

  _onPressed(BuildContext context) {
    showSnackBar(context);
  }

  void showSnackBar(BuildContext context) {
    var snackBar = SnackBar(
      content: Text('SnackBar'),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: '弹出BottomSheet',
        textColor: Colors.white,
        disabledTextColor: Colors.red,
        // onPressed: () => _showBottomSheet(context),
        onPressed: () => _showModalBottom(context),
      ),
    );
    //已过期
    // Scaffold.of(context).hideCurrentSnackBar();
    // Scaffold.of(context).showSnackBar(snackBar);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _showBottomSheet(BuildContext context) {
    Container content = bottomSheetContainer(context);
    // var content = borderRadiusBottomSheetContainer(context);
    //弹出BottomSheet
    Scaffold.of(context).showBottomSheet((context) => content);
  }

  //使用stack包裹住子组件解决圆角的问题，且需要设置背景颜色为Colors.balck54，这个颜色是bottomSheet弹出时系统的默认颜色
  Stack borderRadiusBottomSheetContainer(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 30.0,
          width: double.infinity,
          color: Colors.black54,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
        ),
        bottomSheetContainer(context),
      ],
    );
  }

  Container bottomSheetContainer(BuildContext context) {
    var content = Container(
      // height: 300,
      alignment: Alignment.center,
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.android),
            title: Text('BottomSheet'),
            trailing: IconButton(
              onPressed: () {
                Fluttertoast.showToast(msg: 'close');
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
          ),
          InkWell(
            child: Container(
              color: Colors.white.withOpacity(0.5),
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Text('Flutter'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'Flutter'),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
              color: Colors.blue.withOpacity(0.5),
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Text('Android'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'Android'),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
          InkWell(
            child: Container(
              color: Colors.yellow.withOpacity(0.5),
              margin: EdgeInsets.all(10),
              child: Text('ios'),
            ),
            onTap: () => Fluttertoast.showToast(msg: 'ios'),
          ),
        ],
      ),
    );
    return content;
  }

  //上面由ScaffoldState对象进行控制，浮动按钮也会随之移动，BottomSheet会随着下滑隐藏。
  // 如果只是想单纯在底部弹出界面，可以使用showModalBottomSheet，在点击外围区域时，会隐藏底部，并且可以回调关闭事件。
  _showModalBottom(BuildContext context) async {
    showModalBottomSheet(
      // //是否全屏高度
      // isScrollControlled: true,
      context: context,
      enableDrag: true,
      builder: (context) => bottomSheetContainer(context),
      //设置点击蒙层不关闭页面
      //关键代码
      isDismissible: false,
      //设置圆角两种方法
      // builder: (context) => borderRadiusBottomSheetContainer(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    );
    // ).then(
    //   (value) => _showBottomSheet(context),
    // );
  }
}
