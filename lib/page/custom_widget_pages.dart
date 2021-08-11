import 'package:flutter/material.dart';
import 'package:flutter_study_demo/widget/LoadingDialog.dart';

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
      appBar: AppBar(
        title: Text('CustomWidget'),
        primary: true,
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          //构造组件并传递参数，只需传递text参数
          child: LoadingDialog('loading..'),
        ),
      ),
    );
  }
}
