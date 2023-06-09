import 'package:flutter/material.dart';
import 'package:sangoproject/screens/components/apiButton.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const String _title = '설정';
  static const List<String> _data = [
    '계정',
    '알림',
    '앱 정보',
    '로그아웃',
  ];
  static const List<IconData> _icon = [
    Icons.account_circle,
    Icons.notifications,
    Icons.info,
    Icons.logout,
  ];

  Widget _settingListView() {
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          onTap: (){},
          child: ListTile(
            title: Text(_data[i],
            style: TextStyle(
              fontSize: 16
            ),),
            trailing: Icon(_icon[i]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          elevation: 0,
          backgroundColor: Colors.lime,
        ),
        body: _settingListView(),
      ),
    );
  }
}