// To parse this JSON data, do
//
//     final recommendModel = recommendModelFromJson(jsonString);

import 'dart:convert';

RecommendModel recommendModelFromJson(String str) =>
    RecommendModel.fromJson(json.decode(str));

String recommendModelToJson(RecommendModel data) => json.encode(data.toJson());

class RecommendModel {
  RecommendModel({
    this.success,
    this.code,
    this.data,
  });

  bool success;
  int code;
  Data data;

  factory RecommendModel.fromJson(Map<String, dynamic> json) => RecommendModel(
        success: json["success"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.type,
    this.total,
    this.prettyList,
  });

  String type;
  int total;
  List<PrettyList> prettyList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        total: json["total"],
        prettyList: List<PrettyList>.from(
            json["prettyList"].map((x) => PrettyList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "total": total,
        "prettyList": List<dynamic>.from(prettyList.map((x) => x.toJson())),
      };
}

class PrettyList {
  PrettyList({
    this.id,
    this.name,
    this.pic,
    this.artistName,
    this.countPlay,
    this.desc,
  });

  String id;
  String name;
  String pic;
  String artistName;
  String countPlay;
  String desc;

  factory PrettyList.fromJson(Map<String, dynamic> json) => PrettyList(
        id: json["id"],
        name: json["name"],
        pic: json["pic"],
        artistName: json["artist_name"],
        countPlay: json["count_play"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pic": pic,
        "artist_name": artistName,
        "count_play": countPlay,
        "desc": desc,
      };
}
