import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/palette.dart';
import 'appInfo.dart';
import 'popDialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const String _title = '설정';
  static const List<String> _data = [
    '문의하기',
    '앱 정보',
    // '로그아웃',
    // '회원탈퇴'
  ];
  static const List<IconData> _icon = [
    Icons.email,
    Icons.info,
    // Icons.logout,
    // Icons.no_accounts,
  ];

  Widget _settingListView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int i) {
          return InkWell(
            onTap: () {
              // 각 항목에 따라 함수 호출
              if (_data[i] == '문의하기') {
                showEmailDialog(context, i); // 문의하기 팝업 띄우기
              } else if (_data[i] == '앱 정보') {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppInfoPage())
                );
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
      ),
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
          body: Column(children: <Widget>[
            _settingListView(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (){
                      launchUrl(Uri.parse('https://akaseoyoung.notion.site/13cf9e28310c4f4f9f36a8e57b830286?pvs=4'));
                    },
                    child: Text('이용약관',
                    style: TextStyle(
                      color: Palette.green2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('|',
                  style: TextStyle(
                    color: Palette.green2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: (){
                    launchUrl(Uri.parse('https://akaseoyoung.notion.site/19ec0893e246478582c30d31260f49cf?pvs=4'));
                  },
                  child: Text('개인정보처리방침',
                    style: TextStyle(
                      color: Palette.green2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ]
          ),
        ),
      ),
    );
  }
}