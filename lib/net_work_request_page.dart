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
          minWidth: 100,
          elevation: 5,
          color: Colors.orangeAccent,
          child: Text('Click'),
          onPressed: () {
            requestHttpClient();
          },
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

requestHttpClient() async {
  try {
    //1、创建一个HttpClient
    HttpClient httpClient = new HttpClient();
    //2、打开Http连接，设置请求头
    HttpClientRequest request =
        // await httpClient.getUrl(Uri.parse("https://www.phei.com.cn"));
        await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
    //通过HttpClientRequest可以设置请求header
    //request.headers.add("user-agent", "test");
    //使用iPhone的UA
    request.headers.add("user-agent",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
    //3、等待连接服务器：
    HttpClientResponse response = await request.close();
    //4、这一步完成后，请求信息就已经发送给服务器了，返回一个HttpClientResponse对象，
    // 它包含响应头（header）和响应流(响应体的Stream)，接下来就可以通过读取响应流来获取响应内容。
    String _responseText = await response.transform(Utf8Decoder()).join();
    print("++++++++>>>>>>>>>>>  success " + _responseText);
    //5、请求结束，关闭HttpClient  关闭client后，通过该client发起的所有请求都会中止
    httpClient.close();
  } catch (_) {
    print('++++++++>>>>>>>>>>> 请求异常: ' + _.toString());
  }
}
