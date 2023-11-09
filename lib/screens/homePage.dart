import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sangoproject/screens/search/searchPage.dart';
import 'package:sangoproject/screens/goal/goal.dart';
import 'package:sangoproject/screens/libraryPage.dart';

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
          title: Text(
            '산책가자GO',
            style: TextStyle(
              fontSize: 20,
            ),
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
                // 목표
                Goal(),
                // 찜목록
                Padding(
                  padding: EdgeInsets.all(20.0),
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