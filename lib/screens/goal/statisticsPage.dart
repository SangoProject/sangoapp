import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:sangoproject/config/palette.dart';
import 'package:sangoproject/screens/goal/barGraph.dart';
import 'package:sangoproject/screens/goal/barGraphData.dart';


class StatisticsPage extends StatefulWidget{
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
        title: Text('통계'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              '주간 통계',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ChartContainer(
              title: 'Bar Chart',
              color: Palette.iconColor,
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
    color: Colors.white,
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