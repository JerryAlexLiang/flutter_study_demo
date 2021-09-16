import 'package:flutter_study_demo/music/page/home/music_home_controller.dart';
import 'package:get/get.dart';

/// Bindings是一个依赖管理器
/// 可以在不同页面间共享实例，而不是在视图中实例化
class MusicHomeBinding extends Bindings{
  @override
  void dependencies() {
    //1、可以通过[Get.put,Get.lazyPut,Get.putAsync,Get.create]方法注入实例
    //2、通过Get.find可以获得实例
    // Get.lazyPut(() => MusicHomeController());
    Get.put(MusicHomeController());
  }
  
}