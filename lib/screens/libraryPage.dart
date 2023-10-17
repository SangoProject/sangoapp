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
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // An Expanded widget must be a descendant of a Row, Column, or Flex,and the path from
                // the Expanded widget to its enclosing Row, Column, or Flex must contain only
                // StatelessWidgets or StatefulWidgets (not other kinds of widgets, like RenderObjectWidgets).
                Expanded(child: CourseList(toList(snapshot.data?.snapshot.value as Map<dynamic, dynamic>, uid))),
              ],
            );
          }
        },
      ),
    );
  }
}

List<dynamic> toList(dynamic map, String uid) {
  List<dynamic> values = map.values.toList();
  return values;
}