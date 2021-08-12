import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_study_demo/widget/LoadingDialog.dart';
import 'package:flutter_study_demo/widget/custom_toolbar.dart';
import 'package:flutter_study_demo/widget/oral_rect_painter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomWidgetPages extends StatefulWidget {
  CustomWidgetPages({Key key}) : super(key: key);

  @override
  _CustomWidgetPagesState createState() {
    return _CustomWidgetPagesState();
  }
}

class _CustomWidgetPagesState extends State<CustomWidgetPages> {
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
      // appBar: AppBar(
      //   title: Text('CustomWidget'),
      //   primary: true,
      // ),

      // appBar: CustomToolBar(
      //   onTap: () {
      //     Fluttertoast.showToast(msg: 'menu click');
      //   },
      // ),

      appBar: CustomToolBar(
        navigationBarBackgroundColor: Colors.blue,
        onTapLeft: () {
          Navigator.pop(context);
        },
        onTapRight: () {
          Fluttertoast.showToast(msg: 'menu click');
        },
      ),
      primary: true,

      body: Container(
        child: Align(
          alignment: Alignment.center,
          //构造组件并传递参数，只需传递text参数
          // child: LoadingDialog('loading..', true),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: MaterialButton(
                    textColor: Colors.white,
                    color: Colors.red,
                    child: Text('系统弹窗'),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        // false = user must tap button, true = tap outside dialog
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: Text('title'),
                            content: Text('dialogBody'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('buttonText'),
                                onPressed: () {
                                  Navigator.of(dialogContext)
                                      .pop(); // Dismiss alert dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('自定义弹窗'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LoadingDialog('loading...', true);
                          });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(50),
                  child: CustomPaint(
                    painter: OralRectPainter(),
                    child: Center(
                      child: Text(
                        '通过CustomPaint绘制组件',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
