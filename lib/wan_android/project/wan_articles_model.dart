import 'package:flutter_study_demo/wan_android/project/wan_article_model.dart';

class WanArticlesModel {
  Data data;
  int errorCode;
  String errorMsg;

  WanArticlesModel({this.data, this.errorCode, this.errorMsg});

  WanArticlesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class Data {
  int curPage;
  List<WanArticleModel> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  Data(
      {this.curPage,
      this.datas,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = new List<WanArticleModel>();
      json['datas'].forEach((v) {
        datas.add(new WanArticleModel.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curPage'] = this.curPage;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['size'] = this.size;
    data['total'] = this.total;
    return data;
  }
}
