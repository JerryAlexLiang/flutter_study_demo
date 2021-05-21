import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_study_demo/model/wan_home_banner_bean.dart';
import 'package:flutter_study_demo/service/service_method.dart';
import 'package:flutter_study_demo/wan_android/home/wan_home_swiper_banner.dart';

import 'eye_category_list_page.dart';

class WanHomePage extends StatefulWidget {
  WanHomePage({Key key}) : super(key: key);

  @override
  _WanHomePageState createState() {
    return _WanHomePageState();
  }
}

//混入AutomaticKeepAliveClientMixin，这是保持状态的关键
//然后重写wantKeepAlive 的值为true
class _WanHomePageState extends State<WanHomePage>
    with AutomaticKeepAliveClientMixin {
  String wanHomeBanner = '首页Banner';

  // @override
  // bool get wantKeepAlive{
  //   return true;
  // }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // getWanHomeTopBanner().then((value) {
    //   setState(() {
    //     wanHomeBanner = value.toString();
    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('首页'),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Text(wanHomeBanner),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    //FutureBuilder Widget 是 Flutter内置的组件，是用来等待异步请求的
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: FutureBuilder(
        future: getWanHomeTopBanner(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Flutter Dart 报错 '_InternalLinkedHashMap dynamic,
            // dynamic' is not a subtype of type'
            //类型转换错误，使用如下转换就可以了: new Map<String, dynamic>.from(params)
            Map map = new Map<String, dynamic>.from(snapshot.data);
            print('======>  =====>  =====>1   ${snapshot.data.toString()}');
            WanHomeBannerBean bean = WanHomeBannerBean.fromJson(map);
            print('======>  =====>  =====>2   $bean');
            // return Column(
            //   children: [
            //     WanHomeSwiperBanner(bean),
            //     EyeCategoryListPage(),
            //   ],
            // );

            return SingleChildScrollView(
              child: Column(
                children: [
                  WanHomeSwiperBanner(bean),
                  EyeCategoryListPage(),
                  Container(
                    height: 200,
                    child: Center(
                      child: Text('demo'),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }
}
