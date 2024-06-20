// 찜목록에 저장, 삭제할 수 있는 위젯
import 'package:flutter/material.dart';
import 'package:sangoproject/crud/crudSqlite.dart';

class LibraryButton extends StatelessWidget{
  dynamic course;
  LibraryButton(this.course);
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (String value) async {
        final db = await initDB();
        List<Map<String, Object?>> data = await db.query(
          'library',
          where: 'course_name = ?',
          whereArgs: [course["course_name"]]
        );

        if (value == '저장') {
          if (data.isEmpty) {
            await addData(
                course["course_level"],
                course["course_name"],
                course["distance"],
                course["lead_time"]
            );

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
          if (data.isEmpty) {
            final snackBar = SnackBar(
              content: Text("코스가 저장되어 있지 않습니다."),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else {
            deleteData(course["course_name"]);

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