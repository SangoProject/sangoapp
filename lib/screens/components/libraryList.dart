import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sangoproject/screens/searchDetailPage.dart';
import 'package:sangoproject/screens/course_data/courseInfo.dart';
import 'package:sangoproject/screens/components/libraryButton.dart';

class LibraryList extends StatelessWidget {
  List<dynamic> data;
  LibraryList(this.data);

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
              final tmp = await FirebaseDatabase.instance.ref('DATA').orderByChild("course_name").equalTo(course_name);
              tmp.onValue.listen((DatabaseEvent event){
                Map<dynamic, dynamic> _toMap = event.snapshot.value as Map<dynamic, dynamic>;
                List<CourseInfo> _data = _toMap.values.map((e) => CourseInfo.fromJson(e)).toList();
                _data.sort((a, b) => a.cpi_idx.compareTo(b.cpi_idx));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchDetailPage(data[index], _data)));
              });
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