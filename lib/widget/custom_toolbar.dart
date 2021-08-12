import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomToolBar extends StatefulWidget implements PreferredSizeWidget {
  //属性参数，单击回调
  final GestureTapCallback onTapLeft;
  final GestureTapCallback onTapRight;
  Color navigationBarBackgroundColor; //设置导航栏背景的颜色

  CustomToolBar({
    @required this.onTapLeft,
    @required this.onTapRight,
    this.navigationBarBackgroundColor = Colors.white,
  }) : assert(onTapLeft != null && onTapRight != null);

  @override
  _CustomToolBarState createState() {
    return _CustomToolBarState();
  }

  @override
  //AppBar需要实现PreferredSizeWidget
  Size get preferredSize => Size.fromHeight(56.0);
}

class _CustomToolBarState extends State<CustomToolBar> {
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
    /// 这里没有直接用SafeArea，而是用Container包装了一层
    /// 因为直接用SafeArea，会把顶部的statusBar区域留出空白
    /// 外层Container会填充SafeArea，指定外层Container背景色也会覆盖原来SafeArea的颜色
    ///     var statusheight = MediaQuery.of(context).padding.top;  获取状态栏高度

    return Container(
      color: this.widget.navigationBarBackgroundColor,
      child: SafeArea(
        top: true,
        child: Container(
          color: Colors.blue,
          child: Row(
            children: [
              GestureDetector(
                onTap: this.widget.onTapLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Text(
                    '搜索...',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              GestureDetector(
                onTap: this.widget.onTapRight,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    //设置布局
    // return SafeArea(
    //   top: true,
    //   child: Container(
    //     color: Colors.blue,
    //     child: Row(
    //       children: [
    //         GestureDetector(
    //           onTap: this.widget.onTapLeft,
    //           child: Icon(
    //             Icons.arrow_back,
    //             color: Colors.white,
    //             size: 39,
    //           ),
    //         ),
    //         Expanded(
    //           child: Container(
    //             color: Colors.white,
    //             padding: EdgeInsets.all(5),
    //             margin: EdgeInsets.all(5),
    //             child: Text(
    //               '搜索...',
    //               style: TextStyle(fontSize: 18),
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: this.widget.onTapRight,
    //           child: Icon(
    //             Icons.menu,
    //             color: Colors.white,
    //             size: 39,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
