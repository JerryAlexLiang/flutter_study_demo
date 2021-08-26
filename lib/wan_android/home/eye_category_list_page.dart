import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/model/EyeCategoryBean.dart';
import 'package:flutter_study_demo/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EyeCategoryListPage extends StatefulWidget {
  EyeCategoryListPage({Key key}) : super(key: key);

  @override
  _EyeCategoryListPageState createState() {
    return _EyeCategoryListPageState();
  }
}

class _EyeCategoryListPageState extends State<EyeCategoryListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _gridViewItem(BuildContext context, EyeCategoryBean bean) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          splashColor: Colors.red,
          highlightColor: Colors.blue,
          onTap: () {
            Fluttertoast.showToast(msg: bean.name);
          },
          // child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      bean.bgPicture,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 1.0, bottom: 1.0),
                child: Text(
                  bean.name != null ? bean.name : "默认",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(24),
                    fontStyle: FontStyle.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEyeCategory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List responseList = snapshot.data as List;
          List<EyeCategoryBean> categoryList =
              responseList.map((e) => EyeCategoryBean.fromJson(e)).toList();

          print('======> getEyeCategorySuccess1   ${snapshot.data.toString()}');
          print('======> getEyeCategorySuccess2   $responseList');
          print('======> getEyeCategorySuccess3   $categoryList');

          if (categoryList.length > 10) {
            categoryList.removeRange(10, categoryList.length);
          }

          return Container(
            color: Colors.white,
            // margin: EdgeInsets.only(
            //   top: 5,
            //   left: 10,
            //   right: 10,
            // ),
            padding: EdgeInsets.only(
              top: 5,
              left: 10,
              right: 10,
              bottom: 5,
            ),
            // child: GridView.count(
            //   // childAspectRatio: 1,
            //   //是否允许内容适配 使用子控件的总长度来设置ListView的长度（这里的长度为高度)
            //   shrinkWrap: true,
            //   //如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动
            //   primary: false,
            //   //禁止滚动
            //   physics: NeverScrollableScrollPhysics(),
            //   mainAxisSpacing: 10,
            //   crossAxisSpacing: 10,
            //   crossAxisCount: 5,
            //   //使用了map循环，然后再使用toList()进行转换
            //   children: categoryList.map((bean) {
            //     return _gridViewItem(context, bean);
            //   }).toList(),
            // ),

            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return _gridViewItem(context, categoryList[index]);
              },
            ),
          );
        } else {
          return Container(
            child: Text('getEyeCategoryFail'),
          );
        }
      },
    );
  }
}
