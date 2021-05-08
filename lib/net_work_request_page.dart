import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}

// requestHttpClient() {
//   //创建一个HttpClient
//   HttpClient _httpClient = HttpClient();
//   getHttpClient() async {
//     var url = "https://www.baidu.com";
//     _httpClient.getUrl(Uri.parse(url)).then((HttpClientRequest request) {
//       //使用iPhone的UA
//       request.headers.add("user-agent",
//           "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
//
//       return request.close();
//     }).then((HttpClientResponse response) {
//       if (response.statusCode == 200) {
//         response.transform(utf8.decoder).join().then((String string) {
//           print("++++++++>>>>>>>>>>>  success 1" + string);
//         });
//       } else {
//         print("++++++++>>>>>>>>>>>  error");
//       }
//     });
//   }
//
//   getHttpClient();
//
//
// }

void _requestHttpClientGet() async {
  // try {
  //   //1、创建一个HttpClient
  //   HttpClient httpClient = new HttpClient();
  //   //2、打开Http连接，设置请求头
  //   HttpClientRequest request =
  //       // await httpClient.getUrl(Uri.parse("https://www.phei.com.cn"));
  //       await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
  //   //通过HttpClientRequest可以设置请求header
  //   //request.headers.add("user-agent", "test");
  //   //使用iPhone的UA
  //   request.headers.add("user-agent",
  //       "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
  //   //3、等待连接服务器：
  //   HttpClientResponse response = await request.close();
  //   //4、这一步完成后，请求信息就已经发送给服务器了，返回一个HttpClientResponse对象，
  //   // 它包含响应头（header）和响应流(响应体的Stream)，接下来就可以通过读取响应流来获取响应内容
  //   String _responseText = await response.transform(Utf8Decoder()).join();
  //   print("++++++++>>>>>>>>>>>  requestHttpClientGet success " + _responseText);
  //   //5、请求结束，关闭HttpClient  关闭client后，通过该client发起的所有请求都会中止
  //   httpClient.close();
  // } catch (_) {
  //   print('++++++++>>>>>>>>>>> requestHttpClientGet 请求异常: ' + _.toString());
  // }

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
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse("http://api.juheapi.com/japi/toh"));
    // 设置请求头
    /*  request.headers.set("loginSource", "IOS");
    request.headers.set("useVersion", "3.1.0");
    request.headers.set("isEncoded", "1");
    // Content-Type大小写都ok
    request.headers.set('content-type', 'application/json');
    */
    //添加请求体
    Map jsonMap = {
      'shopperId': 9356,
      'machineId': 5117,
      'orderType': 2,
      'orderId': 108
    };
    Map<String, String> map1 = new Map();
    map1["v"] = "1.0";
    map1["month"] = "7";
    map1["day"] = "25";
    map1["key"] = "bd6e35a2691ae5bb8425c8631e475c2a";

    request.add(utf8.encode(json.encode(map1)));

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
