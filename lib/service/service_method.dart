import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/service_url.dart';
import 'dart:io';

//获得wan_android首页Banner数据
//为什么要返回Feature : 只有返回Feature才能使用then()回调
Future getWanHomeTopBanner() async {
  try {
    print('wan_android首页Banner数据 Start');
    Response response;
    Dio dio = new Dio();
    response = await dio.get(servicePath['homePageBanner']);
    if (response.statusCode == 200) {
      print('wan_android首页Banner数据 Success');
      return response.data;
    } else {
      return print('wan_android首页Banner数据 Fail');
    }
  } catch (e) {
    return print('wan_android首页Banner数据 Error : $e');
  }
}

//获得开眼 发现-分类数据
Future getEyeCategory() async {
  try {
    print('开眼 发现-分类数据 Start');
    Response response;
    Dio dio = new Dio();
    response = await dio.get(EyeApi.categoryUrl);
    if (response.statusCode == 200) {
      print('开眼 发现-分类数据 Success');
      return response.data;
    } else {
      return print('开眼 发现-分类数据 Fail');
    }
  } catch (e) {
    return print('开眼 发现-分类数据 Error : $e');
  }
}