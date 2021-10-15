import 'package:flutter/material.dart';
import 'package:flutter_study_demo/model/wan_home_article_bean.dart';
import 'package:flutter_study_demo/wan_android/project/wan_article_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 用webview_flutter可以轻松实现，在页面加载开始和结束时都会有相应的回调。
/// 通过WebViewController可以实现Web内的前进、后退等操作，
/// 这里会用到WillPopScope来拦截底部返回键，不会让当前页退栈，以此来控制浏览界面的返回.

class WanWebViewPage extends StatefulWidget {
  WanWebViewPage({Key key}) : super(key: key);

  final WanArticleModel item = Get.arguments;

  @override
  _WanWebViewPageState createState() {
    return _WanWebViewPageState();
  }
}

class _WanWebViewPageState extends State<WanWebViewPage> {
  WebViewController webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.item.title;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title != null ? title : "WebView"),
          leading: IconButton(
            onPressed: () async => await webViewController?.canGoBack()
                ? webViewController?.goBack()
                : Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: _webViewContainer(),
      ),
      onWillPop: _onWillPop,
    );
  }

  _webViewContainer() {
    var link = this.widget.item.link;
    return Stack(
      children: [
        WebView(
          //默认禁止js
          javascriptMode: JavascriptMode.unrestricted,
          //初始Url
          initialUrl:
              link.isNotEmpty ? link : "https://gitee.com/JerryAlexLiang",
          //WebView创建时回调
          onWebViewCreated: _onWebViewCreated,
          //页面加载结束时回调
          onPageFinished: _onPageFinished,
        ),
      ],
    );
  }

  Future<bool> _onWillPop() async {
    //点击返回键时回调
    if (await webViewController?.canGoBack()) {
      //如果WebView可以返回
      webViewController?.goBack();
      //WebView返回，界面不返回
      return false;
    } else {
      //否则界面返回
      return true;
    }
  }

  //WebView创建时回调
  Future<void> _onWebViewCreated(WebViewController controller) async {
    //WebView控制器，通过WebViewController可以实现Web内的前进、后退等操作
    webViewController = controller;
    //加载一个url
    controller.loadUrl(widget.item.link);
    controller.canGoBack().then((value) => print('是否能后退: $value'));
    controller.currentUrl().then((value) => print('当前Url: $value'));
    controller.canGoForward().then((value) => print('是否能前进: $value'));
  }

  //页面加载结束时回调
  void _onPageFinished(String url) => Fluttertoast.showToast(msg: '页面加载结束');
}
