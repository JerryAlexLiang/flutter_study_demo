import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_demo/config/service_url.dart';
import 'package:flutter_study_demo/model/EyeSubjectTopicsBean.dart';
import 'package:flutter_study_demo/model/EyeSubjectTopicsBean.dart';
import 'package:flutter_study_demo/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          print('======> getSpecialTopicsSuccess1   $bean');
          bool f = bean.adExist;
          print('======> getSpecialTopicsSuccess2   $f');
          String type = bean.itemList[0].data.dataType;
          print('======> getSpecialTopicsSuccess3   $type');
          List<ItemList> responseList = bean.itemList;
          print('======> getSpecialTopicsSuccess4   $responseList');

          return Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              children: [
                _titleWidget(),
                _eyeSubjectListView(responseList),
              ],
            ),
          );
        } else {
          return Container(
            child: Text('getSpecialTopicsFail'),
          );
        }
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
          top: BorderSide(width: 0.5, color: Colors.black12),
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: Text(
        '专题',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _eyeSubjectListView(List<ItemList> responseList) {
    return Container(
      height: ScreenUtil().setHeight(150),
      margin: EdgeInsets.only(top: 5.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: responseList.length,
        itemBuilder: (context, index) {
          return _eyeSubjectListItem(responseList, index);
        },
      ),
    );
  }

  Widget _eyeSubjectListItem(List<ItemList> responseList, int index) {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(msg: responseList[index].data.dataType);
      },
      child: Container(
        // height: ScreenUtil().setHeight(150),
        width: ScreenUtil().setWidth(300),
        margin: EdgeInsets.only(right: 3.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12),
          ),
        ),
        child: Image.network(
          responseList[index].data.image,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
