import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleArrowItem extends StatelessWidget {
  final String title;
  final VoidCallback callback;

  TitleArrowItem({@required this.title, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title',
            style: Get.theme.textTheme.headline6,
          ),
          InkWell(
            onTap: callback,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '更多',
                    style: Get.textTheme.bodyText2,
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
