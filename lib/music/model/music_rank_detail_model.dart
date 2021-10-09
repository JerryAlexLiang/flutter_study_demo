// To parse this JSON data, do
//
//     final musicRankDetailModel = musicRankDetailModelFromJson(jsonString);

import 'dart:convert';

MusicRankDetailModel musicRankDetailModelFromJson(String str) => MusicRankDetailModel.fromJson(json.decode(str));

String musicRankDetailModelToJson(MusicRankDetailModel data) => json.encode(data.toJson());

class MusicRankDetailModel {
  MusicRankDetailModel({
    this.success,
    this.code,
    this.data,
  });

  bool success;
  int code;
  Data data;

  factory MusicRankDetailModel.fromJson(Map<String, dynamic> json) => MusicRankDetailModel(
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
    this.typeId,
    this.pic,
    this.label,
    this.publish,
    this.picBg,
    this.picTitle,
    this.total,
    this.list,
  });

  String typeId;
  String pic;
  String label;
  DateTime publish;
  String picBg;
  String picTitle;
  String total;               //共total首歌曲
  List<ListElement> list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    typeId: json["type_id"],
    pic: json["pic"],
    label: json["label"],
    publish: DateTime.parse(json["publish"]),
    picBg: json["pic_bg"],
    picTitle: json["pic_title"],
    total: json["total"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type_id": typeId,
    "pic": pic,
    "label": label,
    "publish": "${publish.year.toString().padLeft(4, '0')}-${publish.month.toString().padLeft(2, '0')}-${publish.day.toString().padLeft(2, '0')}",
    "pic_bg": picBg,
    "pic_title": picTitle,
    "total": total,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  ListElement({
    this.id,
    this.name,
    this.pic,
    this.albumName,
    this.artistName,
    this.mvStatus,
    this.mvPayInfo,
    this.pay,
    this.online,
    this.payInfo,
  });

  int id;
  String name;
  String pic;
  String albumName;
  String artistName;
  int mvStatus;
  MvPayInfo mvPayInfo;
  String pay;
  int online;
  PayInfo payInfo;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    name: json["name"],
    pic: json["pic"],
    albumName: json["album_name"],
    artistName: json["artist_name"],
    mvStatus: json["mv_status"],
    mvPayInfo: MvPayInfo.fromJson(json["mv_pay_info"]),
    pay: json["pay"],
    online: json["online"],
    payInfo: PayInfo.fromJson(json["pay_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pic": pic,
    "album_name": albumName,
    "artist_name": artistName,
    "mv_status": mvStatus,
    "mv_pay_info": mvPayInfo.toJson(),
    "pay": pay,
    "online": online,
    "pay_info": payInfo.toJson(),
  };
}

class MvPayInfo {
  MvPayInfo({
    this.play,
    this.vid,
    this.down,
  });

  int play;
  int vid;
  int down;

  factory MvPayInfo.fromJson(Map<String, dynamic> json) => MvPayInfo(
    play: json["play"],
    vid: json["vid"],
    down: json["down"],
  );

  Map<String, dynamic> toJson() => {
    "play": play,
    "vid": vid,
    "down": down,
  };
}

class PayInfo {
  PayInfo({
    this.play,
    this.download,
    this.localEncrypt,
    this.limitfree,
    this.cannotDownload,
    this.refrainStart,
    this.refrainEnd,
    this.cannotOnlinePlay,
    this.feeType,
    this.down,
    this.listenFragment,
  });

  String play;
  String download;
  String localEncrypt;
  int limitfree;
  int cannotDownload;
  int refrainStart;
  int refrainEnd;
  int cannotOnlinePlay;
  FeeType feeType;
  String down;
  String listenFragment;

  factory PayInfo.fromJson(Map<String, dynamic> json) => PayInfo(
    play: json["play"],
    download: json["download"],
    localEncrypt: json["local_encrypt"] == null ? null : json["local_encrypt"],
    limitfree: json["limitfree"],
    cannotDownload: json["cannotDownload"],
    refrainStart: json["refrain_start"],
    refrainEnd: json["refrain_end"],
    cannotOnlinePlay: json["cannotOnlinePlay"],
    feeType: FeeType.fromJson(json["feeType"]),
    down: json["down"],
    listenFragment: json["listen_fragment"] == null ? null : json["listen_fragment"],
  );

  Map<String, dynamic> toJson() => {
    "play": play,
    "download": download,
    "local_encrypt": localEncrypt == null ? null : localEncrypt,
    "limitfree": limitfree,
    "cannotDownload": cannotDownload,
    "refrain_start": refrainStart,
    "refrain_end": refrainEnd,
    "cannotOnlinePlay": cannotOnlinePlay,
    "feeType": feeType.toJson(),
    "down": down,
    "listen_fragment": listenFragment == null ? null : listenFragment,
  };
}

class FeeType {
  FeeType({
    this.song,
    this.vip,
  });

  String song;
  String vip;

  factory FeeType.fromJson(Map<String, dynamic> json) => FeeType(
    song: json["song"],
    vip: json["vip"],
  );

  Map<String, dynamic> toJson() => {
    "song": song,
    "vip": vip,
  };
}
