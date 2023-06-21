import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SettingPage();
  }
}

class _SettingPage extends State<SettingPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
// <<<<<<< HEAD
//       // backgroundColor: Colors.lime,
// =======
// >>>>>>> c9419eb5e09f7e6b7c0afc3ee2d666e65cb67057
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(
              '공통',
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('언어'),
                value: Text('한국어'),
                onPressed: ((context) {}),
              ),
              // SettingsTile.switchTile(
              //   title: Text('진동'),
              //   initialValue: vibration,
              //   onToggle: (value) {
              //     setState(() {
              //       vibration = !vibration;
              //     });
              //   },
              //   leading: Icon(Icons.vibration),
              // ),
            ],
          ),
          SettingsSection(
            title: Text('개인정보 수정'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.account_circle),
                title: Text('나의 정보'),
                onPressed: ((context) {}),
              ),
            ],
          ),
          SettingsSection(
            title: Text('계정'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.logout),
                title: Text('로그아웃'),
                onPressed: ((context) {}),
              ),
            ],
          ),
          SettingsSection(
            title: Text('기타'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.star),
                title: Text('앱 평가하기'),
                onPressed: ((context) {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}