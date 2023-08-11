import 'package:flutter/material.dart';
import 'package:sangoproject/screens/searchDetailPage.dart';
import 'package:sangoproject/screens/course_data/courseInfo.dart';

class LibraryList extends StatelessWidget {
  //임의의 데이터
  @override
  Widget build(BuildContext context) {
    List<CourseInfo> list = [];
    CourseInfo tmp = CourseInfo('관악구', '1.3km', '30분', '하');
    list.add(tmp);
    tmp = CourseInfo('종로구', '4km', '2시간 30분', '중');
    list.add(tmp);
    tmp = CourseInfo('중구', '1.8km', '1시간', '하');
    list.add(tmp);

    return ListView.separated(
      itemBuilder: (context, index){
        String? area_gu = list[index].AREA_GU;
        String? distance = list[index].DISTANCE;
        String? lead_time = list[index].LEAD_TIME;
        String? course_level = list[index].COURSE_LEVEL;
        return TextButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchDetailPage()));
            },
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("자치구 : " + area_gu!),
                  Text("거리 : " + distance!),
                  Text("산책시간 : " + lead_time!),
                  Text("레벨 : " + course_level!),
                ],
              ),
            )
        );
      },
      separatorBuilder: (context, index) => Divider(
        thickness: 0.5,
        height: 0,
      ),
      itemCount: list.length,
    );
  }
}