import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:sangoproject/screens/course/courseList.dart';

class LibraryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _LibraryPage();
  }
}

class _LibraryPage extends State<LibraryPage>{
  String uid = 'kim';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('찜목록'),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref("USERS").child(uid).child("LIBRARY").onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Error: ${snapshot.hasError}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
          else {
            dynamic libraryData = snapshot.data?.snapshot.value;
            if (libraryData == null) {
              return Center(
                child: Text("저장한 코스가 없습니다."),
              );
            }
            else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // An Expanded widget must be a descendant of a Row, Column, or Flex,and the path from
                  // the Expanded widget to its enclosing Row, Column, or Flex must contain only
                  // StatelessWidgets or StatefulWidgets (not other kinds of widgets, like RenderObjectWidgets).
                  Expanded(child: CourseList(toList(libraryData as Map<dynamic, dynamic>))),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

List<dynamic> toList(dynamic map) {
  List<dynamic> values = map.values.toList();
  return values;
}