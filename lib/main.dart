import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'pages/focus.dart';
import 'pages/form.dart';
import 'pages/gridView.dart';
import 'pages/inheritedWidget.dart';
import 'pages/input.dart';
import 'pages/listView.dart';
import 'pages/progressIndicator.dart';
import 'pages/provider.dart' as Provider;
import 'pages/scaffold.dart';
import 'pages/singleScrollView.dart';
import 'pages/wrapFlow.dart';
import 'pages/dialog.dart';
import 'pages/gesture.dart';
import 'pages/animation.dart';
import 'pages/animatedSwitcher.dart';
import 'pages/turnBox.dart';
import 'pages/customPaint.dart';
import 'pages/dioHttp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        platform: TargetPlatform.iOS
      ),
      initialRoute: "/", //名为"/"的路由作为应用的home(首页)
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        'dio_http_page': (context) => DioHttpRoute(),
        'custom_paint_page': (context) => CustomPaintRoute(),
        'turn_box_page': (context) => TurnBoxRoute(),
        'animted_switcher_page': (context) => AnimatedSwitcherRoute(),
        'animation_page': (context) => ScaleAnimationRoute(),
        'gesture_page': (context) => GestureRoute(),
        'dialog_page': (context) => DialogRoute(),
        'inherited_widget_page': (context) => InheritedWidgetRoute(),
        'provider_page': (context) => Provider.ProviderRoute(),
        'grid_view_page': (context) => GridViewRoute(),
        'list_view_reparated_page': (context) => ListViewSeparatedRoute(),
        'list_view_page': (context) => ListViewRoute(),
        'single_scroll_view_page': (context) => SingleChildScrollViewRoute(),
        'scaffold_page': (context) => ScaffoldRoute(),
        'wrap_flow_page': (context) => WrapFlowRoute(),
        'indicator_page': (context) => IndicatorTestRoute(),
        'form_page': (context) => FormTestRoute(),
        'focus_page': (context) => FocusTestRoute(),
        'input_page': (context) => FormPage(),
        'tip2': (context) =>
            TipRoute(text: ModalRoute.of(context).settings.arguments),
        'new_page': (context) => NewRoute(),
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'), // 注册首页路由
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// 生成随机英文字符
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordpair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(wordpair.toString()),
    );
  }
}

// 首页状态管理组件
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DateTime _lastPressedAt; // 上次点击返回的时间
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
//      debugDumpApp();
//      debugger();
//      debugDumpRenderTree();
//      debugDumpLayerTree();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 导航返回拦截
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          // 两次点击时间间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          _incrementCounter();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.dashboard, color: Colors.white), // 自定义图标
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            )),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              SizedBox(), // 中间位置空出
              IconButton(
                icon: Icon(Icons.business),
                onPressed: () {},
              ),
            ],
            // 均分底部导航栏横向空间
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
        drawer: MyDrawer(),
        body: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Text('hello world'),
                  RandomWordsWidget(),
                  FlatButton(
                    child: Text('open new route'),
                    textColor: Colors.blue,
                    onPressed: () {
                      // 导航到新路由,以下几种路由跳转方式都可以

                      // 命名路由跳转
                      // Navigator.pushNamed(context, 'new_page');

                      // 命名路由跳转并传参
                      Navigator.of(context).pushNamed('new_page',
                          arguments: {'key': 'hello world!'});

                      // 非命名路由跳转
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => NewRoute()));
                    },
                  ),
                  RaisedButton(
                    child: Text('open new route and transfer parameters'),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RouterTestRoute()));
                    },
                  ),
                  FlatButton(
                      child: Text('表单页面'),
                      color: Colors.lightBlue,
                      onPressed: () {
                        Navigator.pushNamed(context, 'input_page');
                      }),
                  OutlineButton(
                    child: Text('聚焦页面'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'focus_page');
                    },
                  ),
                  FlatButton(
                    child: Text('表单页面'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'form_page');
                    },
                  ),
                  OutlineButton(
                    child: Text('进度指示器'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'indicator_page');
                    },
                  ),
                  FlatButton(
                    child: Text('流式布局'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'wrap_flow_page');
                    },
                  ),
                  OutlineButton(
                    child: Text('脚手架页面'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'scaffold_page');
                    },
                  ),
                  FlatButton(
                    child: Text('单节点内容滚动'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'single_scroll_view_page');
                    },
                  ),
                  OutlineButton(
                    child: Text('滚动列表'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'list_view_page');
                    },
                  ),
                  FlatButton(
                    child: Text('ListView.reparated'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'list_view_reparated_page');
                    },
                  ),
                  OutlineButton(
                    child: Text('gridView.builder'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'grid_view_page');
                    },
                  ),
                  FlatButton(
                    child: Text('数据共享'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'inherited_widget_page');
                    },
                  ),
                  OutlineButton(
                    child: Text('跨组件数据共享'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'provider_page');
                    },
                  ),
                  FlatButton(
                    child: Text('dialog'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'dialog_page');
                    },
                  ),
                  OutlineButton(
                    child: Text('指针与手势事件'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'gesture_page');
                    },
                  ),
                  FlatButton(
                    child: Text('动画'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'animation_page');
                    },
                  ),
                  RaisedButton(
                    child: Text('切换动画'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'animted_switcher_page');
                    },
                  ),
                  RaisedButton(
                    child: Text('自定义旋转动画'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'turn_box_page');
                    },
                  ),
                  RaisedButton(
                    child: Text('自定义绘画组件'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'custom_paint_page');
                    },
                  ),
                  RaisedButton(
                    child: Text('dio请求库使用'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'dio_http_page');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Object args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("New route"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[Text('这是一个新的路由页面'), Text('路由参数：$args')],
          ),
        ));
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('提示页面'),
        ),
        body: Center(
            child: RaisedButton(
          child: Text('打开提示页'),
          onPressed: () async {
            // 打开TipRoute 并等待返回结果
            // var result = await Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => TipRoute( text: '我是提示xxxx',))
            // );
            var result = await Navigator.of(context)
                .pushNamed('tip2', arguments: '我是通过路由注册表传送的');
            print('路由返回值：$result');
          },
        )));
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({Key key, this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('提示')),
        body: Padding(
          padding: EdgeInsets.all(18),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(text),
                RaisedButton(
                  child: Text('返回'),
                  onPressed: () => Navigator.pop(context, '我是返回值'),
                )
              ],
            ),
          ),
        ));
  }
}
