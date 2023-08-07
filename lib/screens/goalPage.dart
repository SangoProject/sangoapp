import 'package:flutter/material.dart';
import 'package:sangoproject/config/palette.dart';
import 'package:sangoproject/screens/components/editgoalGraph.dart';

import 'components/goalGraph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sangoproject/screens/components/barGraph.dart';
import 'package:sangoproject/screens/goal_data/barGraph_data.dart';


class GoalPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _GoalPage();
  }
}

class _GoalPage extends State<GoalPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('goal page'),
      ),
      body: Column(
        children: <Widget>[
          // 목표
          Padding(
          padding: EdgeInsets.all(15),
            child: Text(
            '오늘의 목표',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            child: ChartPage(),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditGoalGraph()));
            },
          ),
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