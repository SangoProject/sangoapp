import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'searchPage.dart';
import 'goalPage.dart';
import 'package:sangoproject/screens/components/goalGraph.dart';
import 'libraryPage.dart';
// import 'package:sangoproject/screens/components/libraryList.dart';
// import 'package:sangoproject/screens/course_data/courseInfo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  final _authentication = FirebaseAuth.instance; // user 등록
  User? loggedUser; //? is nullable

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email); // ! is not null
      }
    } catch (e) {
      print(e);
    }
  }

  // //삭제해줘야 됨.
  // List<CourseInfo> list = [
  //   CourseInfo(course_name: '생태문화길', area_gu: '관악구', distance: '1.3km', lead_time: '30분', course_level: '1', detail_course: '제2광장 자락길(무장애숲길)입구~도토리 쉼터'),
  //   CourseInfo(course_name: '한강지천길',area_gu: '종로구', distance: '4km', lead_time: '2시간 30분', course_level: '2', detail_course: '돈의문 터~창의문'),
  //   CourseInfo(course_name: '생태문화길',area_gu: '중구', distance: '1.8km', lead_time: '1시간', course_level: '1', detail_course: '백범광장~돈의문터 강북삼성병원')
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('산책하자GO'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              // 목표
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  '오늘의 목표',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                child: ChartPage(),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GoalPage()));
                },
              ),

              // 찜목록
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '찜목록',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => LibraryPage()));
                          },
                          icon: Icon(Icons.chevron_right)
                      )
                    ],
                  )
              ),
              // Expanded(child: LibraryList(list)),
            ],
          ),
        ),
      ),
    );
  }
}