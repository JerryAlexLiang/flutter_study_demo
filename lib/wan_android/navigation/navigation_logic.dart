import 'package:flutter_study_demo/http/LoadState.dart';
import 'package:flutter_study_demo/http/dio_method.dart';
import 'package:flutter_study_demo/http/dio_util.dart';
import 'package:flutter_study_demo/wan_android/navigation/wan_navigation_model.dart';
import 'package:get/get.dart';

class NavigationLogic extends GetxController {
  var navigationList = List<Datum>.empty(growable: true).obs;
  var currentNavigation = Datum().obs;
  var articleList = List<Article>.empty(growable: true).obs;

  var loadState = LoadState.loading.obs;

  @override
  void onInit() {
    super.onInit();
    DioUtil.baseUrl = "https://www.wanandroid.com";
    DioUtil.instance.openLog();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loadData() async {
    //https://www.wanandroid.com/navi/json

    try {
      loadState(LoadState.loading);

      var result = await DioUtil().request("/navi/json", method: DioMethod.get);

      print('========>  navigation load success 0  $result  ');

      var model = WanNavigationModel.fromJson(result);

      print('========>  navigation load success 1  ${model.toJson()}  ');

      if (model != null) {
        loadState(LoadState.success);
        
        navigationList.assignAll(model.data);
        if (navigationList != null && navigationList.length > 0) {
          //默认定位第一个导航栏
          currentNavigation.value = navigationList[0];
        }
      } else {
        loadState(LoadState.empty);
      }
    } on Exception catch (e) {
      loadState(LoadState.fail);
      Get.snackbar('Error', 'load error...${e.toString()}');
    }
  }

  ///点击切换导航
  void changeNavigation(Datum nav) {
    currentNavigation.value = nav;
  }
}
