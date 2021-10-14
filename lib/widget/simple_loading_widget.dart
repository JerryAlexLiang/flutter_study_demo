import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleLoadingWidget extends StatelessWidget {
  SimpleLoadingWidget({Key key, this.type}) : super(key: key);

  final type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: type == ""
            ? CircularProgressIndicator()
            : CupertinoActivityIndicator(
                radius: 20,
              ),
      ),
    );
  }
}
