import 'package:flutter_study_demo/music/page/recommend/recommend_controller.dart';
import 'package:get/get.dart';

class RecommendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecommendController());
  }
}
