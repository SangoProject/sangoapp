import 'package:flutter/material.dart';

class SearchDetailPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SearchDetailPage();
  }
}

class _SearchDetailPage extends State<SearchDetailPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 세부 정보'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('search detail page'),
        ],
      ),
    );
  }
}