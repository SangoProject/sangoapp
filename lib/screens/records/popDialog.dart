import 'package:flutter/material.dart';

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
            Text("경과 시간: $formattedTime"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 종료하기 버튼을 눌렀을 때 실행될 로직을 여기에 추가
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
            child: Text("종료하기"),
          ),
          TextButton(
            onPressed: () {
              // 취소하기 버튼을 눌렀을 때 실행될 로직을 여기에 추가
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
            child: Text("취소하기"),
          ),
        ],
      );
    },
  );
}