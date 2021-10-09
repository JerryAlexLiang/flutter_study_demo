import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/music/model/music_rank_detail_model.dart';
import 'package:flutter_study_demo/music/page/rank_detail/rank_detail_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankDetailPage extends GetView<RankDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SmartRefresher(
          controller: controller?.refreshController,
          onRefresh: () => controller?.refreshData(),
          child: CustomScrollView(
            controller: controller?.scrollController,
            slivers: [
              _buildSliversAppBar(),
              _buildSliverList(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSliversAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 240,
      collapsedHeight: 60,
      title: _sliverAppBarTitle(),
      bottom: _sliverAppBarBottom(),
      flexibleSpace: _flexibleSpaceBar(),
    );
  }

  _sliverAppBarTitle() {
    // return Opacity(
    //   //此处有bug
    //   // opacity: controller.percent.value ?? 0,
    //   child: Text('${controller.label ?? ''}'),
    // );

    return Text(
      '${controller.label ?? ''}',
    );
  }

  _sliverAppBarBottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: Container(
        width: Get.width,
        height: 40,
        color: Colors.transparent.withOpacity(0.3),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '共${controller?.rankDetailModel?.value?.total ?? 0}首',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                MaterialButton(
                  height: 30,
                  onPressed: () => Fluttertoast.showToast(msg: '播放全部'),
                  child: Text('播放全部'),
                  textColor: Colors.white,
                  color: Colors.transparent.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    // side: BorderSide(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _flexibleSpaceBar() {
    return FlexibleSpaceBar(
      background: Hero(
        tag: controller.label,
        // child: fadeInImage(),
        child: controller?.rankDetailModel?.value?.pic != null
            ? fadeInImage()
            : SizedBox(),
      ),
      //视差效果
      collapseMode: CollapseMode.parallax,
    );
  }

  FadeInImage fadeInImage() {
    return FadeInImage.assetNetwork(
      placeholder: 'images/icon_music_bg.jpg',
      image: controller?.rankDetailModel?.value?.pic,
      width: 100,
      fit: BoxFit.contain,
    );
  }

  _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildSongListItem(controller?.rankDetailList, index);
        },
        childCount: controller?.rankDetailList?.length,
      ),
    );
  }

  _buildSongListItem(RxList<ListElement> rankDetailList, int index) {
    return ListTile(
      onTap: () => Fluttertoast.showToast(
          msg: '${controller?.rankDetailList[index]?.name}'),
      title: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: '${index + 1}    ',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: '${rankDetailList[index]?.name}',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      trailing: Container(
        width: 100,
        child: Text(
          '${rankDetailList[index]?.artistName}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
