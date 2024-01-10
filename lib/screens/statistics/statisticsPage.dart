import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../goal/realDistanceTotal.dart';

class _BarChart extends StatelessWidget {
  final RealDistanceTotal realDistanceTotal;

  const _BarChart({required this.realDistanceTotal});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getChartDataForThisWeek(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: BarChart(
                      BarChartData(
                        barTouchData: barTouchData,
                        titlesData: titlesData,
                        borderData: borderData,
                        barGroups: snapshot.data as List<BarChartGroupData>,
                        gridData: FlGridData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // 이번주 산책 거리와 횟수
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Palette.green1, width: 2),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '산책 거리 ${calculateTotalDistance(snapshot.data as List<BarChartGroupData>)} km',
                        style: TextStyle(color: Palette.green3, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Palette.green1, width: 2),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '산책 횟수 ${calculateTotalWalks(snapshot.data as List<BarChartGroupData>)} 회',
                        style: TextStyle(color: Palette.green3, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
  // 이번주의 전체 산책 거리 계산
  double calculateTotalDistance(List<BarChartGroupData> barGroups) {
    double totalDistance = 0.0;

    for (var barGroup in barGroups) {
      totalDistance += barGroup.barRods[0].toY;
    }
    return totalDistance;
  }

  // 이번주의 전체 산책 횟수 계산
  int calculateTotalWalks(List<BarChartGroupData> barGroups) {
    int totalWalks = 0;

    for (var barGroup in barGroups) {
      if (barGroup.barRods[0].toY > 0) {
        totalWalks++;
      }
    }
    return totalWalks;
  }

  Future<List<BarChartGroupData>> getChartDataForThisWeek() async {
    List<BarChartGroupData> barGroups = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime calculateDay = now.subtract(Duration(days: 1));
      int day = calculateDay.weekday;
      DateTime currentDay = now.subtract(Duration(days: 7 - i - day));

      double totalDistance = 0.0;

      if (i < day + day) {
        totalDistance = await realDistanceTotal.fetchAndCalculateTotalDistance(currentDay);
      }

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: totalDistance,
              gradient: _barsGradient,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }

    return barGroups;
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Palette.green1,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Palette.green3,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '일';
        break;
      case 1:
        text = '월';
        break;
      case 2:
        text = '화';
        break;
      case 3:
        text = '수';
        break;
      case 4:
        text = '목';
        break;
      case 5:
        text = '금';
        break;
      case 6:
        text = '토';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => LinearGradient(
    colors: const [
      Palette.green1,
      Palette.green3,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatefulWidget> createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  final RealDistanceTotal realDistanceTotal = RealDistanceTotal();

  @override
  Widget build(BuildContext context) {
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: _BarChart(realDistanceTotal: realDistanceTotal,)
        ),
      ),
    );
  }
}