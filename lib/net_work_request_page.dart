import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class NetworkRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请求网络数据'),
      ),
      body: Center(
        child: MaterialButton(
          height: 50,
          // minWidth: 100,
          elevation: 5,
          color: Colors.orangeAccent,
          child: Text('Click'),
          onPressed: requestHttpClient(),
        ),
      ),
    );
  }
}

requestHttpClient() {
  //创建一个HttpClient
  HttpClient _httpClient = HttpClient();
  getHttpClient() async {
    // _httpClient
    //     .get("https://www.baidu.com", 8090, '/path1')
    //     .then((HttpClientRequest request) {
    //   return request.close();
    // }).then((HttpClientResponse response) {
    //   if (response.statusCode == 200) {
    //     response.transform(utf8.decoder).join().then((String string) {
    //       print(string);
    //     });
    //   } else {
    //     print("error");
    //   }
    // });

    var url = "https://www.baidu.com";
    _httpClient.getUrl(Uri.parse(url)).then((HttpClientRequest request) {
      //使用iPhone的UA
      request.headers.add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");

      return request.close();
    }).then((HttpClientResponse response) {
      if (response.statusCode == 200) {
        response.transform(utf8.decoder).join().then((String string) {
          print("++++++++>>>>>>>>>>>  success 1" + string);
        });
      } else {
        print("++++++++>>>>>>>>>>>  error");
      }
    });
  }

  getHttpClient();
}
