import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/config/service_url.dart';
import 'package:flutter_study_demo/model/EyeSubjectTopicsBean.dart';
import 'package:flutter_study_demo/model/EyeSubjectTopicsBean.dart';
import 'package:flutter_study_demo/service/service_method.dart';

//首页-开眼-专题列表
class HomeEyeSubjectPage extends StatefulWidget {
  HomeEyeSubjectPage({Key key}) : super(key: key);

  @override
  _HomeEyeSubjectPageState createState() {
    return _HomeEyeSubjectPageState();
  }
}

class _HomeEyeSubjectPageState extends State<HomeEyeSubjectPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: requestGet(EyeApi.specialTopicsUrl),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          EyeSubjectTopicsBean bean =
              EyeSubjectTopicsBean.fromJson(snapshot.data);
          print(
              '======> getSpecialTopicsSuccess1   ${snapshot.data.toString()}');
          print('======> getSpecialTopicsSuccess2   $bean');
          print('======> getSpecialTopicsSuccess3   ${bean.itemList}');

          List responseList = bean.itemList;
          // List<ItemList> list =
          //     responseList.map((e) => ItemList.fromJson(e)).toList();

          // responseList.map((e) {
          //   Map map = new Map<String, dynamic>.from(e);
          //   print('======> getSpecialTopicsSuccess5   $map');
          // });

          // List list = responseList.map((e) => ItemList.fromJson(e)).toList();
          // print('======> getSpecialTopicsSuccess5   $list');

          List<ItemList> list = [];
          // responseList.map((e) => list.add(ItemList.fromJson(e)));

          responseList.forEach((element) {
            print('======> getSpecialTopicsSuccess5   $element');
            // Map<String, dynamic> map = new Map<String, dynamic>.from(element);
            ItemList itemListBean = ItemList.fromJson(element);
            print('======> getSpecialTopicsSuccess6   ${itemListBean.data.dataType}');
          });
        } else {
          return Container(
            child: Text('getSpecialTopicsFail'),
          );
        }

        return Container(
          height: ScreenUtil().setHeight(380),
          margin: EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              _titleWidget(),
              // _eyeSubjectList(responseList),
            ],
          ),
        );
      },
    );
  }

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: Text(
        '专题',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _eyeSubjectList(responseList) {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: responseList.length,
        itemBuilder: (context, index) {
          return _eyeSubjectListItem(responseList, index);
        },
      ),
    );
  }

  Widget _eyeSubjectListItem(responseList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12),
          ),
        ),
        child: Image.network(responseList[index]),
      ),
    );
  }
}
