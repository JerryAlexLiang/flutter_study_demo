import 'package:flutter/material.dart';
import 'package:flutter_study_demo/custom_router.dart';
import 'package:flutter_study_demo/todoList/model/todo_model.dart';
import 'package:flutter_study_demo/todoList/todo_list_detail_page.dart';
import 'package:flutter_study_demo/todoList/utils/todo_database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key}) : super(key: key);

  @override
  _TodoListPageState createState() {
    return _TodoListPageState();
  }
}

class _TodoListPageState extends State<TodoListPage> {
  ToDoDatabaseHelper databaseHelper = ToDoDatabaseHelper();
  List<TodoModel> todoList;
  bool isOffstage = false;

  @override
  void initState() {
    super.initState();
    todoList = List<TodoModel>();
    updateListView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite数据库 TodoList'),
        primary: true,
        actions: [
          Offstage(
            offstage: isOffstage,
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
        child: initTodoListView(),
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
            isOffstage = true;
          } else {
            isOffstage = false;
          }
        });
      });
    });
  }

  initTodoListView() {
    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            todoList[index].title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          subtitle: Text(
            todoList[index].description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () => _delete(todoList[index]),
            // onPressed: () => Fluttertoast.showToast(msg: '${todoList[index].id} title: ${todoList[index].title}'),
          ),
          onTap: () => navigatorToAddPage(todoList[index]),
        );
      },
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
}
