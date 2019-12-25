import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureRoute extends StatefulWidget {
  @override
  _ListenerState createState() => _ListenerState();
}
class _ListenerState extends State<GestureRoute> {
  PointerEvent _event;
  void updateState(event) {
    setState(() {
      _event = event;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gesture'),),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Listener(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  width: 300,
                  height: 150,
                  child: Text(_event?.toString()??'', style: TextStyle(color: Colors.white),),
                ),
                onPointerDown: (PointerEvent event) => setState(() => _event = event),
                onPointerMove: (PointerEvent event) => setState(() => _event = event),
                onPointerUp: (PointerEvent event) => setState(() => _event = event),
              ),
              Listener(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(300, 150)),
                  child: Center(child: Text('box a'),),
                ),
                behavior: HitTestBehavior.opaque, // 添加此属性后，点击整个节点区域有效
                onPointerDown: (event) => print('down a'),
              ),
              Stack(
                children: <Widget>[
                  Listener(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(300, 150)),
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.blue)
                      ),
                    ),
                    onPointerDown: (event) => print('down0'),
                  ),
                  Listener(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(200, 100)),
                      child: Center(child: Text('左上角200*100范围内非文本区域点击'),),
                    ),
                    onPointerDown: (event) => print('down1'),
  //                  behavior: HitTestBehavior.translucent, // 放开此注释后可以“点透”
                  )
                ],
              ),
              // 忽略PointerEvent
              // AbsorbPointer 本身会触发事件，但是子节点不会触发
              // IgnorePointer 本身和子节点都不会处罚事件
              Listener(
                child: IgnorePointer(
                  child: Listener(
                    child: Container(
                      color: Colors.red,
                      width: 200,
                      height: 100,
                    ),
                    onPointerDown: (event) => print('in'),
                  ),
                ),
                onPointerDown: (event) => print('up'),
              ),
              Title(child: Text('GestureDetector'), color: Colors.white,),
              GestureDetectorTest(),
              Title(child: Text('手势滑动'), color: Colors.white,),
              // _Drag()
            ],
          ),
        ),
      ),
    );
  }
}

// GestureDetector 手势探测
// GestureRewcognizer 手势识别
class GestureDetectorTest extends StatefulWidget {
  @override
  _GestureDetectorTestState createState() => _GestureDetectorTestState();
}

class _GestureDetectorTestState extends State<GestureDetectorTest> {
  String _operation = '没有探测到手势事件'; // 保存事件名
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 200,
        height: 100,
        child: Text(_operation, style: TextStyle(color: Colors.white),),
      ),
      onTap: () => updateText('点击'),
      onDoubleTap: () => updateText('双击'),
      onLongPress: () => updateText('长按'),
    );
  }
  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

class _Drag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 0.0; // 距顶部的偏移
  double _left = 0.0; // 距左边的偏移
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          width: 200,
          height: 100,
          child: GestureDetector(
            child: CircleAvatar(child: Text('我是一只小🐓，咿呀咿呀呦'),),
            onPanDown: (DragDownDetails e) => print('用户手指按下时：${e.globalPosition}'),
            onPanUpdate: (DragUpdateDetails e) => {
              // 手指滑动时，更新偏移
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              })
            },
            onPanEnd: (DragEndDetails e) => print('滑动结束时的速度：${e.velocity}'),
          ),
        )
      ],
    );
  }
}