//酷我接口
import 'package:dio/dio.dart';
import 'package:flutter_study_demo/music/api/music_api.dart';

abstract class MusicHttpManager {

  ///获取首页数据
  static Future<Response> getMusicHomeModel() async {
    var response = await Dio().get(MusicApi.music_home);
    return response;
  }
}
