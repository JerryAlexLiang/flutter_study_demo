import 'package:flutter/material.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:get/get.dart';

class RouteAuthMiddleware extends GetMiddleware {
  @override
  int priority = 0;

  RouteAuthMiddleware({@required this.priority});

  @override
  RouteSettings redirect(String route) {
    debugPrint('=======> AuthMiddleware.redirect:$route');

    if (route == "/richText") {
      Future.delayed(Duration(seconds: 1),
          () => Get.snackbar("提示，", "请先写一个日志，模拟导航-中间件-认证 Auth"));

      return RouteSettings(name: AppRoutes.TO_DO_LIST_PAGE);
    }
    return super.redirect(route);
  }

  @override
  GetPage onPageCalled(GetPage page) {
    debugPrint('=======> AuthMiddleware.onPageCalled:$page');
    return super.onPageCalled(page);
  }
}
