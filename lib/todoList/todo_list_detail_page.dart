import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_demo/todoList/model/todo_model.dart';
import 'package:flutter_study_demo/todoList/utils/todo_database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoListDetailPage extends StatefulWidget {
  // TodoListDetailPage({Key key}) : super(key: key);

  final TodoModel _model;

  TodoListDetailPage(this._model);

  @override
  _TodoListDetailPageState createState() {
    return _TodoListDetailPageState();
  }
}

class _TodoListDetailPageState extends State<TodoListDetailPage> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _focusNode;
  bool isOffstage = false;

  ToDoDatabaseHelper helper = ToDoDatabaseHelper();

  TodoModel model = TodoModel();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _focusNode = FocusNode();

    if (this.widget._model != null && this.widget._model.id != null) {
      isOffstage = false;
    } else {
      isOffstage = true;
    }

    getCache();
  }

  //Flutter中TextField设置文本内容后让光标在文本末尾
  void setDescriptionSelection() {
    _descriptionController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _descriptionController.text.length,
        affinity: TextAffinity.downstream,
      ),
    );
  }

  //Flutter中TextField设置文本内容后让光标在文本末尾
  void setTitleSelection() {
    _titleController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _titleController.text.length,
        affinity: TextAffinity.downstream,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加待办事项'),
        primary: true,
        actions: [
          Offstage(
            //offstage属性为true表示隐藏该组件
            offstage: isOffstage,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _delete(),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          SizedBox(
            height: 10,
          ),
          _titleTextField(),
          SizedBox(
            height: 15,
          ),
          _descriptionTextField(),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            onPressed: () => _save(),
            child: Text('保存'),
            color: Colors.blue,
            focusColor: Colors.red,
            textColor: Colors.white,
            highlightColor: Colors.red,
            splashColor: Colors.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      Fluttertoast.showToast(msg: '请输入内容后再保存~');
    } else {
      String titleContent = _titleController.text;
      String descriptionContent = _descriptionController.text;

      model.title = titleContent;
      model.description = descriptionContent;
      // model.date = DateTime.now().toString();
      model.date =
          formatDate(DateTime.now(), [yyyy, "年", mm, "月", dd, "日", " ", DD]);
      model.id = this.widget._model.id;

      if (this.widget._model != null && this.widget._model.id != null) {
        await helper.updateTodoCompleted(model);
        Fluttertoast.showToast(
            msg: "update ${model.title}  ${model.description}");
      } else {
        await helper.insertTodo(model);
        Fluttertoast.showToast(
            msg: "insert ${model.title}  ${model.description}");
      }
      Navigator.pop(context, true);
    }
  }

  _delete() async {
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
                if (this.widget._model != null &&
                    this.widget._model.id != null) {
                  int result = await helper.deleteTodo(this.widget._model.id);
                  if (result != 0) {
                    Navigator.pop(context, true);
                    Fluttertoast.showToast(msg: '删除成功');
                  }
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

  void getCache() {
    if (this.widget._model != null) {
      setState(() {
        _titleController.text = this.widget._model?.title;
        _descriptionController.text = this.widget._model?.description;

        setTitleSelection();

        setDescriptionSelection();
      });
    }
  }

  Widget _titleTextField() {
    return TextField(
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
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        //无焦点时文字
        labelText: '请输入标题',
        labelStyle: TextStyle(color: Colors.blue),
        //提示文字相关
        hintText: '请输入标题',
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
        //输入框最左侧
        prefixText: 'title : ',
        prefixStyle: TextStyle(color: Colors.blue),
        prefixIcon: Icon(
          Icons.title,
          size: 20,
        ),
        //输入框最右侧
        suffixText: '最多输入10个字符',
        suffixStyle: TextStyle(
          color: Colors.orange,
          fontSize: 8,
        ),
        suffixIcon: Icon(
          Icons.notifications,
          size: 20,
        ),
        //左下角相关提示
        helperText: 'help',
        helperStyle: TextStyle(
          color: Colors.red,
        ),
        //右下角相关提示
        counterText: 'counter',
        //图标
        icon: Icon(
          Icons.title_sharp,
          color: Colors.blue,
        ),
      ),
      onChanged: (v) {
        // _titleController.text = v;
        //Flutter中TextField设置文本内容后让光标在文本末尾
        setTitleSelection();
      },
      controller: _titleController,
      minLines: 1,
      maxLines: 2,
      //自动聚焦
      autofocus: true,
    );
  }

  _descriptionTextField() {
    return TextField(
      keyboardType: TextInputType.multiline,
      //装饰线
      decoration: InputDecoration(
        filled: true,
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
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        //无焦点时文字
        labelText: '请输入描述',
        labelStyle: TextStyle(color: Colors.blue),
        //提示文字相关
        hintText: '请输入描述',
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
        //输入框最左侧
        prefixText: 'title : ',
        prefixStyle: TextStyle(color: Colors.blue),
        prefixIcon: Icon(
          Icons.description,
          size: 20,
        ),
        //输入框最右侧
        // suffixText: '',
        // suffixStyle: TextStyle(
        //   color: Colors.orange,
        //   fontSize: 8,
        // ),
        // suffixIcon: Icon(
        //   Icons.notifications,
        //   size: 20,
        // ),
        //左下角相关提示
        helperText: 'help',
        helperStyle: TextStyle(
          color: Colors.red,
        ),
        //右下角相关提示
        counterText: 'counter',
        //图标
        icon: Icon(
          Icons.description_sharp,
          color: Colors.blue,
        ),
      ),
      onChanged: (v) {
        // _descriptionController.text = v;
        //Flutter中TextField设置文本内容后让光标在文本末尾
        setDescriptionSelection();
      },
      controller: _descriptionController,
      minLines: 1,
      maxLines: 30,
    );
  }
}
