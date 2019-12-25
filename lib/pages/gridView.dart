import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridViewRoute extends StatefulWidget {
  @override
  _GridViewState createState() => _GridViewState();
}

class _GridViewState extends State<GridViewRoute> {
  List<IconData> _icons = []; // 保存Icon数据
  ScrollController _controller = ScrollController(); // 滚动控制
  bool showToTopBtn = false; // 是否显示‘返回到顶部’按钮

  @override
  void initState() {
    super.initState();
    _retrieveIcons(); // 初始化数据
    _controller.addListener(() {
      var offset = _controller.offset;
      // print(offset); // 打印滚动位置
      if (offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // 为了避免内存泄漏，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridView'),),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 每行三列
          childAspectRatio: 1.0 // 显示区域宽高相等
        ),
        itemCount: _icons.length,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          // 如果显示到最后一个并且Icon总数小于200时继续获取数据
          if (index == _icons.length - 1 && _icons.length < 200) {
            _retrieveIcons();
          } else {
            return Icon(_icons[index]);
          }
        },
      ),
      floatingActionButton: !showToTopBtn ? null : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          // 返回到顶部时执行动画
          _controller.animateTo(0,
            duration: Duration(milliseconds: 200),
            curve: Curves.ease
          );
        },
      ),
    );
  }

  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}

