// 산책 통계 데이터를 불러오는 파일
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../config/palette.dart';

List<BarChartGroupData> barChartGroupData = [
  BarChartGroupData(x: 1, barRods: [
    BarChartRodData(fromY: 0, toY: 6, width: 15, color: Palette.logoColor,
    borderRadius: BorderRadius.zero,),
  ]),
  BarChartGroupData(x: 2, barRods: [
    BarChartRodData(fromY: 0, toY: 8, width: 15, color: Palette.logoColor,
    borderRadius: BorderRadius.zero,),
  ]),
  BarChartGroupData(x: 3, barRods: [
    BarChartRodData(fromY: 0, toY: 0, width: 15, color: Palette.logoColor,
    borderRadius: BorderRadius.zero,),
  ]),
  BarChartGroupData(x: 4, barRods: [
    BarChartRodData(fromY: 0, toY: 3, width: 15, color: Palette.logoColor,
    borderRadius: BorderRadius.zero,),
  ]),
  BarChartGroupData(x: 5, barRods: [
    BarChartRodData(fromY: 0, toY: 10, width: 15, color: Palette.logoColor,
    borderRadius: BorderRadius.zero,),
  ]),
  BarChartGroupData(x: 6, barRods: [
    BarChartRodData(fromY: 0, toY: 6, width: 15, color: Palette.logoColor,
    borderRadius: BorderRadius.zero,),
  ]),
  BarChartGroupData(x: 7, barRods: [
    BarChartRodData(fromY: 0, toY: 3, width: 15, color: Palette.logoColor,
    borderRadius: BorderRadius.zero,),
  ]),
];