import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('search page'),
      ),
    );
  }
}