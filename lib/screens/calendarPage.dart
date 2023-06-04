import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _CalendarPage();
  }
}

class _CalendarPage extends State<CalendarPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('calendar page'),
      ),
    );
  }
}