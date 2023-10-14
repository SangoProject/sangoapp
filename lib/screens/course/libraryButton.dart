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
        final top = await getIdx(uid);
        if(value == '추가') {
          FirebaseDatabase _realtime = FirebaseDatabase.instance;
          _realtime.ref("USERS").child(uid).child("LIBRARY").child(top.toString()).set({
            "idx": top,
            "course_level": course["course_level"],
            "course_name": course["course_name"],
            "distance": course["distance"],
            "lead_time": course["lead_time"],
          });

          FirebaseDatabase _updateIdx = FirebaseDatabase.instance;
          _updateIdx.ref("USERS").child(uid).update({"library_top": top + 1});
        }
        else if(value == '삭제') {
          int lastIdx = top - 1;
          if(top > 0){
            int removeIdx = course["idx"];
            // top 데이터 가져오기
            final tmp = await FirebaseDatabase.instance.ref("USERS").child(uid).child("LIBRARY").child(lastIdx.toString());
            final event = await tmp.once();
            final topData = await event.snapshot.value;
            // 데이터 덮어쓰기
            FirebaseDatabase _updateData = FirebaseDatabase.instance;
            _updateData.ref("USERS").child(uid).child("LIBRARY").update({"$removeIdx": topData});
            _updateData.ref("USERS").child(uid).child("LIBRARY").child(removeIdx.toString()).update({"idx": removeIdx});
            // top 데이터 삭제
            final rem = await FirebaseDatabase.instance.ref().child("USERS/$uid/LIBRARY/$lastIdx").remove();
            // top 수정
            FirebaseDatabase _updateIdx = FirebaseDatabase.instance;
            _updateIdx.ref("USERS").child(uid).update({"library_top": top - 1});

            // Navigator.pushReplacement(context,
            //   MaterialPageRoute(builder: (context) => ()),
            // );
          }
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

Future<dynamic> getIdx(String uid) async {
  final _top = await FirebaseDatabase.instance.ref("USERS").child(uid).child("library_top");
  final event = await _top.once(); // 한 번만 데이터베이스에서 값을 가져옵니다.
  final top = event.snapshot.value ?? -1; // 값이 없을 경우 -1을 반환합니다.
  return top;
}