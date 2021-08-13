import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study_demo/event_bus/event_bus.dart';
import 'package:flutter_study_demo/page/event_bus_two_page.dart';

class EventBusOnePage extends StatefulWidget {
  EventBusOnePage({Key key}) : super(key: key);

  @override
  _EventBusOnePageState createState() {
    return _EventBusOnePageState();
  }
}

class _EventBusOnePageState extends State<EventBusOnePage> {
  var userName = '初始数据';

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
        title: Text('EventBus1'),
        primary: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              Text(
                '$userName',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: MaterialButton(
              //     onPressed: () {
              //       //发送事件、数据
              //       eventBus.fire(UserEvent('丁程鑫'));
              //     },
              //     child: Text('fire'),
              //     color: Colors.blue,
              //     textColor: Colors.white,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '跳转',
        child: Icon(Icons.golf_course),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EventBusTwoPage();
          }));
        },
      ),
    );
  }
}
