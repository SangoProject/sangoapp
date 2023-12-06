// 찜목록에 저장, 삭제할 수 있는 위젯
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LibraryButton extends StatelessWidget{
  // 사용자 id 불러와야 됨.
  final String uid = "kim";
  final dynamic course; // 한 개의 산책코스(코스명, 산책시간, 산책거리, 난이도)가 저장되어 있는 변수
  LibraryButton(this.course);

  @override
  Widget build(BuildContext context){
    // 찜목록에 추가, 찜목록에서 삭제 팝업을 띄움.
    return PopupMenuButton(
      onSelected: (String value) async {
        // 선택한 코스를 찜목록(파이어베이스)에 추가함.
        FirebaseDatabase realtimeDB = FirebaseDatabase.instance;
        if(value == '추가') {
          realtimeDB.ref("USERS").child(uid).child("LIBRARY").child(course["course_name"]).set({
            "course_level": course["course_level"],
            "course_name": course["course_name"],
            "distance": course["distance"],
            "lead_time": course["lead_time"],
          });
        }
        // 선택한 코스를 찜목록(파이어베이스)에서 삭제함.
        else if(value == '삭제') {
          realtimeDB.ref("USERS").child(uid).child("LIBRARY").child(course["course_name"]).remove();
        }
        else{
          print("ERROR");
        }
        // 추가 또는 삭제 되면 snackBar를 띄움.
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