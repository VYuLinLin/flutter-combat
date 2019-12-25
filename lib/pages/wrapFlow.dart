import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrapFlowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('流式布局 Wrap、Flow'),
      ),
      body: Column(
        children: <Widget>[
          Text('Wrap'),
          Wrap(
            spacing: 8, // 主轴（水平）方向间距
            runSpacing: 4, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, // 沿主轴方向居中
            children: <Widget>[
              Chip(
                avatar: CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('A')),
                label: Text('Hamilsss'),
              ),
              Chip(
                avatar: CircleAvatar(
                  child: Text('M'),
                  backgroundColor: Colors.blue,
                ),
                label: Text('Lafaye'),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('H'),
                ),
                label: Text('Mulligan'),
              ),
              Chip(
                avatar: CircleAvatar(
                  child: Text('J'),
                  backgroundColor: Colors.blue,
                ),
                label: Text('Laurens'),
              )
            ],
          ),
          Text('Flow'),
          Flow(
            delegate: TestFlowDelegate(margin: EdgeInsets.all(10)),
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                color: Colors.red,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.blue,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.green,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.yellow,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.redAccent,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.amberAccent,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.greenAccent,
              ),
            ],
          )
        ],
      ),
    );
  }
}

// 自定义实现流式布局的布局转换规则
class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 计算每一个Widget位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        // 绘制子Widget
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints) {
    // 指定Flow的大小
    return Size(double.infinity, 200);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
