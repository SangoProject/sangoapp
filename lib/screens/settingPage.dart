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
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: Text('setting page'),
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