import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(Duration(milliseconds: 1000 * 1));
    Get.toNamed(AppRoutes.MAIN);
  }
}
