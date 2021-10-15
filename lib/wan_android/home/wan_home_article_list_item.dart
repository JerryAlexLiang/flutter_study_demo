import 'package:flutter/material.dart';
import 'package:flutter_study_demo/model/wan_home_article_bean.dart';
import 'package:flutter_study_demo/routes/app_routes.dart';
import 'package:flutter_study_demo/wan_android/project/wan_article_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WanHomeArticleListItem extends StatefulWidget {
  final WanArticleModel item;

  // WanHomeArticleListItem({this.item});

  WanHomeArticleListItem(this.item);

  @override
  _WanHomeArticleListItemState createState() => _WanHomeArticleListItemState();
}

class _WanHomeArticleListItemState extends State<WanHomeArticleListItem> {
  final defaultImageUrl =
      // "https://img1.baidu.com/it/u=2620121525,3057821586&fm=26&fmt=auto&gp=0.jpg";
      "http://gank.io/images/d6bba8cf5b8c40f9ad229844475e9149";

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        //保持按压区域水波纹区域和Card区域保持一致
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(5),
          child: item(),
        ),
        onTap: () {
          Fluttertoast.showToast(msg: widget.item.title);
          Get.toNamed(
            AppRoutes.WAN_WEB_VIEW,
            arguments: widget.item,
          );
        },
      ),
    );
  }

  item() {
    return Row(
      //条目拼合
      children: [
        imageContainer(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: centerContainer(),
          ),
        ),
      ],
    );
  }

  imageContainer() {
    var isOffstageIcon = true; //默认不显示
    var envelopePic = widget.item.envelopePic;
    var imageUrl = "";
    if (envelopePic != null && envelopePic != "") {
      imageUrl = envelopePic;
      isOffstageIcon = false;
    } else {
      imageUrl = defaultImageUrl;
      isOffstageIcon = true;
    }
    return Offstage(
      offstage: isOffstageIcon,
      child: Container(
        width: 130,
        height: 80,
        decoration: BoxDecoration(
          //背景渐变
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
            ],
          ),
          //阴影
          boxShadow: [
            BoxShadow(
                color: Colors.yellow,
                offset: Offset(3.0, 3.0),
                //模糊阴影
                blurRadius: 3.0),
          ],
          //边框
          border: Border.all(
            color: Colors.blue,
            width: 1,
            style: BorderStyle.solid,
          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  centerContainer() {
    var title = widget.item.title;
    if (title == null || title == "") {
      title = "致一科技";
    }
    var desc = widget.item.desc;
    if (desc == null || desc == "") {
      desc = "致一科技";
    }
    var author = widget.item.author;
    if (author == null || author == "") {
      author = "致一科技";
    }
    var date = widget.item.niceDate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround, //两头空一半
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly, //均匀平分
      // mainAxisAlignment: MainAxisAlignment.spaceBetween, //中间孩子平分
      //竖直排列
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Flexible(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            spacing: 5,
            children: [
              Icon(
                Icons.book,
                color: Colors.blue,
                size: 15,
              ),
              Text(
                author,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 5,
            children: [
              Icon(
                Icons.timer,
                color: Colors.red,
                size: 15,
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  descContainer() {
    var desc = widget.item.desc;
    if (desc != null && desc != "") {
      return Container(
        padding: EdgeInsets.only(right: 5),
        child: Text(
          desc,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 8,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 1,
      );
    }
  }
}
