import 'package:dio/dio.dart';
import 'package:flutter_study_demo/http/dio_method.dart';
import 'package:flutter_study_demo/http/dio_response.dart';
import 'package:flutter_study_demo/http/dio_util.dart';
import 'package:flutter_study_demo/music/model/music_home_model.dart';
import 'package:flutter_study_demo/music/model/music_recommend_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum LoadState { loading, fail, success, empty }

class RecommendController extends GetxController
    with SingleGetTickerProviderMixin {
  var recommendModel = RecommendModel().obs;

  // var recommendList = List<PrettyList>.empty(growable: true).obs;
  var recommendList = List<PlaylistItem>.empty(growable: true).obs;

  var loadState = LoadState.loading.obs;

  var recommendType = '热门'.obs;

  var type = "";

  //下拉刷新控制器
  RefreshController refreshController;

  CancelToken _cancelToken = CancelToken();

  @override
  void onInit() {
    super.onInit();

    DioUtil.baseUrl = "http://m.kuwo.cn/newh5app/api/mobile/v1/playlist/rcm";
    DioUtil.instance.openLog();

    refreshController = RefreshController(initialRefresh: false);

    /// Workers将协助你在事件发生时触发特定的回调
    ///
    /// 注意：Worker应该总是在启动Controller或Class时使用，所以应该总是在onInit(推荐)、
    /// Class构造函数或StatefulWidget的initState(大多数情况下不推荐这种做法，但应该不会有任何副作用)。
    ///
    /// 1、ever 每当Rx变量发出一个新的值时，就会被调用；
    /// 2、everAll 和 "ever "很像，但它需要一个Rx值的 "List"，每次它的变量被改变时都会被调用。就是这样；
    /// 3、once 'once'只在变量第一次被改变时被调用；
    /// 4、debounce debounce'在搜索函数中非常有用，你只希望API在用户完成输入时被调用。
    /// 如果用户输入 "Jonny"，你将在API中进行5次搜索，分别是字母J、o、n、n和y。使用Get不会发生这种情况，因为你将有一个 "debounce "Worker，它只会在输入结束时触发；
    /// 5、interval 'interval'与debouce不同，debouce如果用户在1秒内对一个变量进行了1000次修改，他将在规定的计时器（默认为800毫秒）后只发送最后一次修改。
    /// Interval则会忽略规定时间内的所有用户操作。如果你发送事件1分钟，每秒1000个，那么当用户停止DDOS事件时，debounce将只发送最后一个事件。
    /// 建议这样做是为了避免滥用，在用户可以快速点击某样东西并获得一些好处的功能中（想象一下，用户点击某样东西可以赚取硬币，如果他在同一分钟内点击300次，
    /// 他就会有300个硬币，使用间隔，你可以设置时间范围为3秒，无论是点击300次或100万次，1分钟内他最多获得20个硬币）。
    /// debounce适用于防DDOS，适用于搜索等功能，每次改变onChange都会调用你的api进行查询。
    /// Debounce会等待用户停止输入名称，进行请求。如果在上面提到的投币场景中使用它，用户只会赢得1个硬币，因为只有当用户 "暂停 "到既定时间时，它才会被执行。

    // ever 每当Rx变量发出一个新的值时，就会被调用。
    // ever(recommendType, (callback) => refreshController.requestRefresh());
    ever(recommendType, (callback) => loadData());

    // ever(
    //     recommendType,
    //     (callback) => loadState.value == LoadState.empty
    //         ? loadData()
    //         : refreshController.requestRefresh());

    //once 'once'只在变量第一次被改变时被调用；
    // once(recommendType, (callback) => loadData());
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

  Future<void> loadData([refresh = false]) async {
    try {
      if (!refresh) {
        loadState(LoadState.loading);
      }

      if (recommendType.value == "热门") {
        type = "hot";
      } else if (recommendType.value == "最新") {
        type = "new";
      } else {
        type = "test";
      }

      var result = await DioUtil().request("/" + type,
          method: DioMethod.get, cancelToken: _cancelToken);

      print('========>  recommend load type1  ${recommendType.value}  ');
      print('========>  recommend load type2  $recommendType  ');
      print('========>  recommend load success0  $result  ');

      if (result['success']) {
        RecommendModel model = RecommendModel.fromJson(result);
        print('========>  recommend load success1  ${model.toJson()}  ');

        if (model != null &&
            model.data != null &&
            model.data.prettyList != null) {
          if (!refresh) {
            loadState(LoadState.success);
          } else {
            refreshController.refreshCompleted();
          }

          recommendModel.value = model;
          recommendList.assignAll(model.data.prettyList);
        } else {
          if (!refresh) {
            loadState(LoadState.empty);
          } else {
            refreshController.refreshCompleted();
          }
        }
        print('========>  recommend load success1  ${model.toJson()}  ');
        print('========>  recommend load success2  ${model.data.total}  ');
      } else {
        if (!refresh) {
          loadState(LoadState.fail);
        } else {
          refreshController.refreshFailed();
        }
        Get.snackbar('Error', 'recommend load error...');

        print('========>  recommend load success2  error');
      }
      // } on Exception catch (e) {
      //   if (!refresh) {
      //     loadState(LoadState.fail);
      //   } else {
      //     refreshController.refreshFailed();
      //   }
      //
      //   Get.snackbar('Error', 'recommend load error... ${e.toString()}');
      //   print('========>  recommend load error... ${e.toString()}');
      // }

    } on Exception catch (e) {
      loadState(LoadState.fail);
      Get.snackbar('Error', 'load error...${e.toString()}');
    }
  }
}
