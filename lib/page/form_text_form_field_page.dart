import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_study_demo/widget/LoadingDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FormTextFormFieldPage extends StatefulWidget {
  FormTextFormFieldPage({Key key}) : super(key: key);

  @override
  _FormTextFormFieldPageState createState() {
    return _FormTextFormFieldPageState();
  }
}

class _FormTextFormFieldPageState extends State<FormTextFormFieldPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Form TextFrmField'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        //Form 表单组件，可以接受其下的FormField组件的变化回调，通过onWillPop拦截返页面返回，通过FormState可以对表单字段进行保存或校验
        child: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                width: 350,
                //UnconstrainedBox:约束盒 可以容纳一个子组件，并解除该组件的所有区域约束，展现自我尺寸
                child: UnconstrainedBox(
                  child: Container(
                    width: 200,
                    height: 70,
                    child: TextFormField(
                      style: TextStyle(
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'userName',
                      ),
                      //validator 验证函数
                      validator: (v) => _validateUsername(v),
                      //onFieldSubmitted 提交回调(键盘完成按钮)
                      onFieldSubmitted: _onFieldSubmitted,
                      //onSaved 表单save时回调
                      onSaved: _onSaved,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: _buildSubmitButton(context),
              ),
            ],
          ),
          onChanged: () => Fluttertoast.showToast(msg: 'Form---onChanged'),
          onWillPop: _onWillPop,
        ),
      ),
    );
  }

  String _validateUsername(String value) {
    if (value.isEmpty) {
      Fluttertoast.showToast(msg: '用户名不能为空!');
      return '用户名不能为空!';
    }
    return null;
  }

  void _onFieldSubmitted(String value) {
    Fluttertoast.showToast(msg: 'onFieldSubmitted $value');
  }

  void _onSaved(String newValue) {
    if (newValue.isNotEmpty) {
      Fluttertoast.showToast(msg: 'onSaved: $newValue');
    } else {
      Fluttertoast.showToast(msg: '用户名不能为空!');
    }
  }

  _buildSubmitButton(BuildContext context) {
    return MaterialButton(
      onPressed: () => _submit(),
      color: Colors.blue,
      shape: CircleBorder(
        side: BorderSide(
          width: 2,
          color: Colors.red,
        ),
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  _submit() async {
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      // navigator.pop();
    }
  }

  Future<bool> _onWillPop() async {
    bool isFinishPage = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          title: Text(
            '提示',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          content: Text('确定离开当前页面吗？'),
          actions: <Widget>[
            MaterialButton(
              onPressed: () => navigator.pop(false),
              child: Text(
                '取消',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                '确定',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
    //onWillPop回调决定Form所在的路由是否可以直接返回，该回调需要返回Future<bool>，
    // 返回false表示当前路由不会返回；为true，则会返回到上一个路由。此属性通常用于拦截返回按钮。
    return isFinishPage ?? false;
  }
}
