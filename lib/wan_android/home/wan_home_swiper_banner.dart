import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/model/wan_home_banner_bean.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Wan首页Banner组建编写
class WanHomeSwiperBanner extends StatelessWidget {
  // final List wanHomeBannerList;

  // WanHomeSwiperBanner({Key key, this.wanHomeBannerList}) : super(key: key);

  final WanHomeBannerBean bean;

  WanHomeSwiperBanner(this.bean);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(160),
      child: Swiper(
        itemCount: bean.data.length,
        pagination: new SwiperPagination(),
        autoplay: true,
        itemBuilder: (context, index) {
          Image image = Image.network(
            bean.data[index].imagePath,
            fit: BoxFit.fill,
          );
          return InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: bean.data[index].title);
            },
            child: image,
          );
        },
      ),
    );
  }
}
