//继承我们的Dialog组件，这样它就具有Dialog的一些特性和方法属性
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadingDialog extends Dialog {
  String text;

  //建立构造方法，传递参数
  LoadingDialog(this.text);

  @override
  Widget build(BuildContext context) {
    //具体逻辑
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: ShapeDecoration(
              // color: Colors.white,
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: Colors.grey.withAlpha(30),
                  valueColor: AlwaysStoppedAnimation(Colors.orange),
                  strokeWidth: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 12.0,
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
