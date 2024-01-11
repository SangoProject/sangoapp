// 목표 달성 차트의 기본 구조에 대한 파일
import 'package:flutter/material.dart';
import 'dart:math';
import '../../config/palette.dart';

class ChartPage extends StatelessWidget {
  final goalDistance; // 목표한 산책 거리
  final realDistance; // 실제로 산책한 거리
  ChartPage(this.goalDistance, this.realDistance, {super.key});

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
                // PieChart를 그려줌. (산책한 거리와 목표한 거리에 대한 그래프)
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
  double realDistance; // 실제로 움직인 거리
  double goalDistance; // 목표한 거리
  double percentage = 0; // 실제로 움직인 거리와 목표한 거리에 대한 비율
  double textScaleFactor = 1.0;

  // 목표와 실제거리의 비율을 계산해서 percentage에 저장함
  PieChart(this.goalDistance, this.realDistance){
    percentage = realDistance * 100 / goalDistance;
    final tmp = percentage.toStringAsFixed(1);
    percentage = double.parse(tmp);
  }

  // 목표 그래프 UI를 그려줌
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

    paint.color = Palette.logoColor;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -pi / 2, arcAngle, false, paint);

    drawText(canvas, size, "$percentage %");
  }

  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Pretendard',
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