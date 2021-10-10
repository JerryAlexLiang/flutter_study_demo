// To parse this JSON data, do
//
//     final musicRankDetailModel2 = musicRankDetailModel2FromJson(jsonString);

import 'dart:convert';

MusicRankDetailModel2 musicRankDetailModel2FromJson(String str) =>
    MusicRankDetailModel2.fromJson(json.decode(str));

String musicRankDetailModel2ToJson(MusicRankDetailModel2 data) =>
    json.encode(data.toJson());

class MusicRankDetailModel2 {
  MusicRankDetailModel2({
    this.code,
    this.curTime,
    this.data,
    this.msg,
    this.profileId,
    this.reqId,
    this.tId,
  });

  int code;
  int curTime;
  Data data;
  String msg;
  String profileId;
  String reqId;
  String tId;

  factory MusicRankDetailModel2.fromJson(Map<String, dynamic> json) =>
      MusicRankDetailModel2(
        code: json["code"],
        curTime: json["curTime"],
        data: Data.fromJson(json["data"]),
        msg: json["msg"],
        profileId: json["profileId"],
        reqId: json["reqId"],
        tId: json["tId"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "curTime": curTime,
        "data": data.toJson(),
        "msg": msg,
        "profileId": profileId,
        "reqId": reqId,
        "tId": tId,
      };
}

class Data {
  Data({
    this.img,
    this.num,
    this.pub,
    this.musicList,
  });

  String img;
  String num;
  DateTime pub;
  List<MusicList> musicList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        img: json["img"],
        num: json["num"],
        pub: DateTime.parse(json["pub"]),
        musicList: List<MusicList>.from(
            json["musicList"].map((x) => MusicList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "num": num,
        "pub":
            "${pub.year.toString().padLeft(4, '0')}-${pub.month.toString().padLeft(2, '0')}-${pub.day.toString().padLeft(2, '0')}",
        "musicList": List<dynamic>.from(musicList.map((x) => x.toJson())),
      };
}

class MusicList {
  MusicList({
    this.musicrid,
    this.barrage,
    this.artist,
    this.trend,
    this.pic,
    this.isstar,
    this.rid,
    this.duration,
    this.score100,
    this.contentType,
    this.rankChange,
    this.track,
    this.hasLossless,
    this.hasmv,
    this.releaseDate,
    this.album,
    this.albumid,
    this.pay,
    this.artistid,
    this.albumpic,
    this.originalsongtype,
    this.songTimeMinutes,
    this.isListenFee,
    this.pic120,
    this.name,
    this.online,
  });

  String musicrid;
  String barrage;
  String artist;
  Trend trend;
  String pic;
  int isstar;
  int rid;
  int duration;
  String score100;
  String contentType;
  String rankChange;
  int track;
  bool hasLossless;
  int hasmv;
  DateTime releaseDate;
  String album;
  int albumid;
  String pay;
  int artistid;
  String albumpic;
  int originalsongtype;
  String songTimeMinutes;
  bool isListenFee;
  String pic120;
  String name;
  int online;

  factory MusicList.fromJson(Map<String, dynamic> json) => MusicList(
        musicrid: json["musicrid"],
        barrage: json["barrage"],
        artist: json["artist"],
        trend: trendValues.map[json["trend"]],
        pic: json["pic"],
        isstar: json["isstar"],
        rid: json["rid"],
        duration: json["duration"],
        score100: json["score100"],
        contentType: json["content_type"],
        rankChange: json["rank_change"],
        track: json["track"],
        hasLossless: json["hasLossless"],
        hasmv: json["hasmv"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        album: json["album"],
        albumid: json["albumid"],
        pay: json["pay"],
        artistid: json["artistid"],
        albumpic: json["albumpic"],
        originalsongtype: json["originalsongtype"],
        songTimeMinutes: json["songTimeMinutes"],
        isListenFee: json["isListenFee"],
        pic120: json["pic120"],
        name: json["name"],
        online: json["online"],
      );

  Map<String, dynamic> toJson() => {
        "musicrid": musicrid,
        "barrage": barrage,
        "artist": artist,
        "trend": trendValues.reverse[trend],
        "pic": pic,
        "isstar": isstar,
        "rid": rid,
        "duration": duration,
        "score100": score100,
        "content_type": contentType,
        "rank_change": rankChange,
        "track": track,
        "hasLossless": hasLossless,
        "hasmv": hasmv,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "album": album,
        "albumid": albumid,
        "pay": pay,
        "artistid": artistid,
        "albumpic": albumpic,
        "originalsongtype": originalsongtype,
        "songTimeMinutes": songTimeMinutes,
        "isListenFee": isListenFee,
        "pic120": pic120,
        "name": name,
        "online": online,
      };
}

enum Trend { U0, D0 }

final trendValues = EnumValues({"d0": Trend.D0, "u0": Trend.U0});

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
