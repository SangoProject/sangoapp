// 필터링된 검색 결과를 보여주는 페이지
import 'package:flutter/material.dart';

import 'package:sangoproject/screens/course/courseList.dart';
import 'package:sangoproject/mainPage.dart';

class SearchResultPage extends StatefulWidget{
  String areaGu = '';
  List<dynamic> data;
  SearchResultPage(this.areaGu, this.data, {super.key});

  @override
  State<StatefulWidget> createState(){
    return _SearchResultPage(areaGu, data);
  }
}

class _SearchResultPage extends State<SearchResultPage>{
  String areaGu = ''; // 선택된 위치 정보 변수
  List<dynamic> data; // 검색된 산책코스가 들어가 있는 변수
  _SearchResultPage(this.areaGu, this.data);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        // 버튼을 누르면 main으로 이동.
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
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
            child: Text("${data.length}건"), // 검색 결과 개수
          ),
          // 검색 결과에 대한 courseList 띄우기
          Expanded(child: CourseList(data)),
        ],
      ),
    );
  }
}