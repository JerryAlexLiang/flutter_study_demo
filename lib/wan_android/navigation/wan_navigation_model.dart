// To parse this JSON data, do
//
//     final wanNavigationModel = wanNavigationModelFromJson(jsonString);

import 'dart:convert';

WanNavigationModel wanNavigationModelFromJson(String str) =>
    WanNavigationModel.fromJson(json.decode(str));

String wanNavigationModelToJson(WanNavigationModel data) =>
    json.encode(data.toJson());

class WanNavigationModel {
  WanNavigationModel({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  List<Datum> data;
  int errorCode;
  String errorMsg;

  factory WanNavigationModel.fromJson(Map<String, dynamic> json) =>
      WanNavigationModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
      };
}

class Datum {
  Datum({
    this.articles,
    this.cid,
    this.name,
  });

  List<Article> articles;
  int cid;
  String name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
        cid: json["cid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "cid": cid,
        "name": name,
      };
}

class Article {
  Article({
    this.apkLink,
    this.audit,
    this.author,
    this.canEdit,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.descMd,
    this.envelopePic,
    this.fresh,
    this.host,
    this.id,
    this.link,
    this.niceDate,
    this.niceShareDate,
    this.origin,
    this.prefix,
    this.projectLink,
    this.publishTime,
    this.realSuperChapterId,
    this.selfVisible,
    this.shareDate,
    this.shareUser,
    this.superChapterId,
    this.superChapterName,
    this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  });

  String apkLink;
  int audit;
  Author author;
  bool canEdit;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  Desc desc;
  String descMd;
  String envelopePic;
  bool fresh;
  String host;
  int id;
  String link;
  String niceDate;
  String niceShareDate;
  String origin;
  String prefix;
  String projectLink;
  int publishTime;
  int realSuperChapterId;
  int selfVisible;
  int shareDate;
  ShareUser shareUser;
  int superChapterId;
  String superChapterName;
  List<dynamic> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        apkLink: json["apkLink"],
        audit: json["audit"],
        author: authorValues.map[json["author"]],
        canEdit: json["canEdit"],
        chapterId: json["chapterId"],
        chapterName: json["chapterName"],
        collect: json["collect"],
        courseId: json["courseId"],
        desc: descValues.map[json["desc"]],
        descMd: json["descMd"],
        envelopePic: json["envelopePic"],
        fresh: json["fresh"],
        host: json["host"],
        id: json["id"],
        link: json["link"],
        niceDate: json["niceDate"],
        niceShareDate: json["niceShareDate"],
        origin: json["origin"],
        prefix: json["prefix"],
        projectLink: json["projectLink"],
        publishTime: json["publishTime"],
        realSuperChapterId: json["realSuperChapterId"],
        selfVisible: json["selfVisible"],
        shareDate: json["shareDate"] == null ? null : json["shareDate"],
        shareUser: shareUserValues.map[json["shareUser"]],
        superChapterId: json["superChapterId"],
        superChapterName: json["superChapterName"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        title: json["title"],
        type: json["type"],
        userId: json["userId"],
        visible: json["visible"],
        zan: json["zan"],
      );

  Map<String, dynamic> toJson() => {
        "apkLink": apkLink,
        "audit": audit,
        "author": authorValues.reverse[author],
        "canEdit": canEdit,
        "chapterId": chapterId,
        "chapterName": chapterName,
        "collect": collect,
        "courseId": courseId,
        "desc": descValues.reverse[desc],
        "descMd": descMd,
        "envelopePic": envelopePic,
        "fresh": fresh,
        "host": host,
        "id": id,
        "link": link,
        "niceDate": niceDate,
        "niceShareDate": niceShareDate,
        "origin": origin,
        "prefix": prefix,
        "projectLink": projectLink,
        "publishTime": publishTime,
        "realSuperChapterId": realSuperChapterId,
        "selfVisible": selfVisible,
        "shareDate": shareDate == null ? null : shareDate,
        "shareUser": shareUserValues.reverse[shareUser],
        "superChapterId": superChapterId,
        "superChapterName": superChapterName,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "title": title,
        "type": type,
        "userId": userId,
        "visible": visible,
        "zan": zan,
      };
}

enum Author { EMPTY, GANK_IO, AUTHOR, PURPLE, MZLOGIN, FLUFFY }

final authorValues = EnumValues({
  "速查小编": Author.AUTHOR,
  "小编": Author.EMPTY,
  "": Author.FLUFFY,
  "gank.io": Author.GANK_IO,
  "mzlogin": Author.MZLOGIN,
  "于卫国": Author.PURPLE
});

enum Desc { EMPTY, ADB_USAGE_COMPLETE_ADB }

final descValues = EnumValues({
  "ADB Usage Complete / ADB 用法大全\u000d\n": Desc.ADB_USAGE_COMPLETE_ADB,
  "": Desc.EMPTY
});

enum ShareUser { EMPTY, SHARE_USER }

final shareUserValues =
    EnumValues({"": ShareUser.EMPTY, "鸿洋": ShareUser.SHARE_USER});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
