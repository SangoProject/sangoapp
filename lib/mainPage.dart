// 앱의 기본적인 화면 구조를 작성해둔 파일
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sangoproject/screens/homePage.dart';
import 'package:sangoproject/screens/record/recordPage.dart';
import 'package:sangoproject/screens/calendar/calendarPage.dart';
import 'package:sangoproject/screens/setting/settingPage.dart';
import 'package:sangoproject/screens/terms.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState()=> _MainPage();
}

class _MainPage extends State<MainPage> {
  int currentIndex = 0; // 네비게이션 바에서 보이는 화면 선택을 위한 변수
  String userId = FirebaseAuth.instance.currentUser!.email!;

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        else {
          if (snapshot.data?.get('terms') == true) {
            // currentIndex에 해당하는 화면을 보여줌.
            return Scaffold(
              // 키보드 오버플로우를 해결을 위해
              resizeToAvoidBottomInset: false,
              // 하단의 네비게이션 바
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                // 네비게이션 바를 선택하면 해당 index로 currentIndex가 바뀜.
                onTap: (index){
                  setState(() {
                    currentIndex = index;
                  });
                },
                // 네비게이션바 UI
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.location_on),
                    label: 'record',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: 'calendar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'settings',
                  ),
                ],
                selectedItemColor: Color(0xFF436726),
                unselectedItemColor: Color(0xFFB6C7D1),
                // item label 보여줄 것인지
                showSelectedLabels: false,
                showUnselectedLabels: false,
                // fixed : item size 고정, shifting : 선택된 item 확대
                type: BottomNavigationBarType.fixed,
              ),
              body: Center(
                // currentIndex에 해당하는 화면을 보여줌.
                child: bodyItem.elementAt(currentIndex),
              ),
            );
          }
          else {
            return Terms();
          }
        }
      },
    );
  }
  List<Widget> bodyItem = <Widget>[
    HomePage(), // 인덱스 0번. 홈화면
    RecordPage(), // 인덱스 1번. 기록 화면
    CalendarPage(), // 인덱스 2번. 캘린더 화면
    SettingPage(), // 인덱스 3번. 설정 화면
  ];
}