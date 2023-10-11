//나중에 재사용 가능하도록 위젯으로 만듦. (목표 달성 % (파이 차트))
import 'package:flutter/material.dart';
import 'dart:math';

class ChartPage extends StatelessWidget {
  //List<double> points = [50, 0, 73, 100, 150, 120, 200, 80];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: CustomPaint(
                size: Size(150, 150),
                painter: PieChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChart extends CustomPainter {
  double realDistance = 1.5;
  double goalDistance = 5.5;
  double percentage = 0;
  double textScaleFactor = 1.0;

  PieChart(){
    percentage = realDistance * 100 / goalDistance;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFB7B8AD)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = min(
        size.width / 2 - paint.strokeWidth / 2,
        size.height / 2 - paint.strokeWidth / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    double arcAngle = 2 * pi * (percentage / 100);

    paint..color = Color(0xFF436726);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -pi / 2, arcAngle, false, paint);

    drawText(canvas, size, "27.5 %");
  }

  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        text: text);
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout();
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(PieChart old) {
    return old.percentage != percentage;
  }
}