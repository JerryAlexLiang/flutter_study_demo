import 'package:get/get.dart';

import 'home_page_view_logic.dart';

class HomePageViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageViewLogic());
  }
}
