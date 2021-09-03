import 'package:flutter/material.dart';

class DialogDemos extends StatelessWidget {
  DialogDemos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(),
      actions: actions(),
    );
  }

  List<Widget> actions() {
    return [
      Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          '致一科技',
        ),
      ),
    ];
  }

  Column _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(
          size: 50,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Flutter Android ios',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Row _buildTitle() {
    return Row(
      children: [
        Icon(
          Icons.android,
          size: 30,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        Text('Android'),
      ],
    );
  }
}
