import 'package:dio/dio.dart';
import 'package:flutter_study_demo/http/dio_response.dart';
import 'package:flutter_study_demo/music/page/home/music_home_controller.dart';
import 'package:get/get.dart' as getX;

/// 自定义拦截器

/// 1、错误统一处理
/// 我们发现虽然Dio框架已经封装了一个DioError类库，但如果需要对返回的错误进行统一弹窗处理或者路由跳转等就只能自定义了;

/// 2、请求前统一处理
/// 在我们发送请求的时候会碰到几种情况，比如需要对非open开头的接口自动加上一些特定的参数，获取需要在请求头增加统一的token;

/// 3、响应前统一处理
/// 在我们请求接口前可以对响应数据进行一些基础的处理，比如对响应的结果进行自定义封装，还可以针对单独的url 做特殊处理等。

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // ///////// 业务需求 /////////
    // //对非open的接口的请求参数全部增加userId
    // if (!options.path.contains("open")) {
    //   options.queryParameters["userId"] = "xxx";
    // }
    //
    // //头部添加token
    // options.headers["token"] = "xxx";
    //
    // //更多业务需求
    //
    // ///////// 业务需求 /////////

    /// 重点
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    //请求成功时对数据做基本处理
    if (response.statusCode == 200) {
      // response = DioResponse(
      //   code: DioResponseCode.SUCCESS,
      //   message: "数据请求成功啦!!!",
      //   data: response.data,
      //   success: true,
      // );
      response = response;
    } else {
      response.data = DioResponse(
        code: DioResponseCode.ERROR,
        message: "数据请求失败啦!!!",
        data: null,
        success: false,
      );
    }

    ///////////// 根据公司的业务需求进行定制化处理 /////////////

    //对某些单独的url返回数据做特殊处理
    if (response.requestOptions.baseUrl.contains("??????")) {
      //...
    }

    ///////////// 根据公司的业务需求进行定制化处理 /////////////

    /// 重点
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
        // 连接服务器超时
        // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        getX.Get.snackbar('提示', '连接服务器超时');
        break;

      case DioErrorType.receiveTimeout:
        // 响应超时
        // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        getX.Get.snackbar('提示', '响应超时');
        break;

      case DioErrorType.sendTimeout:
        //发送超时
        // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        getX.Get.snackbar('提示', '发送超时');
        break;

      case DioErrorType.response:
        // 404/503错误
        // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        getX.Get.snackbar('提示', '接口异常 ${err.response.statusCode}');
        break;

      case DioErrorType.cancel:
        // 请求取消
        // 根据自己的业务需求来设定该如何操作,可以是弹出框提示/或者做一些路由跳转处理
        getX.Get.snackbar('提示', '请求取消');
        break;

      case DioErrorType.other:
        //other 其他错误类型
        // getX.Get.snackbar('提示', '请求异常');
        break;
    }

    // handler.next(err);

    super.onError(err, handler);
  }
}
