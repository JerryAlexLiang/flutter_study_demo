import 'dart:async';
import 'package:flutter_study_demo/todoList/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ToDoDatabaseHelper {
  //Singleton单例
  static ToDoDatabaseHelper _databaseHelper;

  //Singleton单例
  static Database _database;

  String todoTable = 'todo_table';
  String _id = 'id';
  String _title = 'title';
  String _description = 'description';
  String _date = 'date';

  //命名构造函数
  //在Dart中实现单例非常简单，私有化构造可以使用【类名._()】格式实现，
  // 这样外界就无法创建此类对象，并通过db静态变量创建当前对象暴露给外界，这样就能保证实现该对象的单例。
  ToDoDatabaseHelper._createInstance();

  factory ToDoDatabaseHelper() {
    //This is executed only once, singleton object 单例对象只执行一次
    if (_databaseHelper == null) {
      _databaseHelper = ToDoDatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get dataBase async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //设置数据库路径，使用path包下的join()方法拼接路径字符串
    String path = join(await getDatabasesPath(), 'my_todo.db');
    //创建并打开数据库并且拿到该数据库的引用
    Future<Database> todoDataBase =
        openDatabase(path, version: 1, onCreate: _createDb);
    return todoDataBase;
  }

  Future<void> _createDb(Database db, int version) async {
    //在数据库中执行sql语句
    await db.execute(
        'CREATE TABLE $todoTable($_id INTEGER PRIMARY KEY AUTOINCREMENT,$_title TEXT,$_description TEXT,$_date TEXT)');
  }

  //查全部
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.dataBase;
    var result = await db.query(todoTable, orderBy: '$_id ASC');
    return result;
  }

  //根据title查询
  Future<List<Map<String, dynamic>>> getQueryToDoMapList(
      String searchContent) async {
    Database db = await this.dataBase;
    //关键字搜索
    // var result = await db.query(todoTable,
    //     where: '$_title = ?', whereArgs: [title]);

    //模糊搜索（根据关键字查询匹配标题or内容）
    //通过加上百分号，进行模糊查询
    var result = await db.query(todoTable,
        where: '$_title LIKE ? or $_description LIKE ?',
        whereArgs: ['%$searchContent%', '%$searchContent%']);
    return result;
  }

  //条件查询返回List<T>
  Future<List<TodoModel>> getQueryTodoListByTitle(String searchContent) async {
    var todoMapList = await getQueryToDoMapList(searchContent);
    int count = todoMapList.length;

    List<TodoModel> todoList = List<TodoModel>();

    for (int i = 0; i < count; i++) {
      todoList.add(TodoModel.fromJson(todoMapList[i]));
    }

    return todoList;
  }

  //查询全部返回List<T>
  Future<List<TodoModel>> getTodoList() async {
    // Get 'Map List' from database
    var todoMapList = await getTodoMapList();
    // Count the number of map entries in db table
    int count = todoMapList.length;

    List<TodoModel> todoList = List<TodoModel>();

    for (int i = 0; i < count; i++) {
      todoList.add(TodoModel.fromJson(todoMapList[i]));
    }

    return todoList;
  }

  //增
  Future<int> insertTodo(TodoModel model) async {
    Database db = await this.dataBase;
    var result = await db.insert(todoTable, model.toJson());
    return result;
  }

  //改
  //在查询和更新删除等语句中，会使用到where和whereArgs作为条件及条件参数
  //where中 and代表并且(都满足) or代表或者(满足其一)
  //where中的?为占位符 会依照顺序被后面whereArgs中的数据替换
  Future<int> updateTodoCompleted(TodoModel model) async {
    var db = await this.dataBase;
    var result = await db.update(todoTable, model.toJson(),
        where: '$_id = ?', whereArgs: [model.id]);
    return result;
  }

  //删
  Future<int> deleteTodo(int id) async {
    var db = await this.dataBase;
    int result = await db.delete(todoTable, where: '$_id = ?', whereArgs: [id]);
    return result;
  }

  //清空数据
  Future<int> clearAll() async {
    var db = await this.dataBase;
    int result = await db.delete(todoTable);
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.dataBase;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
