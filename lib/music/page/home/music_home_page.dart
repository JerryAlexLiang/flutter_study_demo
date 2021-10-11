import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/model/wan_home_article_bean.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:flutter_study_demo/music/page/home/music_home_banner.dart';
import 'package:flutter_study_demo/music/page/home/music_home_controller.dart';
import 'package:flutter_study_demo/music/page/home/music_home_playlist_widget.dart';
import 'package:flutter_study_demo/music/page/home/play_list_card_widget.dart';
import 'package:flutter_study_demo/music/page/home/radio_music_list_widget.dart';
import 'package:flutter_study_demo/music/page/home/rank_music_card_widget.dart';
import 'package:flutter_study_demo/music/page/home/rank_music_rectangle_widget.dart';
import 'package:flutter_study_demo/music/page/widget/title_arrow_item.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:flutter_study_demo/wan_android/home/wan_home_article_list_item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MusicHomePage extends GetView<MusicHomeController> {
  final defaultImage =
      "https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/42eced211a394a76ae527f1aab45a4a2~tplv-k3u1fbpfcp-zoom-crop-mark:1304:1304:1304:734.image";

  @override
  Widget build(BuildContext context) {
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
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: controller.refreshController,
      onRefresh: () => controller.refreshData(),
      onLoading: () => controller.loadMoreArticleList(),
      child: ListView(
        children: [
          _homeBanner(),
          _recommendMusic(),
          _radioList(),
          _rankListMusic(),
          _articleListPage(),
          _bottomPlaceHolder(),
        ],
      ),
    );
  }

  Container _recommendMusic() {
    var playlistList = controller?.playlistList;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      // child: recommendMusic(),
      child: Column(
        children: [
          TitleArrowItem(
            title: '推荐歌单',
            callback: () => Get.toNamed(AppRoutes.MUSIC_RECOMMEND_PAGE),
          ),
          MusicHomePlayListWidget(
            playlistList: playlistList,
          ),
        ],
      ),
    );
  }

  Container _homeBanner() {
    var bannerList = controller?.bannerList;
    return Container(
      height: 180,
      // child: homeBanner(),
      child: MusicHomeBanner(
        bannerList: bannerList,
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
            // padding: EdgeInsets.symmetric(vertical: 0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.7,
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
      // child: Image.network(
      //   playlistItem?.pic,
      //   fit: BoxFit.cover,
      // ),
      child: PlayListCardWidget(
        playlistItem: playlistItem,
      ),
    );
  }

  _radioList() {
    var radioList = controller?.radioList;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Column(
        children: [
          TitleArrowItem(
            title: '广播',
            callback: () => Fluttertoast.showToast(msg: '广播剧'),
          ),
          RadioMusicListWidget(
            radioItemList: radioList,
          ),
        ],
      ),
    );
  }

  Widget _rankListMusic() {
    var rankList = controller?.rankList;

    // List<Widget> items = [];

    // items.add(
    //   TitleArrowItem(
    //     title: '排行榜',
    //     callback: () => Fluttertoast.showToast(msg: '排行榜'),
    //   ),
    // );

    // if (rankList != null) {
    //   var rankItems = rankList.map((element) => Text(element.label)).toList();
    //   items.addAll(rankItems);
    // }

    var rankMusicCardList = rankList
        ?.map((element) => RankMusicCardWidget(rankItem: element))
        ?.toList();

    var rankMusicRectangleList = rankList
        ?.map((element) => RankMusicRectangleWidget(rankItem: element))
        ?.toList();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      // child: Column(
      //   children: items,
      // ),
      child: Column(
        children: [
          TitleArrowItem(
            title: '排行榜',
            callback: () => Fluttertoast.showToast(msg: '排行榜'),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: rankMusicCardList,
          // ),
          Wrap(
            runSpacing: 4,
            children: rankMusicCardList,
          ),
          // Column(
          //   children: items,
          // ),
          // TitleArrowItem(
          //   title: '排行榜2',
          //   callback: () => Fluttertoast.showToast(msg: '排行榜'),
          // ),
          // // Wrap(
          // //   runSpacing: 4,
          // //   children: [
          // //     Row(
          // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // //       children: rankMusicCardList,
          // //     ),
          // //     Row(
          // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // //       children: rankMusicCardList,
          // //     ),
          // //   ],
          // // ),
          //
          // Wrap(
          //   runSpacing: 4,
          //   children: [
          //     Wrap(
          //       children: rankMusicCardList,
          //     ),
          //     Wrap(
          //       children: rankMusicCardList,
          //     ),
          //   ],
          // ),
          TitleArrowItem(
            title: '排行榜2',
            callback: () => Fluttertoast.showToast(msg: '排行榜'),
          ),
          Wrap(
            runSpacing: 5,
            children: rankMusicRectangleList,
          ),
        ],
      ),
    );
  }

  _articleListPage() {
    var articleList = controller.articleList;
    var list = articleList.map((element) => _articleListItem(element)).toList();

    return Wrap(
      spacing: 1,
      children: list,
    );

    // return Obx(() {
    //   return Container(
    //     child:  Wrap(
    //       spacing: 1,
    //       children: articleList.map((element) => _articleListItem(element)).toList(),
    //     ),
    //   );
    // });
  }

  Widget _articleListItem(Datas item) {
    return Container(
      width: Get.width,
      height: ScreenUtil().setHeight(200),
      color: Colors.grey.withOpacity(0.1),
      child: Center(
        child: WanHomeArticleListItem(item),
      ),
    );
  }

  _bottomPlaceHolder() {
    return Container(
      child: SizedBox(
        height: 10,
      ),
    );
  }
}
