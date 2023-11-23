import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sangoproject/screens/search/searchPage.dart';
import 'package:sangoproject/screens/goal/goal.dart';
import 'package:sangoproject/screens/libraryPage.dart';

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
  final _authentication = FirebaseAuth.instance; // user 등록
  User? loggedUser; //? is nullable

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    _requestLocationPermission();
  }

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
        print(loggedUser!.email); // ! is not null
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              // IconButton(
              //   onPressed: () {
              //   HomePage();
              //   },
              //   icon: Image.asset(
              //     'images/thin_logo.png',
              //     height: 28,
              //     width: 28,
              //   ),
              // ),
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
                // 재난 공지
                Disaster(),
                // 목표, 산책통계
                Goal(),
                // 찜목록
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Palette.green1,
                          borderRadius: BorderRadius.circular(12),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                          //     spreadRadius: 2, // 그림자 확장 범위
                          //     blurRadius: 5, // 그림자 흐림 범위
                          //     offset: Offset(0, 3), // 그림자 위치 (x, y)
                          //   ),
                          // ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: const [
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
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => LibraryPage()));
                                },
                                icon: Icon(Icons.chevron_right)
                            )
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
      ),
    );
  }
}