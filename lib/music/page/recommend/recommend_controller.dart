import 'package:dio/dio.dart';
import 'package:flutter_study_demo/http/dio_method.dart';
import 'package:flutter_study_demo/http/dio_response.dart';
import 'package:flutter_study_demo/http/dio_util.dart';
import 'package:flutter_study_demo/music/model/music_recommend_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum LoadState { loading, fail, success, empty }

class RecommendController extends GetxController {
  var recommendModel = RecommendModel().obs;

  var recommendList = List<PrettyList>.empty(growable: true).obs;

  var isLoading = true.obs;

  var loadState = LoadState.loading.obs;

  //下拉刷新控制器
  RefreshController refreshController;

  CancelToken _cancelToken = CancelToken();

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  // 推荐歌单new http://m.kuwo.cn/newh5app/api/mobile/v1/playlist/rcm/new
  // 推荐歌单hot http://m.kuwo.cn/newh5app/api/mobile/v1/playlist/rcm/hot

  Future<void> loadData() async {
    DioUtil.baseUrl = "http://m.kuwo.cn/newh5app/api/mobile/v1/playlist/rcm";
    DioUtil.instance.openLog();

    loadState(LoadState.loading);

    DioResponse result = await DioUtil()
        .request("/new", method: DioMethod.get, cancelToken: _cancelToken);

    print('========>  recommend load success0  $result  ');

    if (result.code == DioResponseCode.SUCCESS) {
      loadState(LoadState.success);

      RecommendModel model = RecommendModel.fromJson(result.data);
      recommendModel.value = model;
      recommendList.assignAll(model.data.prettyList);

      print('========>  recommend load success1  ${model.toJson()}  ');
      print('========>  recommend load success2  ${model.data.total}  ');
      print('========>  recommend load success3  ${model.data.prettyList.length}  ');
    } else {
      loadState(LoadState.fail);
      Get.snackbar('Error', 'recommend load error...');
      print('========>  recommend load error... ${result.message}');
    }
  }
}
