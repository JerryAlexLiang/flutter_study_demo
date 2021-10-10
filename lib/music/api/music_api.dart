class MusicApi{

  //音乐首页 http://m.kuwo.cn/newh5app/api/mobile/v1/home
  static const music_home = "http://m.kuwo.cn/newh5app/api/mobile/v1/home";

  //榜单详情 http://m.kuwo.cn/newh5app/api/mobile/v1/music/rank/16?pn=1&rn=20
  //String bangId, {int pn = 1, int rn = 20}
  static const rank_detail = "http://m.kuwo.cn/newh5app/api/mobile/v1/music/rank/";
  //?topId=16 排行榜 ID offset：偏移的页数 limit 返回歌曲的数量
  static const rank_detail2 = "http://iecoxe.top:5000/v1/kuwo/top";
}