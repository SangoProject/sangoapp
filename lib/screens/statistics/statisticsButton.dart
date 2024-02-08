// 주간 산책 통계 버튼. 누르면 주간 산책 통계를 볼 수 있음.
import 'package:flutter/material.dart';

import 'package:sangoproject/screens/statistics/statisticsPage.dart';
import 'package:sangoproject/config/palette.dart';

class StatisticsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Stack(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Palette.green1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        '산책 통계',
                        style: TextStyle(fontSize: 18, fontFamily: 'Pretendard', fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.bar_chart,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          Positioned.fill(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticsPage()),
                );
              },
              splashColor: Colors.grey,
              highlightColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}