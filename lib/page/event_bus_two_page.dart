import 'package:flutter/material.dart';
import 'package:flutter_study_demo/event_bus/event_bus.dart';

class EventBusTwoPage extends StatefulWidget {
  EventBusTwoPage({Key key}) : super(key: key);

  @override
  _EventBusTwoPageState createState() {
    return _EventBusTwoPageState();
  }
}

class _EventBusTwoPageState extends State<EventBusTwoPage> {
  var userName = "初始数据";

  @override
  void initState() {
    super.initState();
    //注册和监听发送过来的UserEvent类型事件、数据
    eventBus.on<UserEvent>().listen((event) {
      setState(() {
        userName = event.userName;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EventBus 2'),
        primary: true,
      ),
      body: Container(
        child: Center(
          child: Text(
            '$userName',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //发送事件、数据
          eventBus.fire(UserEvent('Jerry'));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
