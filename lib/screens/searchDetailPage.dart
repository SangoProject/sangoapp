import 'package:flutter/material.dart';
import 'package:sangoproject/screens/course_data/courseInfo.dart';

class SearchDetailPage extends StatefulWidget{
  CourseInfo data;
  SearchDetailPage(this.data);
  @override
  State<StatefulWidget> createState(){
    return _SearchDetailPage(data);
  }
}

class _SearchDetailPage extends State<SearchDetailPage>{
  CourseInfo data;
  _SearchDetailPage(this.data);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 세부 정보'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("자치구 : " + data.area_gu),
          Text("난이도 : " + data.course_level),
          Text("거리 : " + data.distance),
          Text("산책시간 : " + data.lead_time),
          Text("세부 코스 : " + data.detail_course),
        ],
      ),
    );
  }
}