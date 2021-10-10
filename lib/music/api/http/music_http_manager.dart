//酷我接口
import 'package:dio/dio.dart';
import 'package:flutter_study_demo/music/api/music_api.dart';

abstract class MusicHttpManager {
  ///获取首页数据
  static Future<Response> getMusicHomeModel() async {
    var response = await Dio().get(MusicApi.music_home);
    return response;
  }

  ///获取音乐榜单详情数据
  static Future<Response> getRankDetailModel(String bangId,
      {int pn, int rn}) async {
    var response = await Dio().get(
      MusicApi.rank_detail + bangId,
      queryParameters: {'pn': pn, 'rn': rn},
    );
    return response;
  }

  /// 获取排行榜详情数据接口2
  /// ?topId=16 排行榜 ID offset：偏移的页数 limit 返回歌曲的数量
  static Future<Response> getRankDetailModel2(String topId,
      {int offset, int limit}) async {
    var response = await Dio().get(
      MusicApi.rank_detail2,
      queryParameters: {'topId': topId, 'offset': offset, 'limit': limit},
    );
    return response;
  }
}
