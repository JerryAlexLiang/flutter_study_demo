import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudyFirstDemoPage extends StatelessWidget {
  StudyFirstDemoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('我的第一个Demo'),
    //   ),
    //   body: WordPairList(),
    // );

    return WordPairList();
  }
}

class WordPairList extends StatelessWidget {
  WordPairList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // //english_words 其中包含数千个最常用的英文单词以及一些实用功能。
    // final wordPair = WordPair.random();

    // return Scaffold(
    //   body: Center(
    //     // child: Text(wordPair.asPascalCase), //大驼峰式命名法
    //     child: RandomWords(),
    //   ),
    // );

    return RandomWords();
  }
}

class RandomWords extends StatefulWidget {
  RandomWords({Key key}) : super(key: key);

  @override
  _RandomWordsState createState() {
    return _RandomWordsState();
  }
}

class _RandomWordsState extends State<RandomWords> {
  //添加一个 _suggestions 列表以保存建议的单词对
  final List<WordPair> _suggestions = <WordPair>[];

  //同时，添加一个 biggerFont 变量来增大字体大小 Also, add a _biggerFont variable for making the font size larger.
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  //添加一个 _saved Set（集合）到 RandomWordsState，这个集合存储用户喜欢（收藏）的单词对
  // 在这里，Set 比 List 更合适，因为 Set 中不允许重复的值
  final Set<WordPair> _saved = Set<WordPair>();

  void _pushSaved() {
    // Navigator.push(context, new MaterialPageRoute(builder: (context) {
    //   return FavoriteWordPairListPage();
    // }));

    Navigator.push(context, new CupertinoPageRoute(builder: (context) {
      //添加生成 ListTile 行的代码
      final Iterable<ListTile> tiles = _saved.map((e) => new ListTile(
            title: Text(
              e.asPascalCase,
              style: _biggerFont,
            ),
          ));

      //通过 toList()方法非常方便的转换成列表显示
      final List<Widget> divided = tiles.toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('收藏夹'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

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
    //english_words 其中包含数千个最常用的英文单词以及一些实用功能。
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase); //大驼峰式命名法

    return Scaffold(
      appBar: AppBar(
        title: Text('我的第一个Demo'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      //ListView的builder工厂构造函数允许按需建立一个懒加载的列表视图
      padding: EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          //奇数 在每一列之前，添加一个1像素高的分隔线widget
          return Divider();
        }
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整）
        // 比如 i 为：1, 2, 3, 4, 5 时，结果为 0, 1, 1, 2, 2，
        // 这可以计算出 ListView 中减去分隔线后的实际单词对数量
        final int index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成5个单词对，然后添加到建议列表
          Fluttertoast.showToast(msg: '加载下一页~');
          _suggestions.addAll(generateWordPairs().take(5));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair suggestion) {
    //在 _buildRow 方法中添加 alreadySaved 来检查确保单词对还没有添加到收藏夹中。
    final bool alreadySaved = _saved.contains(suggestion);
    return ListTile(
      title: Text(
        suggestion.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : Colors.grey,
      ),
      onTap: () {
        setState(() {
          //当图标被点击时，函数调用 setState() 通知框架状态已经改变。
          if (alreadySaved) {
            //如果单词条目已经添加到收藏夹中,再次点击它将其从收藏夹中删除。
            _saved.remove(suggestion);
          } else {
            //如果单词条目没有添加到收藏夹中,再次点击它加入收藏夹中。
            _saved.add(suggestion);
          }
        });
      },
    );
  }
}

class FavoriteWordPairListPage extends StatelessWidget {
  FavoriteWordPairListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏夹'),
      ),
      body: ListView(
        children: [
          Center(
            child: Text('jjj'),
          ),
        ],
      ),
    );
  }
}
