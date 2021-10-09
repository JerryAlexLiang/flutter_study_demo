import 'package:flutter_study_demo/chat/chat_ui_page.dart';
import 'package:flutter_study_demo/music/page/home/music_home_binding.dart';
import 'package:flutter_study_demo/music/page/home/music_home_page.dart';
import 'package:flutter_study_demo/music/page/rank_detail/rank_detail_binding.dart';
import 'package:flutter_study_demo/music/page/rank_detail/rank_detail_page.dart';
import 'package:flutter_study_demo/page/main_new_home_page.dart';
import 'package:flutter_study_demo/page/rich_text_page.dart';
import 'package:flutter_study_demo/page/splash/bindings/splash_binding.dart';
import 'package:flutter_study_demo/page/splash/views/splash_page.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:flutter_study_demo/wan_android/home/wan_web_view_page.dart';
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
    GetPage(
      name: AppRoutes.RICH_TEXT,
      page: () => RichTextPage(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AppRoutes.LIST_VIEW_CHAT_UI,
      page: () => ChatUIPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.WAN_WEB_VIEW,
      page: () => WanWebViewPage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.MUSIC_HOME_PAGE,
      page: () => MusicHomePage(),
      binding: MusicHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.MUSIC_RANK_DETAIL_PAGE,
      page: () => RankDetailPage(),
      binding: RankDetailBinding(),
    ),
  ];
}
