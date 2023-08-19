import 'package:flutter/material.dart';
import 'package:sangoproject/screens/searchDetailPage.dart';
import 'package:sangoproject/screens/course_data/courseInfo.dart';

class LibraryList extends StatelessWidget {
  //임의의 데이터
  @override
  Widget build(BuildContext context) {
    List<CourseInfo> list = [];
    CourseInfo tmp = CourseInfo('관악구', '1.3km', '30분', 1);
    list.add(tmp);
    tmp = CourseInfo('종로구', '4km', '2시간 30분', 2);
    list.add(tmp);
    tmp = CourseInfo('중구', '1.8km', '1시간', 1);
    list.add(tmp);

    return ListView.separated(
      itemBuilder: (context, index){
        String? area_gu = list[index].AREA_GU;
        String? distance = list[index].DISTANCE;
        String? lead_time = list[index].LEAD_TIME;
        int? course_level = list[index].COURSE_LEVEL;
        return TextButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchDetailPage()));
            },
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star_border)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(area_gu!),
                      Icon(Icons.arrow_forward),
                      Text(area_gu!),
                    ],
                  ),
                  Text("거리 : " + distance! + ", 산책시간 : " + lead_time!),
                  // for(int i = 0; i < course_level!; i++){
                  //
                  // }
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