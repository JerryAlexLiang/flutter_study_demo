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
}
