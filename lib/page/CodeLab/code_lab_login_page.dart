import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string.dart';
import 'package:flutter_study_demo/page/CodeLab/code_lab_home_page.dart';

class CodeLabLoginPage extends StatefulWidget {
  CodeLabLoginPage({Key key}) : super(key: key);

  @override
  _CodeLabLoginPageState createState() {
    return _CodeLabLoginPageState();
  }
}

class _CodeLabLoginPageState extends State<CodeLabLoginPage> {
  //添加TextEditingControllers来控制文本
  final _userNameController = TextEditingController();
  final _passWordController = TextEditingController();

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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          children: [
            SizedBox(
              height: 50.0,
            ),
            Container(
              child: Column(
                children: [
                  //圆角图片
                  //way01 最简单

                  //var hero = Hero(
                  //       //定义Hero,添加tag标签,此中组件共享
                  //       tag: 'user-head',
                  //       child: Image.asset(
                  //         "assets/images/icon_head.png",
                  //         width: 60,
                  //         height: 60,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     );

                  Hero(
                    tag: StringConfig.SLIVER_FLEXIBLE_SPACE_BAR,
                    child: ClipRRect(
                      child: Image.network(
                        "https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg",
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),


                  SizedBox(
                    height: 10,
                  ),

                  //way02
                  Container(
                    width: 100,
                    height: 100,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //way03
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //way04
                  Card(
                    child: Image.network(
                      "https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg",
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text('致一科技'),
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'UserName',
              ),
              controller: _userNameController,
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
              controller: _passWordController,
            ),
            ButtonBar(
              children: [
                FlatButton(
                  onPressed: () {
                    _userNameController.clear();
                  },
                  child: Text('Cancel'),
                ),
                RaisedButton(
                  onPressed: () {
                    //Navigator 维护了一个 route 栈，类似于 iOS 中的 UINavigationController
                    //对栈进行 Pop 操作会将最新加入的 route 移除
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CodeLabHomePage()));
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
