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
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(msg: bean.name);
      },
      child: Container(
        child: Column(
          children: [
            Image.network(
              bean.bgPicture,
              width: ScreenUtil().setWidth(130),
              // fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                bean.name != null ? bean.name : "默认",
                style: TextStyle(
                  color: Colors.black,
                  // fontSize: ScreenUtil().setSp(24),
                  fontStyle: FontStyle.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
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

          if (categoryList.length > 8) {
            categoryList.removeRange(8, categoryList.length);
          }

          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              //使用了map循环，然后再使用toList()进行转换
              children: categoryList.map((bean) {
                return _gridViewItem(context, bean);
              }).toList(),
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
