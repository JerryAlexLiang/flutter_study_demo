import 'package:flutter/material.dart';

class AutomaticKeepAlivePage3 extends StatefulWidget {
  @override
  _AutomaticKeepAlivePage3State createState() => _AutomaticKeepAlivePage3State();
}

//混入AutomaticKeepAliveClientMixin，这是保持状态的关键
//然后重写wantKeepAlive 的值为true。
class _AutomaticKeepAlivePage3State extends State<AutomaticKeepAlivePage3>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    print('==========> 初始化 AutomaticKeepAlivePage3');
  }

  int _count = 0;

  void _addCount() {
    setState(() {
      _count++;
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('click add count 1'),
            Text(
              '$_count',
              // style: Theme.of(context).textTheme.display1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            MaterialButton(
              height: 50,
              // minWidth: 100,
              elevation: 5,
              color: Colors.orangeAccent,
              child: Text('Click'),
              onPressed: _addCount,
            )
          ],
        ),
      ),
      // //增加一个悬浮按钮，点击时触犯_incrementCounter方法
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addCount,
      //   tooltip: "Increment",
      //   child: Icon(Icons.alarm_add),
      // ),
    );
  }

  //重写keepAlive为true ，就是可以有记忆功能了。
  @override
  bool get wantKeepAlive => true;
}
