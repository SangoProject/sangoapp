// 홈 화면 구조를 작성해둔 파일
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sangoproject/screens/search/searchPage.dart';
import 'package:sangoproject/screens/goal/goal.dart';
import 'package:sangoproject/screens/library/libraryPage.dart';
import 'package:sangoproject/screens/statistics/statisticsButton.dart';
import '../config/palette.dart';
import 'disaster/disasterBanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  /*final _authentication = FirebaseAuth.instance; // user 등록
  User? loggedUser; // 로그인 여부 판단

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    getCurrentUser();
  }

  // 위치 권한 허용 여부 확인
  Future<void> _requestLocationPermission() async {
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    // 뒤로가기 버튼을 눌러도 뒤로 가지지 않도록 설정
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // 키보드 오버플로우를 해결을 위해
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // 상단에 나타나는 뒤로가기 버튼 제거
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  '산책가자GO',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Inklipquid',
                  ),
                ),
              ),
            ],
          ),
          // 검색 버튼 (아이콘 버튼). 누르면 검색 페이지(SearchPage)로 넘어감.
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
        body: Center(
          child: Column(
            children: <Widget>[
              // 재난 공지 배너
              Disaster(),

              // 목표
              Goal(),

              // 산책 통계
              StatisticsButton(),

              // 찜목록 버튼. 버튼을 누르면 찜목록을 볼 수 있는 페이지로 넘어감.
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Stack(
                  children: [
                    Container(
                      height: 80,
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Palette.green1,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  '찜목록',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.view_list_rounded,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LibraryPage()),
                          );
                        },
                        splashColor: Colors.grey,
                        highlightColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










// 버튼으로 데이터 확인
/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sangoproject/screens/search/searchPage.dart';
import 'package:sangoproject/screens/goal/goal.dart';
import 'package:sangoproject/screens/library/libraryPage.dart';
import 'package:sangoproject/screens/statistics/statisticsButton.dart';
import 'package:sangoproject/settingSP.dart';

import '../config/palette.dart';
import 'disaster/disasterBanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 뒤로가기 버튼을 눌러도 뒤로 가지지 않도록 설정
    return Scaffold(
      // 키보드 오버플로우를 해결을 위해
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // 상단에 나타나는 뒤로가기 버튼 제거
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '산책가자GO',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Inklipquid',
                ),
              ),
            ),
          ],
        ),
        // 검색 버튼 (아이콘 버튼). 누르면 검색 페이지(SearchPage)로 넘어감.
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
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  final data = await loadGoal();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('goal : $data')), // 저장 완료 메시지 출력
                  );
                },
                child: Text('저장된 goal 값 보기')
            ),
            ElevatedButton(
                onPressed: () async {
                  final data = await loadTerms();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('terms : $data')), // 저장 완료 메시지 출력
                  );
                },
                child: Text('저장된 terms 값 보기')
            ),
            ElevatedButton(
                onPressed: () async {
                  final data = await saveTerms(false);
                },
                child: Text('false로 저장')
            ),
            ElevatedButton(
                onPressed: () async {
                  final data = await saveTerms(true);
                },
                child: Text('true로 저장')
            ),
          ]
        ),
      ),
    );
  }
}*/