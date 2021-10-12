import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_study_demo/http/dio_cache_interceptors.dart';
import 'package:flutter_study_demo/http/dio_interceptors.dart';
import 'package:flutter_study_demo/http/dio_method.dart';
import 'package:flutter_study_demo/http/dio_response.dart';
import 'package:flutter_study_demo/http/dio_token_interceptors.dart';
import 'package:flutter_study_demo/http/dio_transformer.dart';

/// 封装网络请求

class DioUtil {
  //////////// 1、设置常量变量 ////////////////

  /// 连接超时时间
  static const int CONNECT_TIMEOUT = 6 * 1000;

  /// 响应超时时间
  static const int RECEIVE_TIMEOUT = 6 * 1000;

  /// 请求的URL前缀
  static  String baseUrl = "http://localhost:8080";

  /// 是否开启网络缓存,默认false
  static bool cacheEnable = false;

  /// 最大缓存时间(按秒), 默认缓存七天,可自行调节
  static const int MAX_CACHE_AGE = 7 * 24 * 60 * 60;

  /// 最大缓存条数(默认一百条)
  static const int MAX_CACHE_COUNT = 100;

  //////////// 1、设置常量变量 ////////////////

  //////////// 2、初始化Dio //////////////////

  /// 声明Dio变量
  Dio _dio;

  Dio get dio => _dio;

  /// 取消请求
  CancelToken _cancelToken = CancelToken();

  /// cookie
  CookieJar cookieJar = CookieJar();

  static DioUtil get instance => _getInstance();

  factory DioUtil() => _getInstance();
  static DioUtil _instance;

  //使用单例模式进行Dio封装
  //在每个页面中都会用到网络请求，那么如果我们每次请求的时候都去实例化一个Dio，无非是增加了系统不必要的开销，
  // 而使用单例模式对象一旦创建每次访问都是同一个对象，不需要再次实例化该类的对象.

  /// 通过静态变量的私有构造器来创建的单例模式
  static DioUtil _getInstance() {
    if (_instance == null) {
      _instance = DioUtil._init();
    }
    return _instance;
  }

  //对Dio请求进行初始化
  //对 超时时间 、响应时间 、BaseUrl 进行统一设置
  DioUtil._init() {
    if (_dio == null) {
      //初始化基本选型
      BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      //初始化Dio
      _dio = Dio(options);

      //////////// 4、拦截器 //////////////////
      /// 通过1，2，3 已经把Restful API 风格简化成了一个方法，通过DioMethod 来标明不同的请求方式。
      /// 在我们平时开发的过程中，需要在请求前、响应前、错误时对某一些接口做特殊的处理，那我们就需要用到拦截器。
      /// Dio 为我们提供了自定义拦截器功能，很容易轻松的实现对请求、响应、错误时进行拦截。

      /// 添加拦截器
      _dio.interceptors.add(DioInterceptors());

      /// 刷新token拦截器(lock/unlock)
      //在开发过程中，客户端和服务器打交道的时候，往往会用一个token来做校验，因为每个公司处理刷新token的逻辑都不一样，
      // eg:需要给所有的请求头中添加一个refreshToken，如果refreshToken不存在，我们先去请求refreshToken，
      // 获取到refreshToken后，再发起后续请求。
      // 由于请求refreshToken的过程是异步的，我们需要在请求过程中锁定后续请求（因为它们需要refreshToken), 直到refreshToken请求成功后，再解锁
      // _dio.interceptors.add(DioTokenInterceptors());

      /// 添加转换器
      //转换器Transformer用于对请求数据和响应数据进行编解码处理。
      // Dio实现了一个默认转换器DefaultTransformer作为默认的 Transformer.
      // 如果想对请求/响应数据进行自定义编解码处理，可以提供自定义转换器.
      // _dio.transformer = DioTransformer();

      /// 添加cookie管理器 cookie的使用需要用到两个第三方组件 dio_cookie_manager 和 cookie_jar
      //由服务器生成的一小段文本信息，发送给浏览器，浏览器把cookie以k-v形式保存到本地某个目录下的文本文件内，下一次请求同一网站时会把该cookie发送给服务器。
      //1、cookie_jar：Dart 中 http 请求的 cookie 管理器，通过它您可以轻松处理复杂的 cookie 策略和持久化 cookie
      //2、dio_cookie_manager： CookieManager 拦截器可以帮助我们自动管理请求/响应 cookie。 CookieManager 依赖于 cookieJar 包
      _dio.interceptors.add(CookieManager(cookieJar));

      /// 添加缓存拦截器
      _dio.interceptors.add(DioCacheInterceptors());

      //////////// 4、拦截器 //////////////////

    }
  }

  //////////// 2、初始化Dio //////////////////

  //////////// 3、封装请求类 //////////////////

  /// 对Restful APi风格进行统一封装
  /// 不管是get()还是post()请求，Dio内部最终都会调用request方法，只是传入的method不一样，所以我们这里定义一个枚举类型在一个方法中进行处理;

  ///请求类
  Future<T> request<T>(
    String path, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic> params,
    data,
    CancelToken cancelToken,
    Options options,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head',
    };

    options ??= Options(method: _methodValues[method]);

    try {
      Response response;
      response = await _dio.request(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError catch (e) {
      throw e;
    }
  }

  /// 取消网络请求
  /// 为什么我们需要有取消请求的功能，如果当我们的页面在发送请求时，
  /// 用户主动退出当前界面或者app应用程序退出的时候数据还没有响应，那我们就需要取消该网络请求，防止不必要的错误。
  void cancelRequests({CancelToken token}) {
    token ?? _cancelToken?.cancel("cancelled");
  }

  //////////// 3、封装请求类 //////////////////

  /////////// 5、统一日志打印 ////////////////
  void openLog(){
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }


  /////////// 5、统一日志打印 ////////////////

  /// 设置Http代理(设置即开启)
  void setProxy({String proxyAddress, bool enable = false}) {
    if (enable) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          return proxyAddress;
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// 设置https证书校验
  void setHttpsCertificateVerification({String pem, bool enable = false}) {
    if (enable) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          if (cert.pem == pem) {
            // 验证证书
            return true;
          }
          return false;
        };
      };
    }
  }
}
