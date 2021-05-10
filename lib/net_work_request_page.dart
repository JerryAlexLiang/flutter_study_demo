import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请求网络数据'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              height: 50,
              minWidth: 100,
              elevation: 5,
              color: Colors.orangeAccent,
              child: Text('HttpClientGet'),
              onPressed: () {
                _requestHttpClientGet();
              },
            ),
            SizedBox(height: 10), //保留间距10
            MaterialButton(
              height: 50,
              minWidth: 100,
              elevation: 5,
              color: Colors.red,
              child: Text('HttpClientPost'),
              onPressed: () {
                _requestHttpClientPost();
              },
            ),
            SizedBox(height: 10), //保留间距10
            MaterialButton(
              height: 50,
              minWidth: 100,
              elevation: 5,
              color: Colors.blue,
              child: Text('DartHttpGet'),
              onPressed: () {
                _requestDartHttpGet();
              },
            ),
            SizedBox(height: 10), //保留间距10
            MaterialButton(
              height: 50,
              minWidth: 100,
              elevation: 5,
              color: Colors.blue,
              child: Text('DartHttpPost'),
              onPressed: () {
                _requestDartHttpPost();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _requestHttpClientGet() async {
  try {
    //1、创建一个HttpClient
    HttpClient httpClient = new HttpClient();
    //2、打开Http连接，设置请求头
    HttpClientRequest request = await httpClient
        .getUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
    //通过HttpClientRequest可以设置请求header
    //request.headers.add("user-agent", "test");
    //3、等待连接服务器：
    HttpClientResponse response = await request.close();
    //4、这一步完成后，请求信息就已经发送给服务器了，返回一个HttpClientResponse对象，
    // 它包含响应头（header）和响应流(响应体的Stream)，接下来就可以通过读取响应流来获取响应内容
    if (response.statusCode == 200) {
      String _responseText = await response.transform(Utf8Decoder()).join();
      print(">>>>>>>>>>>  requestHttpClientGet success " +
          _responseText.toString());
    } else {
      print('>>>>>>>>>>> requestHttpClientGet error: ');
    }
    //5、请求结束，关闭HttpClient  关闭client后，通过该client发起的所有请求都会中止
    httpClient.close();
  } catch (_) {
    print('>>>>>>>>>>> requestHttpClientGet 请求异常: ' + _.toString());
  }
}

void _requestHttpClientPost() async {
  try {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse("https://www.wanandroid.com/user/login"));
    // 设置请求头 Content-Type大小写都ok
    request.headers.contentType =
        ContentType("application", "x-www-form-urlencoded");
    //添加请求体-设置body参数
    Map<String, String> map1 = new Map();
    map1["username"] = "1";
    map1["password"] = "1";

    // request.write("username='1'&password='1'");

    HttpClientResponse response = await request.close();
    String _responseText = await response.transform(Utf8Decoder()).join();
    if (response.statusCode == HttpStatus.ok) {
      print(">>>>>>>>>>>  requestHttpClientPost success " + _responseText);
    }
    httpClient.close();
  } catch (_) {
    print('>>>>>>>>>>> requestHttpClientPost 请求异常: ' + _.toString());
  }
}

void _requestDartHttpGet() async {
  var url = Uri.parse("https://wanandroid.com/wxarticle/chapters/json ");
  try {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = response.body.toString();
      print(">>>>>>>>>>>  requestDartHttpGet success " + jsonResponse);
    } else {
      print('>>>>>>>>>>> requestDartHttpGet 请求异常: ');
    }
  } catch (_) {
    print('>>>>>>>>>>> requestDartHttpGet 请求异常: ' + _.toString());
  }
}

void _requestDartHttpPost() async {
  var url = Uri.parse("https://www.wanandroid.com/user/login");
  //发送POST请求，application和x-www-from-urlencoded数据类型
  //设置Header
  // Map<String, String> headersMap = new Map();
  // headersMap["content-type"] = "application/x-www-from-urlencoded";
  //设置body参数
  Map<String, String> bodyParams = new Map();
  bodyParams["username"] = "1";
  bodyParams["password"] = "1";

  try {
    var response =
        await http.post(url, body: bodyParams, encoding: Utf8Codec());
    if (response.statusCode == 200) {
      var jsonResponse = response.body.toString();
      print(">>>>>>>>>>>  requestDartHttpPost success " + jsonResponse);
    } else {
      print('>>>>>>>>>>> requestDartHttpPost 请求异常: ');
    }
  } catch (_) {
    print('>>>>>>>>>>> requestDartHttpPost 请求异常: ' + _.toString());
  }
}
