// 산책 코스에 대한 간략한 정보를 리스트로 보여주는 위젯 (검색 결과와 찜목록에서 보이는 리스트)
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:sangoproject/screens/course/courseData.dart';
import 'package:sangoproject/screens/course/courseDetailPage.dart';
import 'package:sangoproject/screens/library/libraryButton.dart';

class CourseList extends StatelessWidget {
  List<dynamic> data; // 코스명, 시간, 거리, 난이도
  CourseList(this.data);

  @override
  Widget build(BuildContext context) {

    // 구분선이 있는 리스트를 반환
    return ListView.separated(
      itemBuilder: (context, index){
        String course_name = data[index]["course_name"]; // 코스명
        final distance = data[index]["distance"]; // 산책거리
        final lead_time = data[index]["lead_time"]; // 산책시간
        int course_level = data[index]["course_level"]; // 난이도
        int course_negative = 3 - course_level; // 최대난이도(3) - 난이도 (난이도 표시를 위한 변수)

        return TextButton(
          // 버튼을 누르면 파이어베이스에서 해당하는 산책코스의 세부 정보를 가져온 뒤 산책코스 세부 정보를 보여주는 페이지로 넘어감
            onPressed: () async {
              final realtimeDB = await FirebaseDatabase.instance.ref('DATA').orderByChild("course_name").equalTo(course_name);
              final event = await realtimeDB.once();
              final mapData = event.snapshot.value as Map<dynamic, dynamic>;
              List<CourseData> courseDetail = mapData.values.map((e) => CourseData.fromJson(e)).toList();
              courseDetail.sort((a, b) => a.cpi_idx.compareTo(b.cpi_idx));
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CourseDetailPage(data[index], courseDetail)));
            },
            // TextButton UI. 산책로에 대한 간략한 정보를 볼 수 있음.
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 산책 난이도를 표시함
                      Row(
                          children: [
                            Row(
                              children: List.generate(course_level!, (index) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              }),
                            ),
                            Row(
                              children: List.generate(course_negative!, (index) {
                                return Icon(
                                  Icons.star_border,
                                  color: Colors.amber,
                                );
                              }),
                            ),
                          ]
                      ),
                      // 산책로 찜기능을 구현한 위젯.
                      LibraryButton(data[index]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(course_name),
                    ],
                  ),
                  Text("거리 : " + distance.toString() + "km, 산책시간 : " + lead_time.toString() + "분"),
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