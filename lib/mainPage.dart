import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'screens/recordPage.dart';
import 'screens/calendarPage.dart';
import 'screens/settingPage.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _MainPage();
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin{
  TabController? controller;

  @override
  void initState(){
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: TabBarView(
          children: <Widget>[HomePage(), RecordPage(), CalendarPage(), MyPage()],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(tabs: <Tab>[
          Tab(icon: Icon(Icons.home),),
          Tab(icon: Icon(Icons.location_on),),
          Tab(icon: Icon(Icons.calendar_month),),
          Tab(icon: Icon(Icons.account_circle),)
        ],
          labelColor: Color(0xFFB7B8AD),
          indicatorColor: Color(0xFFB7B8AD),
          controller: controller,
        )
    );
  }
}