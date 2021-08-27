import 'package:flutter/material.dart';
import 'package:flutter_study_demo/custom_router.dart';
import 'package:flutter_study_demo/todoList/model/todo_model.dart';
import 'package:flutter_study_demo/todoList/todo_list_detail_page.dart';
import 'package:flutter_study_demo/todoList/utils/todo_database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class TodoListPage extends StatefulWidget {
  // TodoListPage({Key key}) : super(key: key);

  final String pageTitle;

  TodoListPage(this.pageTitle);

  @override
  _TodoListPageState createState() {
    return _TodoListPageState();
  }
}

class _TodoListPageState extends State<TodoListPage> {
  ToDoDatabaseHelper databaseHelper = ToDoDatabaseHelper();
  List<TodoModel> todoList;

  //默认不显示删除按钮
  bool isOffstageDelete = false;

  //默认不显示清除文字按钮
  bool isOffstageClear = false;

  //默认不显示搜索栏
  bool isOffstageSearchBar = false;

  final FocusNode _focusNode = FocusNode();
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    todoList = List<TodoModel>();
    updateListView();

    if (_controller.text.isNotEmpty) {
      isOffstageClear = false;
    } else {
      isOffstageClear = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.pageTitle),
        primary: true,
        actions: [
          Offstage(
            offstage: isOffstageDelete,
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onTap: () => _deleteAll(),
            ),
          ),
        ],
      ),
      // body: initTodoListView(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/core_icon_bg_weather.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: 5,
            bottom: 25,
          ),
          child: ListView(
            children: [
              initSearchBar(),
              initTodoListView(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () => navigatorToAddPage(TodoModel()),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TodoModel>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((value) {
        setState(() {
          this.todoList = value;

          if (todoList.isEmpty) {
            isOffstageDelete = true;
            isOffstageSearchBar = true;
          } else {
            isOffstageDelete = false;
            isOffstageSearchBar = false;
          }
        });
      });
    });
  }

  void searchListView(String title) async {
    List<TodoModel> model = await databaseHelper.getQueryTodoListByTitle(title);
    setState(() {
      this.todoList = model;
      if (todoList.isEmpty) {
        isOffstageDelete = true;
      } else {
        isOffstageDelete = false;
      }
    });
  }

  initSearchWidget() {
    return TextField(
      style: TextStyle(color: Colors.white),
      //装饰线
      decoration: InputDecoration(
        //边线相关
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepOrangeAccent,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        //无焦点时文字
        labelText: '请输入关键字',
        labelStyle: TextStyle(color: Colors.red),
        //提示文字相关
        hintText: '请输入关键字',
        hintStyle: TextStyle(
          color: Colors.white60,
        ),
        //输入框最左侧
        prefixText: 'Search : ',
        prefixStyle: TextStyle(color: Colors.red),
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: Colors.white,
        ),
      ),
      onChanged: (v) {
        //Flutter中TextField设置文本内容后让光标在文本末尾
        setTitleSelection();
        setState(() {
          if (v.isNotEmpty) {
            isOffstageClear = false;
          } else {
            isOffstageClear = true;
          }
        });
      },
      focusNode: _focusNode,
      controller: _controller,
      minLines: 1,
      onSubmitted: (v) {
        Fluttertoast.showToast(msg: '搜索关键字: $v');
        searchListView(v);
      },
    );
  }

  initTodoListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        // return Card(
        //   // //影深
        //   // elevation: 1,
        //   color: Colors.transparent,
        //   child: ListTile(
        //     title: Text(
        //       todoList[index].title,
        //       style: TextStyle(
        //         color: Colors.yellow,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 22,
        //       ),
        //     ),
        //     subtitle: Text(
        //       todoList[index].description,
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 16,
        //       ),
        //       maxLines: 2,
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //     trailing: IconButton(
        //       icon: Icon(
        //         Icons.delete,
        //         color: Colors.white,
        //       ),
        //       onPressed: () => _delete(todoList[index]),
        //       // onPressed: () => Fluttertoast.showToast(msg: '${todoList[index].id} title: ${todoList[index].title}'),
        //     ),
        //     onTap: () => navigatorToAddPage(todoList[index]),
        //     onLongPress: () => _delete(todoList[index]),
        //   ),
        // );

        return _toDoListItem(context, todoList[index]);
      },
    );
  }

  _toDoListItem(BuildContext context, TodoModel model) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            // image: DecorationImage(
            //   image: AssetImage('images/core_icon_bg_header.png'),
            //   fit: BoxFit.cover,
            // ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            model.title,
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            model.date,
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        model.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                alignment: Alignment.centerRight,
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () => _delete(model),
                // onPressed: () => Fluttertoast.showToast(msg: '${todoList[index].id} title: ${todoList[index].title}'),
              ),
            ],
          ),
        ),
        onTap: () => navigatorToAddPage(model),
        // onLongPress: () => _delete(model),
      ),
    );
  }

  _deleteAll() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            '提示',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          content: Text(
            '是否删除全部记录?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                '取消',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                int result = await databaseHelper.clearAll();
                if (result != 0) {
                  Fluttertoast.showToast(msg: '已删除全部数据!');
                  updateListView();
                }
              },
              child: Text(
                '确定',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _delete(TodoModel model) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            '提示',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          content: Text(
            '是否删除本次记录?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                '取消',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                int result = await databaseHelper.deleteTodo(model.id);
                if (result != 0) {
                  updateListView();
                }
              },
              child: Text(
                '确定',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //way01 async - await
  navigatorToAddPage(TodoModel model) async {
    // bool result = await Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => TodoListDetailPage()));
    // if (result == true) {
    //   updateListView();
    // }

    final result =
        await Navigator.push(context, CustomRoute(TodoListDetailPage(model)));
    if (result == true) {
      updateListView();
    }
  }

// //way2: Future .then()
// navigatorToAddPage() {
//   Future result = Navigator.push(context, CustomRoute(TodoListDetailPage()));
//   result.then((value) => setState(() {
//         if (value == true) {
//           updateListView();
//         }
//       }));
// }

//Flutter中TextField设置文本内容后让光标在文本末尾
  void setTitleSelection() {
    _controller.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _controller.text.length,
        affinity: TextAffinity.downstream,
      ),
    );
  }

  _clearTextField() {
    // _focusNode.unfocus();
    // _focusNode.canRequestFocus = false;
    // Future.delayed(Duration(milliseconds: 500), () {
    //   _focusNode.canRequestFocus = true;
    // });

    setState(() {
      Fluttertoast.showToast(msg: 'clear text');
      _controller.clear();
      isOffstageClear = true;
    });

    updateListView();
  }

  initSearchBar() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Offstage(
              offstage: isOffstageSearchBar,
              child: initSearchWidget(),
            ),
          ),
          Offstage(
            offstage: isOffstageClear,
            child: Container(
              margin: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: InkWell(
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onTap: () => _clearTextField(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
