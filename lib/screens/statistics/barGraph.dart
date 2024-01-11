// // 산책 통계를 나타내는 bar chart 기본 구조
// import 'package:flutter/material.dart';
//
// class ChartContainer extends StatelessWidget {
//   final Color color;
//   final String title;
//   final Widget chart;
//
//   const ChartContainer({
//     Key? key,
//     required this.title,
//     required this.color,
//     required this.chart,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.95,
//         height: MediaQuery.of(context).size.width * 0.95,
//         padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   padding: EdgeInsets.only(top: 10),
//                   child: chart,
//                 ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../../config/palette.dart';
//
// class _BarChart extends StatelessWidget {
//   _BarChart();
//
//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         barTouchData: barTouchData,
//         titlesData: titlesData,
//         borderData: borderData,
//         barGroups: barGroups,
//         gridData: FlGridData(show: false),
//         alignment: BarChartAlignment.spaceAround,
//         maxY: 20,
//       ),
//     );
//   }
//
//   BarTouchData get barTouchData => BarTouchData(
//     enabled: false,
//     touchTooltipData: BarTouchTooltipData(
//       tooltipBgColor: Colors.transparent,
//       tooltipPadding: EdgeInsets.zero,
//       tooltipMargin: 8,
//       getTooltipItem: (
//           BarChartGroupData group,
//           int groupIndex,
//           BarChartRodData rod,
//           int rodIndex,
//           ) {
//         return BarTooltipItem(
//           rod.toY.round().toString(),
//           const TextStyle(
//             color: Palette.green1,
//             fontWeight: FontWeight.bold,
//           ),
//         );
//       },
//     ),
//   );
//
//   Widget getTitles(double value, TitleMeta meta) {
//     final style = TextStyle(
//       color: Palette.green3,
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 0:
//         text = '일';
//         break;
//       case 1:
//         text = '월';
//         break;
//       case 2:
//         text = '화';
//         break;
//       case 3:
//         text = '수';
//         break;
//       case 4:
//         text = '목';
//         break;
//       case 5:
//         text = '금';
//         break;
//       case 6:
//         text = '토';
//         break;
//       default:
//         text = '';
//         break;
//     }
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4,
//       child: Text(text, style: style),
//     );
//   }
//
//   FlTitlesData get titlesData => FlTitlesData(
//     show: true,
//     bottomTitles: AxisTitles(
//       sideTitles: SideTitles(
//         showTitles: true,
//         reservedSize: 30,
//         getTitlesWidget: getTitles,
//       ),
//     ),
//     leftTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     topTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     rightTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//   );
//
//   FlBorderData get borderData => FlBorderData(
//     show: false,
//   );
//
//   LinearGradient get _barsGradient => LinearGradient(
//     colors: const [
//       Palette.green1,
//       Palette.green3,
//     ],
//     begin: Alignment.bottomCenter,
//     end: Alignment.topCenter,
//   );
//
//   List<BarChartGroupData> get barGroups => [
//     BarChartGroupData(
//       x: 0,
//       barRods: [
//         BarChartRodData(
//           toY: 8,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 1,
//       barRods: [
//         BarChartRodData(
//           toY: 10,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 2,
//       barRods: [
//         BarChartRodData(
//           toY: 14,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 3,
//       barRods: [
//         BarChartRodData(
//           toY: 15,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 4,
//       barRods: [
//         BarChartRodData(
//           toY: 13,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 5,
//       barRods: [
//         BarChartRodData(
//           toY: 10,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 6,
//       barRods: [
//         BarChartRodData(
//           toY: 16,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//   ];
// }