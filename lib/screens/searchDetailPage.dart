import 'package:flutter/material.dart';
import 'package:sangoproject/screens/course_data/courseInfo.dart';

class SearchDetailPage extends StatefulWidget{
  dynamic data; // 코스명, 시간, 거리, 난이도
  dynamic detail; // 포인트번호, 포인트명칭, x좌표, y좌표 (courseInfo.dart 참고)
  SearchDetailPage(this.data, this.detail);
  @override
  State<StatefulWidget> createState(){
    return _SearchDetailPage(data, detail);
  }
}

class _SearchDetailPage extends State<SearchDetailPage>{
  dynamic data;
  dynamic detail;
  _SearchDetailPage(this.data, this.detail);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 세부 정보'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(data["course_name"]),
          Text("산책시간: " + data["lead_time"].toString() + "분"),
          Text("산책거리: " + data["distance"].toString() + "km"),
          Text("난이도: " + data["course_level"].toString()),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.swipe_down_alt),
                      Text(detail[index].cpi_idx.toString() + " " + detail[index].cpi_name),
                    ],
                  ),
                );
              },
              itemCount: detail.length,
            ),
          )
        ],
      ),
    );
  }
}