import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model/study_demo_navigator_model.dart';

class StudyDemoNavigationPage extends StatelessWidget {
  final data = List.generate(
      20, (index) => StudyDemoNavigatorModel('demo $index', "$index", ""));

  final List<StudyDemoNavigatorModel> dataList = [
    StudyDemoNavigatorModel("网络数据", "1", "image"),
    StudyDemoNavigatorModel("Provide状态管理", "2", "image"),
    StudyDemoNavigatorModel("ListView", "3", "image"),
    StudyDemoNavigatorModel("ListView2", "4", "image"),
    StudyDemoNavigatorModel("StatefulWidget", "5", "image"),
  ];

  StudyDemoNavigationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StudyDemoListWidget(
        models: dataList,
      ),
    );
  }
}

class StudyDemoListWidget extends StatelessWidget {
  final List<StudyDemoNavigatorModel> models;

  StudyDemoListWidget({Key key, this.models}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study导航'),
        elevation: 0.0,
      ),
      body: ListView.builder(
          itemCount: models.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(models[index].name),
              onTap: () {
                Fluttertoast.showToast(
                    msg: '你点击了${models[index].name}',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            );
          }),
    );
  }
}
