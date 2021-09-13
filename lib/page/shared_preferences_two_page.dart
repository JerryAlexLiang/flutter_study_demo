import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTwoPage extends StatefulWidget {
  final String intentValue;

  SharedPreferencesTwoPage(this.intentValue);

  @override
  _SharedPreferencesTwoPageState createState() {
    return _SharedPreferencesTwoPageState();
  }
}

class _SharedPreferencesTwoPageState extends State<SharedPreferencesTwoPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var counter = 0;

  @override
  void initState() {
    super.initState();
    getFromCache();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences2'),
        primary: true,
      ),
      body: WillPopScope(
        child: Container(
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
                Text(this.widget.intentValue),
                MaterialButton(
                  onPressed: () {
                    //出栈并带上参数，返回到上一个页面
                    Navigator.pop(context, "肖战 余生请多指教");
                  },
                  child: Text(
                    '返回并传递参数数据',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
        // ignore: missing_return
        onWillPop: () async {
          //出栈并带上参数，返回到上一个页面
          Navigator.pop(context, "丁程鑫 像我一样");
        },
      ),
    );
  }

  void getFromCache() async {
    final SharedPreferences preferences = await _prefs;
    final int cacheCounter = preferences.getInt("key_counter");
    setState(() {
      counter = cacheCounter == null ? 0 : cacheCounter;
    });
  }
}
