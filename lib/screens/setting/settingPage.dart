import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sangoproject/screens/googleLogin.dart';

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

  // 함수 리스트에서 직접 호출할 함수들 정의
  static void _logout(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    // GoogleLogin 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GoogleLogin()),
    );
  }

  // 로그아웃 팝업 띄우기
  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('로그아웃 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 닫기
              },
              child: Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 닫기
                _logout(context); // 로그아웃 수행
              },
              child: Text('예'),
            ),
          ],
        );
      },
    );
  }

  Widget _settingListView(BuildContext context) {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          onTap: () {
            // 각 항목에 따라 함수 호출
            if (_data[i] == '로그아웃') {
              _showLogoutDialog(context); // 로그아웃 팝업 띄우기
            } else {
              // 다른 항목에 따른 동작 추가
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