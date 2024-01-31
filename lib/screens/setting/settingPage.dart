import 'package:flutter/material.dart';
import 'popDialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const String _title = '설정';
  static const List<String> _data = [
    '알림',
    '앱 정보',
    '로그아웃',
    '회원탈퇴'
  ];
  static const List<IconData> _icon = [
    Icons.notifications,
    Icons.info,
    Icons.logout,
    Icons.no_accounts,
  ];

  Widget _settingListView(BuildContext context) {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          onTap: () {
            // 각 항목에 따라 함수 호출
            if (_data[i] == '로그아웃') {
              showLogoutDialog(context, i); // 로그아웃 팝업 띄우기
            } else if(_data[i] == '회원탈퇴') {
              showUserDeleteDialog(context, i); // 회원탈퇴 팝업 띄우기
            } else{
              // 알림, 앱정보 추가 구현 필요
            }
          },
          child: ListTile(
            title: Text(
              _data[i],
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            trailing: Icon(_icon[i]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        title: _title,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              _title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: _settingListView(context),
        ),
      ),
    );
  }
}