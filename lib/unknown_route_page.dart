import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:get/get.dart';

class UnknownRoutePage extends StatelessWidget {
  UnknownRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Get.back(),
        child: FadeInImage.assetNetwork(
          placeholder: "images/core_icon_bg_weather.png",
          image: StringConfig.UNKNOWN_ROUTE_404_IMAGE_URL,
          height: Get.height,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
