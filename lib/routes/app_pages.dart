import 'package:flutter_study_demo/chat/chat_ui_page.dart';
import 'package:flutter_study_demo/music/page/home/music_home_binding.dart';
import 'package:flutter_study_demo/music/page/home/music_home_page.dart';
import 'package:flutter_study_demo/music/page/rank_detail/rank_detail_binding.dart';
import 'package:flutter_study_demo/music/page/rank_detail/rank_detail_page.dart';
import 'package:flutter_study_demo/music/page/rank_detail/rank_detail_page2.dart';
import 'package:flutter_study_demo/music/page/recommend/recommend_binding.dart';
import 'package:flutter_study_demo/music/page/recommend/recommend_page.dart';
import 'package:flutter_study_demo/page/main_new_home_page.dart';
import 'package:flutter_study_demo/page/rich_text_page.dart';
import 'package:flutter_study_demo/page/splash/bindings/splash_binding.dart';
import 'package:flutter_study_demo/page/splash/views/splash_page.dart';
import 'package:flutter_study_demo/route_auth_middleware.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:flutter_study_demo/todoList/todo_list_page.dart';
import 'package:flutter_study_demo/unknown_route_page.dart';
import 'package:flutter_study_demo/wan_android/home/wan_web_view_page.dart';
import 'package:flutter_study_demo/wan_android/project/project_binding.dart';
import 'package:flutter_study_demo/wan_android/project/project_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final unknownRoute = GetPage(
    name: AppRoutes.UNKNOWN_ROUTE_PAGE,
    page: () => UnknownRoutePage(),
  );

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
    //导航-中间件-认证 Auth
    GetPage(
      name: AppRoutes.RICH_TEXT,
      page: () => RichTextPage(),
      transition: Transition.leftToRightWithFade,
      // middlewares: [
      //   RouteAuthMiddleware(priority: 1),
      // ]
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
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.MUSIC_RANK_DETAIL_PAGE,
      page: () => RankDetailPage(),
      binding: RankDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.MUSIC_RANK_DETAIL_PAGE2,
      page: () => RankDetailPage2(),
      binding: RankDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.MUSIC_RECOMMEND_PAGE,
      page: () => RecommendPage(),
      binding: RecommendBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.WAN_NAVIGATION_PAGE,
    //   page: () => NavigationPage(),
    //   binding: NavigationBinding(),
    // ),

    GetPage(
      name: AppRoutes.WAN_PROJECT_PAGE,
      page: () => ProjectPage(),
      binding: ProjectBinding(),
    ),

    GetPage(
      name: AppRoutes.TO_DO_LIST_PAGE,
      page: () => TodoListPage(
        pageTitle: "请先写一个日志，模拟导航-中间件-认证 Auth",
      ),
    ),
  ];
}
