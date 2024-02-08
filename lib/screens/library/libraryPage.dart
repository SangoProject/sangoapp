// 찜한 산책 코스를 가져와서 보여주는 페이지
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sangoproject/screens/course/courseList.dart';

class LibraryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _LibraryPage();
  }
}

class _LibraryPage extends State<LibraryPage>{
  // 수정필요
  String uid = 'kim';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '찜목록',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        // 파이어베이스에서 찜목록을 불러옴.
        stream: FirebaseFirestore.instance.collection("user").doc(uid).collection("library").snapshots(),
        builder: (context, snapshot) {
          // 불러오지 못 한다면 CircularProgressIndicator을 띄음.
          //snapshot.connectionState == ConnectionState.waiting
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // 에러가 났다면 에러 메시지를 띄움.
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Error: ${snapshot.hasError}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
          // 데이터를 정상적으로 불러왔을 경우.
          else {
            dynamic libraryData = snapshot.data?.docs;
            // 데이터가 없다면 "저장한 코스가 없습니다."를 띄움.
            if (libraryData.isEmpty) {
              return Center(
                child: Text("저장한 코스가 없습니다."),
              );
            }
            // 데이터가 있다면 CourseList를 띄움.
            else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: CourseList(toList(libraryData))),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

// 리스트 형식으로 바꾸어 줌.
List<dynamic> toList(dynamic data) {
  List<dynamic> values = data.map((snapshot) => snapshot.data()).toList();
  return values;
}