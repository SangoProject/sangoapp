import 'package:flutter/material.dart';
import 'package:sangoproject/screens/components/libraryList.dart';

class SearchResultPage extends StatefulWidget{
  String input = '';
  SearchResultPage(this.input);
  @override
  State<StatefulWidget> createState(){
    return _SearchResultPage(input);
  }
}

class _SearchResultPage extends State<SearchResultPage>{
  String location = '';
  String resultCnt = '5';
  _SearchResultPage(this.location);

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
          Expanded(child: LibraryList()),
        ],
      ),
    );
  }
}