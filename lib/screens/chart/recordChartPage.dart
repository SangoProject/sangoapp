import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/palette.dart';
import 'chartData.dart';

class RecordLineChart extends StatefulWidget {
  const RecordLineChart({super.key});

  @override
  State<RecordLineChart> createState() => _RecordLineChartState();
}

class _RecordLineChartState extends State<RecordLineChart> {
  List<FlSpot> weeklyData = [];
  List<Color> gradientColors = [
    Palette.green1,
    Palette.green3,
  ];
  bool showWeeklyRecord = true;
  double weeklyAverage = 0.0; // 추가: 주간 평균 데이터를 저장할 변수
  bool selectedValue = true; // true: 5km 기준, false: 50km 기준

  void toggleButton(){
    setState(() {
      showWeeklyRecord = !showWeeklyRecord;
    });
  }

  @override
  void initState() {
    super.initState();
    // calculateWeeklyAverage 함수를 호출하고 결과를 weeklyAverage 변수에 할당
    calculateWeeklyAverage(DateTime.now()).then((value) {
      setState(() {
        weeklyAverage = value; // 주간 평균 데이터 할당
      });
    });

    fetchWeeklyData(DateTime.now()).then((data) {
      setState(() {
        weeklyData = data;
        // maxY = getMaxYValue();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<bool> isSelected = [true, false];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: SizedBox()
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              GestureDetector(
                onTap: toggleButton,
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Palette.green2,
                      width: 2.0,
                    ),
                    color: showWeeklyRecord ? Palette.green2 : Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: showWeeklyRecord ? Palette.green2 : Colors.white,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(25.0),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '주간기록',
                            style: TextStyle(
                              color: showWeeklyRecord? Colors.white : Palette.green2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: showWeeklyRecord ? Colors.white : Palette.green2,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(25.0),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '평균기록',
                            style: TextStyle(
                              color: showWeeklyRecord? Palette.green2 : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: DropdownButton<bool>(
                    value: selectedValue,
                    onChanged: (bool? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: const <DropdownMenuItem<bool>>[
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text('5km 기준'),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text('50km 기준'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: AspectRatio(
            aspectRatio: 1.00,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(
                showWeeklyRecord ? mainData() : avgData(),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: SizedBox()
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
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
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;

    // selectedValue 값에 따라 분기 처리
    if (selectedValue) {
      switch (value.toInt()) {
        case 0:
          text = '(km)';
          break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
          text = value.toInt().toString();
          break;
        default:
          text = '';
      }
    } else {
      switch (value.toInt()) {
        case 0:
          text = '(km)';
          break;
        case 10:
        case 20:
        case 30:
        case 40:
        case 50:
          text = value.toInt().toString();
          break;
        default:
          text = '';
      }
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    double horizontalInterval = selectedValue ? 1 : 10;
    double maxY = selectedValue ? 5 : 50;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: horizontalInterval,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.green1,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Palette.green1,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Palette.green1),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, getSpotValue(0)), // 일요일 데이터
            FlSpot(2, getSpotValue(1)), // 월요일 데이터
            FlSpot(3, getSpotValue(2)), // 화요일 데이터
            FlSpot(4, getSpotValue(3)), // 수요일 데이터
            FlSpot(5, getSpotValue(4)), // 목요일 데이터
            FlSpot(6, getSpotValue(5)), // 금요일 데이터
            FlSpot(7, getSpotValue(6)), // 토요일 데이터
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    double horizontalInterval = selectedValue ? 1 : 10;
    double maxY = selectedValue ? 5 : 50;

    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: horizontalInterval,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Palette.green1,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Palette.green1,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Palette.green1),
      ),
      minX: 0,
      maxX: 8,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, weeklyAverage),  // 일
            FlSpot(2, weeklyAverage),  // 월
            FlSpot(3, weeklyAverage),  // 화
            FlSpot(4, weeklyAverage),  // 수
            FlSpot(5, weeklyAverage),  // 목
            FlSpot(6, weeklyAverage),  // 금
            FlSpot(7, weeklyAverage),  // 토
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 각 요일에 해당하는 FlSpot의 Y 값 가져오기
  double getSpotValue(int index) {
    if (index < weeklyData.length) {
      return weeklyData[index].y;
    } else {
      return 0; // 데이터가 없는 경우 0으로 처리
    }
  }

  // Y 축의 최대값 가져오기
  double getMaxYValue() {
    if (weeklyData.isEmpty) {
      return 5; // 기본 최대값
    } else {
      double maxValue = 5;

      if (selectedValue) {
        // selectedValue가 true일 때 최대값을 5로 제한
        return maxValue > 5 ? 5 : maxValue;
      } else {
        // selectedValue가 false일 때 최대값을 50으로 제한
        return maxValue > 50 ? 50 : maxValue;
      }
    }
  }
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
            color: Palette.green2,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );


class RecordChartPage extends StatefulWidget {
  const RecordChartPage({super.key});

  @override
  State<StatefulWidget> createState() => RecordChartPageState();
}

class RecordChartPageState extends State<RecordChartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '이번주 산책 통계',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: RecordLineChart(),
      ),
    );
  }
}