import 'package:flutter/material.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MusicHomeBanner extends StatelessWidget {
  final List<BannerItem> bannerList;

  final defaultImage =
      "https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/42eced211a394a76ae527f1aab45a4a2~tplv-k3u1fbpfcp-zoom-crop-mark:1304:1304:1304:734.image";

  MusicHomeBanner({@required this.bannerList});

  @override
  Widget build(BuildContext context) {
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
}
