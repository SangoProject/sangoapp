import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:sangoproject/screens/course/courseData.dart';
import 'package:sangoproject/screens/course/courseDetailPage.dart';
import 'package:sangoproject/screens/library/libraryButton.dart';

class CourseList extends StatelessWidget {
  List<dynamic> data;
  CourseList(this.data);

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemBuilder: (context, index){
        String course_name = data[index]["course_name"];
        final distance = data[index]["distance"];
        final lead_time = data[index]["lead_time"];
        int course_level = data[index]["course_level"];
        int course_negative = 3 - course_level;

        return TextButton(
            onPressed: () async {
              final realtimeDB = await FirebaseDatabase.instance.ref('DATA').orderByChild("course_name").equalTo(course_name);
              final event = await realtimeDB.once();
              final mapData = event.snapshot.value as Map<dynamic, dynamic>;
              List<CourseData> courseDetail = mapData.values.map((e) => CourseData.fromJson(e)).toList();
              courseDetail.sort((a, b) => a.cpi_idx.compareTo(b.cpi_idx));
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CourseDetailPage(data[index], courseDetail)));
            },
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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