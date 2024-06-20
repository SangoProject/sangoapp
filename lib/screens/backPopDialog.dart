// 백그라운드 위치 권한 설정 팝업 위젯
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showBackgroundPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("위치 권한 필요"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text("이 앱은 사용자의 산책 기록을 위해 앱이 백그라운드에 실행 중일 때도 위치 데이터를 수집합니다.\n"
                "이 앱을 사용하고 있지 않을 때도 이 기기의 위치에 접근하도록 허용하시겠습니까?\n"
                "허용 거부 시 일부 서비스에 대해 사용이 제한될 수 있습니다."),
          ],
        ),
        actions: [
          Center(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                  openAppSettings(); // 설정 앱으로 이동
                },
                child: Text('항상 허용 설정'),
              ),
            ),
          ),
        ],
      );
    },
  );
}