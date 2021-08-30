import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';

class OKFlutterToastPage extends StatelessWidget {
  OKFlutterToastPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OKToast插件示例'),
        primary: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              '文字Toast',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            highlightColor: Colors.red,
            textColor: Colors.white,
            onPressed: () =>
                showToast('OkToast', position: ToastPosition.top),
            onLongPress: () => Fluttertoast.showToast(msg: 'FlutterToast'),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              '文字Toast dismissAllToast',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            highlightColor: Colors.red,
            textColor: Colors.white,
            onPressed: () => showToast(
              'OkToast dismissAllToast',
              position: ToastPosition.bottom,
              dismissOtherToast: true,
            ),
            onLongPress: () =>
                Fluttertoast.showToast(msg: 'FlutterToast dismissAllToast'),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              '自定义Widget Toast',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            highlightColor: Colors.red,
            textColor: Colors.white,
            onPressed: () => _showCustomToastWidget('Success'),
          ),
        ],
      ),
    );
  }

  _showCustomToastWidget(String s) {
    var w = Center(
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        // color: Colors.black.withOpacity(0.7),
        child: Column(
          children: [
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Text(
              s,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
    showToastWidget(w, position: ToastPosition.center);
  }

// _showToast() {
//   showToast('OkToast');
// }
}
