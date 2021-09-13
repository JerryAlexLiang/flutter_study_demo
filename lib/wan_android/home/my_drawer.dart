import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_demo/custom_router.dart';
import 'package:flutter_study_demo/todoList/todo_list_page.dart';
import 'package:flutter_study_demo/utils/permission_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  XFile _image;
  String _imagePath;
  ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initFromCache();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //DrawerHeader，它是一个具有默认高度的结构化组件，可以用它在菜单头部展示用户的基本信息
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Flutter 致一科技',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: _imagePath == null
                          ? AssetImage(
                              "images/core_icon_bg_header.png",
                            )
                          : FileImage(
                              File(_imagePath),
                            ),
                    ),
                  ),
                  onTap: () => _pickImage(),
                ),
              ],
            ),
          ),
          ListTile(
            //导航图标
            leading: Icon(
              Icons.message,
              color: Colors.red,
            ),
            //标题
            title: Text(
              '消息',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            //副标题
            subtitle: Text(
              '100+',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
            //右侧顶部菜单
            trailing: Icon(
              Icons.flag,
              color: Colors.red,
            ),
            //点击事件
            onTap: () => Fluttertoast.showToast(msg: '消息'),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text(
              '我的',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => Fluttertoast.showToast(msg: '我的'),
          ),
          ListTile(
            leading: Icon(
              Icons.book,
              color: Colors.red,
            ),
            title: Text(
              'TODO List',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CustomRoute(
                  TodoListPage('SQLite数据库 TodoList'),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.red,
            ),
            title: Text(
              '设置',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () => Fluttertoast.showToast(msg: '设置'),
          ),
        ],
      ),
    );
  }

  _pickImage() {
    // permission_handler ^8.1.6 权限访问 代码处理逻辑
    // checkPermission();

    //权限申请工具封装
    checkPermissionByUtils();
  }

  _getGalleryImage() async {
    //从相册中获取图片
    // var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    XFile image = await _imagePicker.pickImage(source: ImageSource.gallery);
    uploadUI(image);
  }

  _getCameraImage() async {
    // //从相册获取图片
    //从相机中拍照获取图片
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    uploadUI(image);
  }

  void uploadUI(XFile image) {
    //本地化存储
    saveToCache(image);

    setState(() {
      _image = image;
      _imagePath = image.path;
      print('图片路径1： ${_image.toString()}');
      print('图片路径2： ${image.name}  ${image.path}');
    });
  }

  void showImageDialog() {
    //ios Dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CupertinoAlertDialog(
          title: Text('提示'),
          content: Text('设置头像'),
          actions: [
            CupertinoButton(
              child: Text('相册'),
              onPressed: () {
                _getGalleryImage();
                Navigator.pop(dialogContext);
              },
            ),
            CupertinoButton(
              child: Text("拍照"),
              onPressed: () {
                _getCameraImage();
                Navigator.pop(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }

  //权限检测
  void checkPermission() async {
    Permission permission = Permission.storage;
    var permissionStatus = await permission.status;
    print('检测权限 >>>>> $permissionStatus');
    if (permissionStatus.isGranted) {
      //权限通过
      showImageDialog();
    } else if (permissionStatus.isDenied) {
      //权限拒绝，需要区分IOS和Android，二者不一样
      requestPermission(permission);
    } else if (permissionStatus.isPermanentlyDenied) {
      //权限永久拒绝，且不再提示，需要进入设置界面，iOS和Android不同
      //注意isPermanentlyDenied，在没有申请之前，都会是Denied，而不是permanentlyDenied；
      openAppSettings();
    } else {
      //第一次申请权限
      requestPermission(permission);
    }
  }

  //权限申请
  void requestPermission(Permission permission) async {
    //发起权限申请
    var permissionStatus = await permission.request();
    //返回权限申请的状态status
    if (permissionStatus.isPermanentlyDenied) {
      //如果永久拒绝，手动开启权限
      openAppSettings();
    } else if (permissionStatus.isGranted) {
      //权限通过
      showImageDialog();
    }
  }

  void initFromCache() async {
    var sharedPreferences = await _prefs;
    var cacheImagePath = sharedPreferences.getString("key_image_path");
    setState(() {
      _imagePath = cacheImagePath;
    });
  }

  void saveToCache(XFile image) async {
    var sharedPreferences = await _prefs;
    sharedPreferences.setString('key_image_path', image.path);
  }

  // onSuccess : 同意
  // onFailed :   其中一个不同意
  // onOpenSetting  :   需要去设置
  void checkPermissionByUtils() {
    var permissionList = [Permission.storage];
    PermissionHelper.check(
      permissionList,
      onSuccess: () {
        showImageDialog();
      },
      onFailed: () {
        Fluttertoast.showToast(msg: '请开启权限后设置头像');
      },
      onOpenSetting: () {
        openAppSettings();
      },
    );
  }
}
