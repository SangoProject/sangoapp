import 'package:flutter/material.dart';
import 'package:sangoproject/screens/components/libraryList.dart';
import 'package:sangoproject/screens/course_data/courseInfo.dart';

import 'homePage.dart';

class SearchResultPage extends StatefulWidget{
  String input = '';
  List<dynamic> data;
  SearchResultPage(this.input, this.data);

  @override
  State<StatefulWidget> createState(){
    return _SearchResultPage(input, data);
  }
}

class _SearchResultPage extends State<SearchResultPage>{
  String location = '';
  List<dynamic> data;
  _SearchResultPage(this.location, this.data);
  late int resultCnt = data.length;

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
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text("'$location' 검색 결과 입니다."),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text("$resultCnt건"),
          ),
          Expanded(child: LibraryList(data)),
        ],
      ),
    );
  }
}