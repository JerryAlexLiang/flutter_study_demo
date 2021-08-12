import 'package:flutter/material.dart';

///圆角矩形
class OralRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //绘制圆角矩形
    //用Rect构建一个边长为100，中心点坐标为（150,150）的矩形
    Rect rectCircle =
        Rect.fromCircle(center: Offset(130.0, 150.0), radius: 60.0);
    //矩形绘制到画布上
    // canvas.drawRect(rectCircle, Paint()..color = Colors.blue);
    //根据上面的矩形构建一个圆角矩形
    RRect rRect = RRect.fromRectAndRadius(rectCircle, Radius.circular(30.0));
    //圆角矩形绘制到画布上
    canvas.drawRRect(rRect, Paint()..color = Colors.yellowAccent);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
