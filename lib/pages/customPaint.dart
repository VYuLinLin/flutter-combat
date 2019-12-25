import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPaintRoute extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('自定义绘制组件'),),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size) {
    double ew = size.width / 15;
    double eh = size.height / 15;

    // 画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill // 填充
      ..color = Color(0x77cdb175); // 背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);
    
    // 画棋盘网格
    paint..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;
    
    for (int i = 0; i < 15; i++) {
      double dy = eh * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i < 15; i++) {
      double dx = ew * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    // 画一个黑子
    paint..style = PaintingStyle.fill..color =  Colors.black;
    canvas.drawCircle(
      Offset(size.width / 2 - ew / 2, size.height / 2 - eh / 2),
      min(ew / 2, eh / 2) - 2,
      paint
    );

    // 画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2 + ew / 2, size.height / 2 - eh / 2),
      min(ew / 2, eh / 2) - 2,
      paint
    );
  }

  // 在实际场景张正确利用此回调可以避免重绘开销，本示例只是简单的返回true;
  @override bool shouldRepaint(CustomPainter oldDelegate) => true;
}