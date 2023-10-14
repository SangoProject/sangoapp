import 'package:flutter/material.dart';
import 'dart:math';

class ChartPage extends StatelessWidget {
  var goalDistance;
  var realDistance;
  ChartPage(this.goalDistance, this.realDistance);

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
                painter: PieChart(double.parse(goalDistance), double.parse(realDistance)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChart extends CustomPainter {
  double realDistance;
  double goalDistance;
  double percentage = 0;
  double textScaleFactor = 1.0;

  PieChart(this.goalDistance, this.realDistance){
    percentage = realDistance * 100 / goalDistance;
    final tmp = percentage.toStringAsFixed(1);
    percentage = double.parse(tmp);
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

    drawText(canvas, size, "$percentage %");
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