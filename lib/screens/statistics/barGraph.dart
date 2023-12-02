// bar chart 재사용 용도
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Widget chart;

  const ChartContainer({
    Key? key,
    required this.title,
    required this.color,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.only(top: 10),
                  child: chart,
                ),
            ),
            // Expanded(
            //   child: Container(
            //     margin: EdgeInsets.all(16.0),
            //     padding: EdgeInsets.all(16.0),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(12.0),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.3),
            //           spreadRadius: 2,
            //           blurRadius: 5,
            //           offset: Offset(0, 3),
            //         ),
            //       ],
            //     ),
            //     child: Center(
            //       child: Text(
            //         '통계 기능 준비중입니다.',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.green,
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}