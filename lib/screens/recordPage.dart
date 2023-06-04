import 'package:flutter/material.dart';

class RecordPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _RecordPage();
  }
}

class _RecordPage extends State<RecordPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('record page'),
      ),
    );
  }
}