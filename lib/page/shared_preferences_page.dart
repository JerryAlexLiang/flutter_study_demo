import 'package:flutter/material.dart';
import 'package:flutter_study_demo/page/shared_preferences_two_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPage extends StatefulWidget {
  SharedPreferencesPage({Key key}) : super(key: key);

  @override
  _SharedPreferencesPageState createState() {
    return _SharedPreferencesPageState();
  }
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  //实例化本地存储对象
  //Flutter中获取SharedPreferences的单例方法是一个异步方法，所以在使用时需要注意使用await获取其真实对象
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var counter = 0;
  var jumpResult = "初始化默认值";

  @override
  void initState() {
    super.initState();
    //从缓存中获取信息
    initFromCache();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences1'),
        primary: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ('$counter'),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SharedPreferencesTwoPage('贺峻霖');
                  }));
                },
                child: Text('跳转'),
                color: Colors.red,
                textColor: Colors.white,
                minWidth: 50,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: () {
                    _navigatorToSecondPageResult(context);
                  },
                  child: Text(
                    '跳转传参并返回数据',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ),
              Text(
                '$jumpResult',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //增加counter并保存到本地
          saveToCache();
          Fluttertoast.showToast(msg: '+1');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void initFromCache() async {
    //Flutter中获取SharedPreferences的单例方法是一个异步方法，所以在使用时需要注意使用await获取其真实对象
    final SharedPreferences preferences = await _prefs;
    //根据健key获取本地存储的值value
    final int counter = preferences.getInt("key_counter");
    //获取到缓存中的值后，使用setState更新界面信息
    setState(() {
      this.counter = counter == null ? 0 : counter;
    });
  }

  void saveToCache() async {
    counter++;
    final SharedPreferences preferences = await _prefs;
    preferences.setInt("key_counter", counter);
    setState(() {
      this.counter = counter;
    });
  }

  //路由跳转到SharedPreferencesTwoPage 关键"等待": async-await组合
  void _navigatorToSecondPageResult(BuildContext context) async {
    //压栈操作并等待页面返回操作
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SharedPreferencesTwoPage("丁程鑫")));
    //读取并显示返回值
    setState(() {
      jumpResult = result == null ? "返回值为空" : result;
    });
  }
}
