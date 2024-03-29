// 홈화면에서 재난정보를 확인하기 위해 접근하는 배너 위젯
import 'package:flutter/material.dart';
import 'package:sangoproject/config/palette.dart';
import 'package:sangoproject/screens/disaster/disasterList.dart';

class Disaster extends StatelessWidget {
  const Disaster({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerheight = MediaQuery.of(context).size.height;
    final bannerwidth = MediaQuery.of(context).size.width;

    // 탭시 재난정보 리스트 페이지로 전환(DisasterListPage.dart)
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisasterListPage()),
        );
      },
      child: Container(
        color: Palette.green3,
        width: bannerwidth,
        height: bannerheight / 16,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '오늘의 안전정보 알리미',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.notification_important_outlined,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}