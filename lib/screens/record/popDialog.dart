// 산책 종료 확인 팝업 위젯
import 'package:flutter/material.dart';
import '../../main_page.dart';

void showExitConfirmationDialog(BuildContext context, double distanceTotal, String formattedTime) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("산책을 종료하시겠습니까?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("이동 거리: ${(distanceTotal / 1000).toStringAsFixed(2)} km"),
            Text("산책 시간: $formattedTime"),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Text("종료하기"),
            ),
          ),
        ],
      );
    },
  );
}

Future<bool?> showExitAlertDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('경고'),
        content: Text('기록중 종료시 데이터가 초기화될 수 있습니다'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // 취소 버튼
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            child: Text('종료'),
          ),
        ],
      );
    },
  );
}
