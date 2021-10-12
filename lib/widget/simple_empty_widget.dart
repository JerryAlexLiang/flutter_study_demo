import 'package:flutter/material.dart';

class SimpleEmptyWidget extends StatelessWidget {
  const SimpleEmptyWidget({
    Key key,
    @required this.type,
    @required this.callback,
  }) : super(key: key);

  final type;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: callback,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            type == "empty"
                ? Icon(
                    Icons.hourglass_empty,
                    size: 100,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 100,
                  ),
            type == "empty"
                ? Text(
                    '暂时无数据',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  )
                : Text(
                    '数据请求失败',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
          ],
        ),
      ),
    );
  }
}
