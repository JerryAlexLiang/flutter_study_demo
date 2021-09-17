class MusicHomeModel {
  bool success;
  int code;
  Data data;

  MusicHomeModel({this.success, this.code, this.data});

  MusicHomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<BannerItem> bannerList;
  List<RankItem> rankList;
  List<PlaylistItem> playlistList;
  List<RadioItem> radioList;

  Data({this.bannerList, this.rankList, this.playlistList, this.radioList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banner_list'] != null) {
      bannerList = new List<BannerItem>();
      json['banner_list'].forEach((v) {
        bannerList.add(new BannerItem.fromJson(v));
      });
    }
    if (json['rank_list'] != null) {
      rankList = new List<RankItem>();
      json['rank_list'].forEach((v) {
        rankList.add(new RankItem.fromJson(v));
      });
    }
    if (json['playlist_list'] != null) {
      playlistList = new List<PlaylistItem>();
      json['playlist_list'].forEach((v) {
        playlistList.add(new PlaylistItem.fromJson(v));
      });
    }
    if (json['radio_list'] != null) {
      radioList = new List<RadioItem>();
      json['radio_list'].forEach((v) {
        radioList.add(new RadioItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerList != null) {
      data['banner_list'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.rankList != null) {
      data['rank_list'] = this.rankList.map((v) => v.toJson()).toList();
    }
    if (this.playlistList != null) {
      data['playlist_list'] = this.playlistList.map((v) => v.toJson()).toList();
    }
    if (this.radioList != null) {
      data['radio_list'] = this.radioList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerItem {
  int id;
  String digest;
  String pic;
  String detail;

  BannerItem({this.id, this.digest, this.pic, this.detail});

  BannerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    digest = json['digest'];
    pic = json['pic'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['digest'] = this.digest;
    data['pic'] = this.pic;
    data['detail'] = this.detail;
    return data;
  }
}

class RankItem {
  String typeId;
  String label;
  String publish;
  String picIcon;
  String picBg;
  String picTitle;
  String total;
  List<RankMusicItem> list;

  RankItem(
      {this.typeId,
      this.label,
      this.publish,
      this.picIcon,
      this.picBg,
      this.picTitle,
      this.total,
      this.list});

  RankItem.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    label = json['label'];
    publish = json['publish'];
    picIcon = json['pic_icon'];
    picBg = json['pic_bg'];
    picTitle = json['pic_title'];
    total = json['total'];
    if (json['list'] != null) {
      list = <RankMusicItem>[];
      json['list'].forEach((v) {
        list.add(new RankMusicItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['label'] = this.label;
    data['publish'] = this.publish;
    data['pic_icon'] = this.picIcon;
    data['pic_bg'] = this.picBg;
    data['pic_title'] = this.picTitle;
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RankMusicItem {
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

  RankMusicItem(
      {this.id,
      this.name,
      this.pic,
      this.albumName,
      this.artistName,
      this.mvStatus,
      this.mvPayInfo,
      this.pay,
      this.online,
      this.payInfo});

  RankMusicItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pic = json['pic'];
    albumName = json['album_name'];
    artistName = json['artist_name'];
    mvStatus = json['mv_status'];
    mvPayInfo = json['mv_pay_info'] != null
        ? new MvPayInfo.fromJson(json['mv_pay_info'])
        : null;
    pay = json['pay'];
    online = json['online'];
    payInfo = json['pay_info'] != null
        ? new PayInfo.fromJson(json['pay_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['album_name'] = this.albumName;
    data['artist_name'] = this.artistName;
    data['mv_status'] = this.mvStatus;
    if (this.mvPayInfo != null) {
      data['mv_pay_info'] = this.mvPayInfo.toJson();
    }
    data['pay'] = this.pay;
    data['online'] = this.online;
    if (this.payInfo != null) {
      data['pay_info'] = this.payInfo.toJson();
    }
    return data;
  }
}

class MvPayInfo {
  int play;
  int vid;
  int down;

  MvPayInfo({this.play, this.vid, this.down});

  MvPayInfo.fromJson(Map<String, dynamic> json) {
    play = json['play'];
    vid = json['vid'];
    down = json['down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['play'] = this.play;
    data['vid'] = this.vid;
    data['down'] = this.down;
    return data;
  }
}

class PayInfo {
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

  PayInfo(
      {this.play,
      this.download,
      this.localEncrypt,
      this.limitfree,
      this.cannotDownload,
      this.refrainStart,
      this.refrainEnd,
      this.cannotOnlinePlay,
      this.feeType,
      this.down});

  PayInfo.fromJson(Map<String, dynamic> json) {
    play = json['play'];
    download = json['download'];
    localEncrypt = json['local_encrypt'];
    limitfree = json['limitfree'];
    cannotDownload = json['cannotDownload'];
    refrainStart = json['refrain_start'];
    refrainEnd = json['refrain_end'];
    cannotOnlinePlay = json['cannotOnlinePlay'];
    feeType =
        json['feeType'] != null ? new FeeType.fromJson(json['feeType']) : null;
    down = json['down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['play'] = this.play;
    data['download'] = this.download;
    data['local_encrypt'] = this.localEncrypt;
    data['limitfree'] = this.limitfree;
    data['cannotDownload'] = this.cannotDownload;
    data['refrain_start'] = this.refrainStart;
    data['refrain_end'] = this.refrainEnd;
    data['cannotOnlinePlay'] = this.cannotOnlinePlay;
    if (this.feeType != null) {
      data['feeType'] = this.feeType.toJson();
    }
    data['down'] = this.down;
    return data;
  }
}

class FeeType {
  String song;
  String vip;

  FeeType({this.song, this.vip});

  FeeType.fromJson(Map<String, dynamic> json) {
    song = json['song'];
    vip = json['vip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['song'] = this.song;
    data['vip'] = this.vip;
    return data;
  }
}

class PlaylistItem {
  String id;
  String name;
  String pic;
  String artistName;
  String countPlay;
  String desc;

  PlaylistItem(
      {this.id,
      this.name,
      this.pic,
      this.artistName,
      this.countPlay,
      this.desc});

  PlaylistItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pic = json['pic'];
    artistName = json['artist_name'];
    countPlay = json['count_play'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['artist_name'] = this.artistName;
    data['count_play'] = this.countPlay;
    data['desc'] = this.desc;
    return data;
  }
}

class RadioItem {
  String id;
  String name;
  String pic;
  String artistId;
  String artistName;
  String isstar;
  String countPlay;
  String countMusic;
  String desc;

  RadioItem(
      {this.id,
      this.name,
      this.pic,
      this.artistId,
      this.artistName,
      this.isstar,
      this.countPlay,
      this.countMusic,
      this.desc});

  RadioItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pic = json['pic'];
    artistId = json['artist_id'];
    artistName = json['artist_name'];
    isstar = json['isstar'];
    countPlay = json['count_play'];
    countMusic = json['count_music'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['artist_id'] = this.artistId;
    data['artist_name'] = this.artistName;
    data['isstar'] = this.isstar;
    data['count_play'] = this.countPlay;
    data['count_music'] = this.countMusic;
    data['desc'] = this.desc;
    return data;
  }
}
