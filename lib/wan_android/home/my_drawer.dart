import 'package:flutter/material.dart';
import 'package:flutter_study_demo/custom_router.dart';
import 'package:flutter_study_demo/todoList/todo_list_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //DrawerHeader，它是一个具有默认高度的结构化组件，可以用它在菜单头部展示用户的基本信息
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Flutter 致一科技',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.people,
                    size: 100,
                    color: Colors.yellow,
                  ),
                  onTap: () => Fluttertoast.showToast(msg: 'click'),
                ),
              ],
            ),
          ),
          ListTile(
            //导航图标
            leading: Icon(
              Icons.message,
              color: Colors.red,
            ),
            //标题
            title: Text(
              '消息',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            //副标题
            subtitle: Text(
              '100+',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
            //右侧顶部菜单
            trailing: Icon(
              Icons.flag,
              color: Colors.red,
            ),
            //点击事件
            onTap: () => Fluttertoast.showToast(msg: '消息'),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text(
              '我的',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => Fluttertoast.showToast(msg: '我的'),
          ),
          ListTile(
            leading: Icon(
              Icons.book,
              color: Colors.red,
            ),
            title: Text(
              'TODO List',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CustomRoute(
                  TodoListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.red,
            ),
            title: Text(
              '设置',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => Fluttertoast.showToast(msg: '设置'),
          ),
        ],
      ),
    );
  }
}
