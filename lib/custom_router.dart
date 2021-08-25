import 'package:flutter/material.dart';

///自定义路由动画效果  197.7

class CustomRoute extends PageRouteBuilder {
  final Widget widget;

  //1、自定义首先要继承于通用的路由的构造器类PageRouterBuilder

  //2、继承之后重写父类的CustomRoute构造方法

  //3、构造方法可以简单理解为：只要以调用这个类或者说是Widget，构造方法里的所有代码就执行了。

  CustomRoute(this.widget)
      : super(
            transitionDuration: const Duration(seconds: 1),
            //transitionDuration：设置动画持续的时间，建议再1和2之间
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              //间显路由动画
              // return FadeTransition(
              //   //FadeTransition:渐隐渐现过渡效果，主要设置opactiy（透明度）属性，值是0.0-1.0
              //   //animate :动画的样式，一般使用动画曲线组件（CurvedAnimation）
              //   //curve: 设置动画的节奏，也就是常说的曲线，Flutter准备了很多节奏，通过改变动画取消可以做出很多不同的效果
              //   opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              //       parent: animation1, curve: Curves.fastOutSlowIn)),
              //   child: child,
              // );

              // //缩放路由动画
              // return ScaleTransition(
              //     scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              //         parent: animation1, curve: Curves.fastOutSlowIn)),
              //     child: child);

              // //缩放旋转动画 旋转+缩放的思路是在一个路由动画里的child属性里再加入一个动画，让两个动画同时执行
              // return RotationTransition(
              //     turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              //         parent: animation1, curve: Curves.fastOutSlowIn)),
              //     child: ScaleTransition(
              //       scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              //           parent: animation1, curve: Curves.fastOutSlowIn)),
              //       child: child,
              //     ));

              //左右滑动路由动画
              // 幻灯片路由动画
              return SlideTransition(
                //左右滑动路由动画
                position: Tween<Offset>(
                        begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: animation1, curve: Curves.fastOutSlowIn)),
                //下上滑动路由动画
                // position: Tween<Offset>(
                //         begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                //     .animate(CurvedAnimation(
                //         parent: animation1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
