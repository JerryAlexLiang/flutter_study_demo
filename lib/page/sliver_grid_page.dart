import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SliverGridPage extends StatelessWidget {
  SliverGridPage({Key key}) : super(key: key);

  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  final imageUrl =
      // "https://img1.baidu.com/it/u=2620121525,3057821586&fm=26&fmt=auto&gp=0.jpg";
      "http://gank.io/images/d6bba8cf5b8c40f9ad229844475e9149";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliversAppBar(),
          _buildSliverGridHorizon(),
          _buildSliverGrid(),
        ],
      ),
    );
  }

  Widget _buildSliversAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 300.0,
      flexibleSpace: InkWell(
        child: FlexibleSpaceBar(
          background: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          title: Text(
            'SliverAppBar + SliverGrid + SliverToBoxAdapter' ,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          collapseMode: CollapseMode.parallax,
        ),
        onTap: () {
          return Fluttertoast.showToast(msg: '妹子');
        },
      ),
    );
  }

  Widget _buildSliverGrid() {
    return SliverGrid(
      //和SliverList类似，要展示各个列表项，同样有两种方式
      //方法1：直接指定
      //方法2：通过构建函数返回，和SliverList不同的是，
      // SliverGrid还需要指定一个gridDelegate参数，这个参数主要用来设置网格布局中的其他属性,
      //和GridView一样属性
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            alignment: Alignment.center,
            color: data[index],
            child: Text('grid item $index'),
          );
        },
        childCount: data.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //每行的项数，即 副轴方向child的列数或行数，垂直滚动就是列数，水平滚动就是行数
        crossAxisCount: 3,
        //各项之间的空隙
        //主轴间距
        mainAxisSpacing: 1,
        //纵轴间距
        crossAxisSpacing: 1,
        //box主长/交叉轴长（宽高比设定）
        childAspectRatio: 1,
      ),
    );
  }

  Widget _buildSliverGridHorizon() {
    //横向滑动GridView
    // SliverToBoxAdapter Sliver适配器，可以容纳一个普通的组件，并将其转化成Sliver家族组件的适配器
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        padding: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
        ),
        child: GridView.builder(
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1,
          ),
          // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //   //单个子Widget最大的宽度
          //   maxCrossAxisExtent: 150,
          //   mainAxisSpacing: 1,
          //   crossAxisSpacing: 1,
          //   childAspectRatio: 1,
          // ),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                height: 50,
                child: Card(
                  color: data[index],
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'grid item $index',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () => Fluttertoast.showToast(msg: 'grid item $index'),
            );
          },
        ),
      ),
    );
  }
}
