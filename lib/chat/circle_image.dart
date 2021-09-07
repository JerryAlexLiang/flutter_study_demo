import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String imageUrl; //图片
  final double size; //大小
  final Color shadowColor; //阴影颜色
  final Color roundColor; //边框颜色

  CircleImage(
      {Key key,
      @required this.imageUrl,
      this.size = 50,
      this.shadowColor,
      this.roundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      //圆形装饰线
      shape: BoxShape.circle,
      color: roundColor ?? Colors.blue.withAlpha(66),
      boxShadow: [
        BoxShadow(
          //阴影
          color: shadowColor ?? Colors.grey.withOpacity(0.3),
          offset: Offset(0.0, 0.0),
          blurRadius: 3.0,
          spreadRadius: 0.0,
        ),
      ],
    );

    return Container(
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      width: size,
      height: size,
      decoration: boxDecoration,
      //发现不添加Align时，CircleAvatar并没有显示为圆形，
      // 设置child为要显示的url时，并不能显示为圆形，只有设置backgroundColor或者backgroundImage时才显示为了圆形
      // radius和minRadius与maxRadius不能同时使用;
      // ClipOval不在Align里面时也不能显示为圆形，ClipOval中image设置为fit: BoxFit.fill才能显示为圆形；
      // BoxDecoration不在Align里面时也不能显示为圆形，BoxDecoration中image设置为fit: BoxFit.fill才能显示为圆形；
      child: Padding(
        padding: EdgeInsets.all(2),
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
