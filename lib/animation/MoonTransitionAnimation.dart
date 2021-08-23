import 'package:flutter/material.dart';

class MoonTransitionAnimation extends AnimatedWidget {
  MoonTransitionAnimation({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    //注意，Animation类本身继承自Listenable类，因此AnimatedWidget类内置的listenable
    // 就代表我们可能传入的Animation或者AnimationController类型的对象
    final Animation<double> animation = listenable;
    return Container(
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red,
            Colors.yellow,
          ],
          //LinearGradient的stops接受一个double类型的数组并且数量必须和colors属性中颜色对象数组的数量相等，
          // 表示从开始到结束的渐变颜色起始与结束位置。这里将起始值设置为0，将结束值设置为动画对象animation中动态更新的插值。
          stops: [
            0,
            animation.value,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        'AnimatedWidget',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
