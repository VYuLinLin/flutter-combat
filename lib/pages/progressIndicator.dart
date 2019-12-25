import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorTestRoute extends StatefulWidget {
  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<IndicatorTestRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    // 动画执行时间5秒
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('进度指示器'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: <Widget>[
            Text('线性进度条'),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                value: .5,
              ),
            ),
            Text('圆环进度条'),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                value: .5,
              ),
            ),
            Text('自定义尺寸'),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 3,
                width: 200,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  value: .5,
                ),
              ),
            ),
            Text('进度色动画'),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          ColorTween(begin: Colors.grey, end: Colors.blue)
                              .animate(_animationController),
                      value: _animationController.value,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
