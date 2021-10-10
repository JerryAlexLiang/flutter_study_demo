import 'package:flutter_study_demo/music/page/rank_detail/rank_detail_controller.dart';
import 'package:flutter_study_demo/music/page/rank_detail/rank_detail_controller2.dart';
import 'package:get/get.dart';

/// Bindings是一个依赖管理器
/// 可以在不同页面间共享实例，恶如不是在视图中实例化
class RankDetailBinding extends Bindings {
  @override
  void dependencies() {
    //1、可以通过[Get.put,Get.lazyPut,Get.putAsync,Get.create]方法注入实例
    //2、通过Get.find可以获得实例
    // Get.lazyPut(() => RankDetailController());
    Get.lazyPut(() => RankDetailController2());
  }
}
