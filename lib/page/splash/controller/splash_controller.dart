import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(Duration(milliseconds: 1000 * 1));
    //Get.toNamed("/NextScreen");    导航到下一个页面
    // Get.toNamed(AppRoutes.MAIN);
    //Get.offNamed("/NextScreen");   导航到下一个页面，并删除前一个页面
    Get.offNamed(AppRoutes.MAIN);
  }
}
