import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FlutterEasyLoadingPage extends StatelessWidget {
  FlutterEasyLoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //因为 EasyLoading 是一个全局单例, 所以你可以在任意一个地方自定义它的样式:
    //textColor、indicatorColor、progressColor、backgroundColor 仅对 EasyLoadingStyle.custom有效。
    //maskColor 仅对 EasyLoadingMaskType.custom有效
    // EasyLoading.instance
    //   ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    // // ..indicatorType = EasyLoadingIndicatorType.circle
    // // ..indicatorType = EasyLoadingIndicatorType.chasingDots
    // // ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    // // ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    // // ..indicatorType = EasyLoadingIndicatorType.dualRing
    // // ..indicatorType = EasyLoadingIndicatorType.fadingCube
    // // ..indicatorType = EasyLoadingIndicatorType.foldingCube
    // // ..indicatorType = EasyLoadingIndicatorType.hourGlass
    // // ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass
    // // ..indicatorType = EasyLoadingIndicatorType.pulse
    // // ..indicatorType = EasyLoadingIndicatorType.pumpingHeart
    // ..loadingStyle = EasyLoadingStyle.dark
    // // ..indicatorSize = 30
    // ..radius = 10.0
    // ..backgroundColor = Colors.red
    // ..indicatorColor = Colors.yellow
    // ..maskColor = Colors.blue.withOpacity(0.5)
    // ..userInteractions = true;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter EasyLoading'),
        primary: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              //backgroundColor  背景颜色
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              //overlayColor  高亮色，按钮处于focused, hovered, or pressed时的颜色
              overlayColor: MaterialStateProperty.all(Colors.red),
              //foregroundColor  字体颜色
              foregroundColor: MaterialStateProperty.all(Colors.white),
              //shadowColor 阴影颜色
              shadowColor: MaterialStateProperty.all(Colors.grey),
              //elevation  阴影值
              elevation: MaterialStateProperty.all(20),
              //shape  形状-可设置圆角弧度
              shape: MaterialStateProperty.all(
                StadiumBorder(
                  side: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
            onPressed: () => EasyLoading.showToast('toast'),
            child: Text('show toast'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              //backgroundColor  背景颜色
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              //overlayColor  高亮色，按钮处于focused, hovered, or pressed时的颜色
              overlayColor: MaterialStateProperty.all(Colors.red),
              //foregroundColor  字体颜色
              foregroundColor: MaterialStateProperty.all(Colors.white),
              //shadowColor 阴影颜色
              shadowColor: MaterialStateProperty.all(Colors.grey),
              //elevation  阴影值
              elevation: MaterialStateProperty.all(20),
              //shape  形状-可设置圆角弧度
              shape: MaterialStateProperty.all(
                StadiumBorder(
                  side: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
            // onPressed: () => EasyLoading.show(status: 'loading...'),
            onPressed: () => EasyLoading.show(status: 'loading...'),
            onLongPress: () => EasyLoading.dismiss(),
            child: Text('show loading'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              //backgroundColor  背景颜色
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              //overlayColor  高亮色，按钮处于focused, hovered, or pressed时的颜色
              overlayColor: MaterialStateProperty.all(Colors.red),
              //foregroundColor  字体颜色
              foregroundColor: MaterialStateProperty.all(Colors.white),
              //shadowColor 阴影颜色
              shadowColor: MaterialStateProperty.all(Colors.grey),
              //elevation  阴影值
              elevation: MaterialStateProperty.all(20),
              //shape  形状-可设置圆角弧度
              shape: MaterialStateProperty.all(
                StadiumBorder(
                  side: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
            onPressed: () => EasyLoading.showSuccess('download success!'),
            // onPressed: () => EasyLoading.showError('download error!'),
            onLongPress: () => EasyLoading.dismiss(),
            child: Text('show success'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              //backgroundColor  背景颜色
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              //overlayColor  高亮色，按钮处于focused, hovered, or pressed时的颜色
              overlayColor: MaterialStateProperty.all(Colors.red),
              //foregroundColor  字体颜色
              foregroundColor: MaterialStateProperty.all(Colors.white),
              //shadowColor 阴影颜色
              shadowColor: MaterialStateProperty.all(Colors.grey),
              //elevation  阴影值
              elevation: MaterialStateProperty.all(20),
              //shape  形状-可设置圆角弧度
              shape: MaterialStateProperty.all(
                StadiumBorder(
                  side: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
            onPressed: () =>
                EasyLoading.showProgress(0.6, status: 'downloading...'),
            onLongPress: () => EasyLoading.dismiss(),
            child: Text('show progress'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              //backgroundColor  背景颜色
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              //overlayColor  高亮色，按钮处于focused, hovered, or pressed时的颜色
              overlayColor: MaterialStateProperty.all(Colors.red),
              //foregroundColor  字体颜色
              foregroundColor: MaterialStateProperty.all(Colors.white),
              //shadowColor 阴影颜色
              shadowColor: MaterialStateProperty.all(Colors.grey),
              //elevation  阴影值
              elevation: MaterialStateProperty.all(20),
              //shape  形状-可设置圆角弧度
              shape: MaterialStateProperty.all(
                StadiumBorder(
                  side: BorderSide(style: BorderStyle.none),
                ),
              ),
            ),
            onPressed: () => EasyLoading.showInfo('status'),
            onLongPress: () => EasyLoading.dismiss(),
            child: Text('show info'),
          ),
        ],
      ),
    );
  }
}
