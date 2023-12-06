// 통계 화면에 대한 구조를 작성해둔 파일
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:sangoproject/config/palette.dart';
import 'package:sangoproject/screens/statistics/barGraph.dart';
import 'package:sangoproject/screens/statistics/barGraphData.dart';


class StatisticsPage extends StatefulWidget{
  const StatisticsPage({super.key});

  @override
  State<StatefulWidget> createState(){
    return _StatisticsPage();
  }
}

class _StatisticsPage extends State<StatisticsPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '산책 통계',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              '<      11월 5주차      >',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ChartContainer(
              title: 'Bar Chart',
              color: Colors.white,
              chart: BarChartContent(),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: TabBar(),
    );
  }
}

class BarChartContent extends StatelessWidget {
  const BarChartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getTitles,
              reservedSize: 36,
            ),
          ),
        ),
        maxY: 10,
        barGroups: barChartGroupData,
      ),
    );
  }
}

Widget getTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Palette.green3,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('일', style: style);
      break;
    case 2:
      text = const Text('월', style: style);
      break;
    case 3:
      text = const Text('화', style: style);
      break;
    case 4:
      text = const Text('수', style: style);
      break;
    case 5:
      text = const Text('목', style: style);
      break;
    case 6:
      text = const Text('금', style: style);
      break;
    case 7:
      text = const Text('토', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: text,
  );
}