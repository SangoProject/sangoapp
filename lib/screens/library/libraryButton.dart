// 찜목록에 저장, 삭제할 수 있는 위젯
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LibraryButton extends StatelessWidget{
  dynamic course;
  LibraryButton(this.course);

  // 수정 필요
  String uid = "kim";
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (String value) async {
        dynamic _hasData = await FirebaseFirestore.instance.collection("user").doc(uid).collection("library")
            .where("course_name", isEqualTo: course["course_name"]).get(); // 이미 저장되어 있는 코스인지 확인하기 위해

        if (value == '저장') {
          if (_hasData.docs.isEmpty){
            // 파이어베이스에 선택한 산책 코스 추가
            FirebaseFirestore _firestore = FirebaseFirestore.instance;
            await _firestore.collection("user").doc(uid).collection("library")
                .add({
              "course_level": course["course_level"],
              "course_name": course["course_name"],
              "distance": course["distance"],
              "lead_time": course["lead_time"],
            });

            final snackBar = SnackBar(
              content: Text("코스가 저장 되었습니다."),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else {
            final snackBar = SnackBar(
              content: Text("이미 저장된 코스입니다."),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
        else if (value == '삭제') {
          if (_hasData.docs.isEmpty){
            final snackBar = SnackBar(
              content: Text("코스가 저장되어 있지 않습니다."),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else {
            // 선택한 코스를 찜목록(파이어베이스)에서 삭제함.
            for (DocumentSnapshot doc in _hasData.docs) {
              // 문서 ID 가져오기
              String documentID = doc.id;
              FirebaseFirestore _firestore = FirebaseFirestore.instance;
              _firestore.collection("user").doc(uid).collection("library").doc(documentID).delete();
            }

            final snackBar = SnackBar(
              content: Text("코스가 삭제 되었습니다."),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      itemBuilder: (BuildContext ctx) => [
        const PopupMenuItem(value: '저장', child: Text('찜목록에 저장')),
        const PopupMenuItem(value: '삭제', child: Text('찜목록에서 삭제')),
      ],
    );
  }
}