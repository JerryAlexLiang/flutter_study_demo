import 'package:flutter/material.dart';
import 'package:flutter_study_demo/animation/MoonTransitionAnimation.dart';

class AnimationPage extends StatefulWidget {
  AnimationPage({Key key}) : super(key: key);

  @override
  _AnimationPageState createState() {
    return _AnimationPageState();
  }
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Alignment> alignmentAnimation;

  @override
  void initState() {
    super.initState();
    //创建AnimationController动画控制器
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    //创建插值为Alignment类型的动画对象
    AlignmentTween alignmentTween =
        AlignmentTween(begin: Alignment.bottomRight, end: Alignment.topLeft);
    //AlignmentAnimation
    alignmentAnimation = alignmentTween.animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画组件'),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: 300,
            child: Center(
              child: AlignTransition(
                //AlignTransition：与Align组件对应的动画组件，可以控制子组件对齐方式的切换。
                alignment: alignmentAnimation,
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.network(
                        'http://gank.io/images/d6bba8cf5b8c40f9ad229844475e9149',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'AlignTransition',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Row(
            children: [
              Container(
                height: 300,
                child: Center(
                  child: RotationTransition(
                    //RotationTransition：可以控制旋转角度的动画组件。
                    //动画turns
                    turns: CurvedAnimation(
                        parent: _controller, curve: Curves.linear),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.network(
                            'http://gank.io/images/d6bba8cf5b8c40f9ad229844475e9149',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'RotationTransition',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 300,
                child: Center(
                  child: FadeTransition(
                    //FadeTransition：可以控制透明度的动画组件。
                    opacity: CurvedAnimation(
                        parent: _controller, curve: Curves.linear),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.network(
                            'http://gank.io/images/d6bba8cf5b8c40f9ad229844475e9149',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'FadeTransition',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: ScaleTransition(
                      //ScaleTransition:可以控制组件比例的动画组件
                      scale: _controller,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Image.network(
                              'http://gank.io/images/d6bba8cf5b8c40f9ad229844475e9149',
                              height: 100,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              'ScaleTransition',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //AnimatedWidget
          MoonTransitionAnimation(
            animation: _controller,
          ),
        ],
      ),
      persistentFooterButtons: [
        MaterialButton(
          onPressed: () => startAnimation(),
          child: Text('启动动画'),
          color: Colors.red,
          textColor: Colors.white,
        )
      ],
    );
  }

  startAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      //调用 AnimationController的forward方法启动动画
      _controller.forward();
    }
  }
}
