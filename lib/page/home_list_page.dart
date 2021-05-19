import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_demo/model/wan_android_article_bean_entity.dart';

class HomeListPage extends StatefulWidget {
  @override
  _HomeListPageState createState() => _HomeListPageState();
}

class _HomeListPageState extends State<HomeListPage> {
  Dio _dio = new Dio();

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('列表'),
        ),
        body: Center(
          child: FutureBuilder(
            future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
            // future: _dio.get("https://www.wanandroid.com/article/list/0/json"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //请求完成
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                //发生错误
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                //请求成功，通过项目信息构建用于显示项目名称的ListView
                return ListView(
                  children: response.data
                      .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                      .toList(),
                );

                // return SingleChildScrollView(
                //   child: Text(response.data.toString()),
                // );
              }
              //请求未完成时弹出loading
              return CircularProgressIndicator();
            },
          ),
        ));

    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            //发生错误
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            //请求成功，通过项目信息构建用于显示项目名称的ListView
            return ListView(
              children: response.data
                  .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                  .toList(),
            );
          }
          //请求未完成时弹出loading
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
