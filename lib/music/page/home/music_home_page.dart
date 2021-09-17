import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:flutter_study_demo/music/page/home/music_home_banner.dart';
import 'package:flutter_study_demo/music/page/home/music_home_controller.dart';
import 'package:flutter_study_demo/music/page/widget/title_arrow_item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MusicHomePage extends GetView<MusicHomeController> {
  final defaultImage =
      "https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/42eced211a394a76ae527f1aab45a4a2~tplv-k3u1fbpfcp-zoom-crop-mark:1304:1304:1304:734.image";

  @override
  Widget build(BuildContext context) {
    //使homeBodyntroller数据变化
    // return Obx(
    //   () => FutureBuilder(
    //     future: controller.futureX.value,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           return Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } else {
    //           return Center(
    //             // child: Obx(() => homeBody(controller.playlistList)),
    //             child: homeBody(controller.playlistList),
    //           );
    //         }
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    // );

    // return Obx(() {
    //   if (controller.isLoading.value) {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   } else {
    //     return Center(
    //       child: homeBody(controller.playlistList),
    //     );
    //   }
    // });

    return Scaffold(
      body: Obx(
        () {
          if (controller.loadState.value == LoadState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.loadState.value == LoadState.success) {
            return Center(
              // child: homeBody(controller.playlistList),
              child: homeView(),
            );
          } else if (controller.loadState.value == LoadState.empty) {
            return Center(
              child: Text('暂时无数据'),
            );
          } else if (controller.loadState.value == LoadState.fail) {
            return Center(
              child: Text('数据请求失败'),
            );
          }
          return null;
        },
      ),
    );
  }

  homeBody(RxList<PlaylistItem> playlistList) {
    //关于List的说明
    // List和它里面的对象一样，是完全可以观察的。这样一来，如果你在List中添加一个值，它会自动重建使用它的widget。
    // 不需要在List中使用".value"，神奇的dart api允许我们删除它。
    // 不幸的是，像String和int这样的原始类型不能被扩展，使得.value的使用是强制性的，但是如果你使用get和setter来处理这些类型，这将不是一个问题
    if (playlistList == null) return;
    var list2 = playlistList
        .map((element) => Text(
              element.name,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ))
        .toList();
    return ListView(
      children: list2,
    );
  }

  homeView() {
    var bannerList = controller?.bannerList;

    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: () => controller.refreshData(),
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 150,
            // child: homeBanner(),
            child: MusicHomeBanner(
              bannerList: bannerList,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: recommendMusic(),
          ),
        ],
      ),
    );
  }

  homeBanner() {
    var bannerList = controller?.bannerList;
    return Swiper(
      //滚动方向，设置为Axis.vertical如果需要垂直滚动
      // scrollDirection: Axis.vertical,
      //初始的时候下标位置
      // index: 1,
      //loop 无限轮播模式开关
      loop: true,
      //自动播放开关.
      autoplay: true,
      //自动播放延迟毫秒数.
      // autoplayDelay: 1000,
      //当用户拖拽的时候，是否停止自动播放.
      // autoplayDisableOnInteraction: false,
      // //动画时间，单位是毫秒
      // duration: 100,
      //scale：两侧item的缩放比
      scale: 0.99,
      //viewportFraction：视图宽度，即显示的item的宽度屏占比
      viewportFraction: 0.9,
      //指示器
      pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(
          bottom: 10,
          right: 30,
        ),
        // builder: SwiperPagination.dots,
        builder: SwiperPagination.fraction,
      ),
      itemCount: bannerList?.length ?? 0,
      itemBuilder: (context, index) => bannerItemView(
        bannerList[index],
      ),
      onTap: (index) => Fluttertoast.showToast(msg: '${bannerList[index].id}'),
    );
  }

  bannerItemView(BannerItem bannerItem) {
    var pic = bannerItem?.pic ?? this.defaultImage;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(pic),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }

  recommendMusic() {
    var playlistList = controller?.playlistList;
    return Column(
      children: [
        TitleArrowItem(
          title: '推荐歌单',
          callback: () => Fluttertoast.showToast(msg: "msg"),
        ),
        Container(
          child: GridView.builder(
            //去除GridView上方空白
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              // childAspectRatio: 1 / 1,
            ),
            itemCount: playlistList?.length,
            itemBuilder: (context, index) =>
                recommendMusicItem(playlistList[index]),
          ),
        ),
      ],
    );
  }

  recommendMusicItem(PlaylistItem playlistItem) {
    return Container(
      child: Image.network(
        playlistItem?.pic,
        fit: BoxFit.cover,
      ),
    );
  }
}
