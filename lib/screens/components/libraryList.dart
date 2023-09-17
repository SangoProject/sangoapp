import 'package:flutter/material.dart';
import 'package:sangoproject/screens/searchDetailPage.dart';
import 'package:sangoproject/screens/course_data/courseInfo.dart';

class LibraryList extends StatelessWidget {
  List<CourseInfo> data;
  LibraryList(this.data);
  //임의의 데이터

  @override
  Widget build(BuildContext context) {
    // List<CourseInfo> list = [];
    // CourseInfo tmp = CourseInfo('관악구', '1.3km', '30분', 1);
    // list.add(tmp);
    // tmp = CourseInfo('종로구', '4km', '2시간 30분', 2);
    // list.add(tmp);
    // tmp = CourseInfo('중구', '1.8km', '1시간', 1);
    // list.add(tmp);

    return ListView.separated(
      itemBuilder: (context, index){
        final distance = data[index].distance;   // 이동 거리
        final lead_time = data[index].lead_time; // 소요 시간
        final course_level = int.parse(data[index].course_level); // 난이도
        final course_negative = 3 - course_level;

        String detailCourse = data[index].detail_course;
        List<String> courseParts = detailCourse.split("~");

        String firstString = ''; // 가장 앞의 문자열을 저장할 변수
        String lastString = '';  // 가장 뒤의 문자열을 저장할 변수

        if (courseParts.length >= 2) {
          firstString = courseParts.first;
          lastString = courseParts.last;
        }

        return TextButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchDetailPage(data[index])));
            },
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Row(
                        children: List.generate(course_level!, (index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber, // 노란색 별 아이콘
                          );
                        }),
                      ),
                      Row(
                        children: List.generate(course_negative!, (index) {
                          return Icon(
                            Icons.star_border,
                            color: Colors.amber, // 노란색 별 아이콘
                          );
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(firstString),
                      Icon(Icons.arrow_forward),
                      Text(lastString),
                    ],
                  ),
                  Text("거리 : " + distance + ", 산책시간 : " + lead_time),
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
      itemCount: data.length,
    );
  }
}