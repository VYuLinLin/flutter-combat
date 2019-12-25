import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/singleScrollView.dart';

class DialogRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('对话框页面'),),
      body: Column(children: <Widget>[
        RaisedButton(
          child: Text('AlertDialog'),
          onPressed: () async {
            // 弹出对话框并等待其关闭
            bool delete = await showDeleteConfirmDialog(context);
            if (delete == null) {
              print('取消删除');
            } else {
              print('已确认删除$delete');
            }
          },
        ),
        RaisedButton(
          child: Text('simpleDialog'),
          onPressed: () async {
            int language = await changeLanguage(context);
            if (language != null) {
              print('选择了：${language == 1 ? '中文简体' : 'English'}');
            }
          },
        ),
        RaisedButton(child: Text('Dialog'), onPressed: () => showListDialog(context),),
        RaisedButton(child: Text('显示包含复选框的对话框'), onPressed: () => showCheckboxDialog(context),),
        RaisedButton(child: Text('Loading'), onPressed: () => showLoadingDialog(context),),
        RaisedButton(child: Text('默认日历'), onPressed: () => _showDatePicker1(context),),
        RaisedButton(child: Text('IOS版日历'), onPressed: () => _showDatePicker2(context),),
      ],),
    );
  }
}
// alertDialog
Future<bool> showDeleteConfirmDialog(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('提示'),
        content: Text('您确定要删除当前文件吗？'),
        actions: <Widget>[
          FlatButton(child: Text('取消'), onPressed: () {
            return Navigator.of(context).pop();
          },),
          FlatButton(child: Text('删除'), onPressed: () {
            return Navigator.of(context).pop(true);
          },)
        ],
      );
    }
  );
}

// simpleDialog
Future<int> changeLanguage(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text('请选择语言'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('中文简体'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 2),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Text('English'),
            ),
          ),
        ],
      );
    }
  );
}
// Dialog
Future<void> showListDialog(BuildContext context) async {
  int index = await showDialog(
    context:  context,
    builder: (BuildContext context) {
      var child = Column(children: <Widget>[
        ListTile(title: Text('请选择'),),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('$index'),
                onTap: () =>  Navigator.of(context).pop(index),
              );
            },
          ),
        )
      ],);
      // 使用AlertDialog会报错
      // return AlertDialog(content: child);
      
      // 以下两种方式都可以
      return Dialog(child: child);
      // return UnconstrainedBox(
      //   constrainedAxis: Axis.vertical,
      //   child: ConstrainedBox(
      //     constraints: BoxConstraints(maxWidth: 280),
      //     child: Material(child: child, type: MaterialType.card),
      //   ),
      // );
    }
  );
  if (index != null) print('点击了：$index');
}

// 删除确认对话框
Future<bool> showCheckboxDialog(BuildContext context) {
  bool _withTree = false;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('提示'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('您确定要删除当前文件吗？'),
            Row(
              children: <Widget>[
                Text('同时删除子目录？'),
                Builder(
                  builder: (BuildContext context) {
                    return Checkbox(
                      value: _withTree,
                      onChanged: (bool value) {
                        // 通过Builder来获得构建Checkbox的context,
                        // 这是一种常用的缩小context范围的方式
                        (context as Element).markNeedsBuild();
                        _withTree = !_withTree;
                      },
                    );
                  },
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text('确定'),
            onPressed: () => Navigator.pop(context, _withTree),
          )
        ],
      );
    }
  );
}

// Loading框是通过showDialog + AlertDialog来自定义
Future<void> showLoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false, // 点击遮罩不关闭对话框
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(top: 26),
              child: Text('正在加载，请稍后...'),
            ),
            OutlineButton(child: Text('关闭'), onPressed: () => Navigator.pop(context),)
          ],
        ),
      );
    }
  );
}

// 日历DataPicker
// 默认日历
Future<DateTime> _showDatePicker1(context) {
  var date = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: date,
    firstDate: date,
    lastDate: date.add(Duration(days: 30)) // 未来30天可选
  );
}

// IOS日历
Future<DateTime> _showDatePicker2(context) {
  var date = DateTime.now();
  return showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: date,
          maximumDate: date.add(Duration(days: 30)),
          maximumYear: date.year + 1,
          onDateTimeChanged: (DateTime value) {
            print(value);
          },
        ),
      );
    }
  );
}