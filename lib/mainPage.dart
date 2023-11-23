import 'package:flutter/material.dart';

import 'package:sangoproject/screens/homePage.dart';
import 'package:sangoproject/screens/record/recordPage.dart';
import 'package:sangoproject/screens/calendar/calendarPage.dart';
import 'package:sangoproject/screens/settingPage.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _MainPage();
}

class _MainPage extends State<MainPage> {
  int current_index = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_index,
        onTap: (index){
          setState(() {
            current_index = index;
          });
        },
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
        child: body_item.elementAt(current_index),
      ),
    );
  }
  List<Widget> body_item = <Widget>[
    HomePage(),
    RecordPage(),
    CalendarPage(),
    SettingPage(),
  ];
}