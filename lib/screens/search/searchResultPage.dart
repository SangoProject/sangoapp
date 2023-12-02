import 'package:flutter/material.dart';

import 'package:sangoproject/screens/course/courseList.dart';

class SearchResultPage extends StatefulWidget{
  String areaGu = '';
  List<dynamic> data;
  SearchResultPage(this.areaGu, this.data);

  @override
  State<StatefulWidget> createState(){
    return _SearchResultPage(areaGu, data);
  }
}

class _SearchResultPage extends State<SearchResultPage>{
  String areaGu = '';
  List<dynamic> data;
  _SearchResultPage(this.areaGu, this.data);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName("/main"));
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          '검색 결과',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text("'$areaGu' 검색 결과 입니다."),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text("${data.length}건"),
          ),
          Expanded(child: CourseList(data)),
        ],
      ),
    );
  }
}