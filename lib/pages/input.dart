import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  // 定义一个controller
  TextEditingController _unameController = TextEditingController();

  @override
  void initState() {
    print(_unameController.text);
    // 监听输入改变事件
    _unameController.text = '123';
    _unameController.addListener(() {
      print(_unameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表单输入页面'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            onChanged: (v) {
              print('onChanged: $v');
            },
            decoration: InputDecoration(
                labelText: '用户名',
                hintText: '用户名或邮箱',
                prefixIcon: Icon(Icons.person),
                // 未获得焦点时下划线显示灰色
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                // 获得焦点下划线时显示蓝色
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue))),
          ),
          TextField(
            controller: _unameController,
            decoration: InputDecoration(
                labelText: '密码',
                hintText: '您的登陆密码',
//              prefix: Icon(Icons.lock),
                prefixIcon: Icon(Icons.lock)),
          ),
          CustomForm()
        ],
      ),
    );
  }
}

// 自定义表单颜色
class CustomForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hintColor: Colors.grey[200], //定义下划线颜色
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.grey), //定义label字体样式
            hintStyle: TextStyle(color: Colors.blue, fontSize: 14.0) //定义提示文本样式
            ),
      ),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                labelText: '用户名',
                hintText: '用户名或邮箱',
                prefixIcon: Icon(Icons.person)),
          ),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: '密码',
                hintText: '您的登陆密码',
                hintStyle: TextStyle(color: Colors.green, fontSize: 13)),
            obscureText: true,
          )
        ],
      ),
    );
  }
}
