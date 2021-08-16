import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTwoPage extends StatefulWidget {
  SharedPreferencesTwoPage({Key key}) : super(key: key);

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
      body: Container(
        child: Center(
          child: Text(
            ('$counter'),
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
            ),
          ),
        ),
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
