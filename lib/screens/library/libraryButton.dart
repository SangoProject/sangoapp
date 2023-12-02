import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LibraryButton extends StatelessWidget{
  // 사용자 id 불러와야 됨.
  String uid = "kim";
  dynamic course;
  LibraryButton(this.course);

  @override
  Widget build(BuildContext context){
    return PopupMenuButton(
      onSelected: (String value) async {
        FirebaseDatabase realtimeDB = FirebaseDatabase.instance;
        if(value == '추가') {
          realtimeDB.ref("USERS").child(uid).child("LIBRARY").child(course["course_name"]).set({
            "course_level": course["course_level"],
            "course_name": course["course_name"],
            "distance": course["distance"],
            "lead_time": course["lead_time"],
          });
        }
        else if(value == '삭제') {
          realtimeDB.ref("USERS").child(uid).child("LIBRARY").child(course["course_name"]).remove();
        }
        else{
          print("ERROR");
        }
        final snackBar = SnackBar(
          content: Text("$value되었습니다."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      itemBuilder: (BuildContext ctx) => [
        const PopupMenuItem(value: '추가', child: Text('찜목록에 추가')),
        const PopupMenuItem(value: '삭제', child: Text('찜목록에서 삭제'))
      ],
    );
  }
}