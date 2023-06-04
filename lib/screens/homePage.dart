import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'searchPage.dart';
import 'goalPage.dart';
import 'libraryPage.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
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

  void getCurrentUser(){
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email); // ! is not null
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('산책하자GO'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
            icon: Icon(Icons.search),)
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              // 목표
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Text('오늘의 목표'),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoalPage()));
                  },
                ),
              ),
              // 찜목록
              Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Text('찜목록'),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LibraryPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}