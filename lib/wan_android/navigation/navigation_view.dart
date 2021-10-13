import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation_logic.dart';

class NavigationPage extends StatelessWidget {
  final controller = Get.put(NavigationLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: Center(
          child: Text(controller.currentNavigation.value.name ?? "致一科技"),
        ),
      );
    });
  }
}
