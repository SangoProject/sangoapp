// 찜한 산책 코스를 가져와서 보여주는 페이지
import 'package:flutter/material.dart';

import 'package:sangoproject/crud/crudSqlite.dart';
import 'package:sangoproject/screens/course/courseList.dart';

class LibraryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _LibraryPage();
  }
}

class _LibraryPage extends State<LibraryPage>{
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    loadData().then((data) {
      setState(() {
        dataList = data;
      });
    });
  }

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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text("${dataList.length}건"), // 검색 결과 개수
                ),
                IconButton(
                  onPressed: () async {
                    await loadData().then((data) {
                      setState(() {
                        dataList = data;
                      });
                    });
                  },
                  icon: Icon(Icons.refresh),
                )
              ],
            ),
            Expanded(child: CourseList(dataList)),
          ],
        )
      )
    );
  }
}