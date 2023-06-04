import 'package:flutter/material.dart';

class GoalPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _GoalPage();
  }
}

class _GoalPage extends State<GoalPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('goal page'),
      ),
    );
  }
}