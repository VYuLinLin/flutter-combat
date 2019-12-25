import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewRoute extends StatelessWidget {
  String str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  @override
  Widget build(BuildContext context) {
    var navbars = List<NavBar>();
    navbars.add(NavBar(title: '标题', color: Colors.blue,));
    navbars.add(NavBar(title: '标题', color: Colors.white,));
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Column(children: navbars),
                Column(children: str.split('').map((c) => Text(c, textScaleFactor: 2,)).toList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final String title;
  final Color color; // 背景颜色

  NavBar({
    Key key,
    this.title,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3
          )
        ]
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // 根据背景色亮度来确定title颜色
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black
        )
      ),
      alignment: Alignment.center,
    );
  }
}