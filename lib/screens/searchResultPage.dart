import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SearchResultPage();
  }
}

class _SearchResultPage extends State<SearchResultPage>{
  String location = '???';
  String resultCnt = '5';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("'${location}' 검색 결과 입니다."),
          Text("${resultCnt}건"),
        ],
      ),
    );
  }
}