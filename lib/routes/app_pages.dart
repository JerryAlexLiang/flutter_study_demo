
import 'package:flutter_study_demo/page/main_new_home_page.dart';
import 'package:flutter_study_demo/page/splash/bindings/splash_binding.dart';
import 'package:flutter_study_demo/page/splash/views/splash_page.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainNewHomePage(),
    ),
  ];
}