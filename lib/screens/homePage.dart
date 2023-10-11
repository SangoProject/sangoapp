import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'searchPage.dart';
import 'goalPage.dart';
import 'package:sangoproject/screens/components/goalGraph.dart';
import 'package:sangoproject/screens/components/libraryList.dart';
import 'package:sangoproject/screens/statistics.dart';
import 'libraryPage.dart';
import 'package:firebase_database/firebase_database.dart';

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
  // 유저id 가져와야 됨
  String uid = 'kim';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getGoal();
  }

  void getGoal() async {
    final _top = await FirebaseDatabase.instance.ref("USERS").child(uid).child("GOAL");
    final event = await _top.once();
    final goalData = event.snapshot.value ?? -1;
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
              GoalPage(),
              OutlinedButton(
                child: Text("목표 보기"),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Statistics())
                  );
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
                          onPressed: () async {
                            final tmp = await FirebaseDatabase.instance.ref('USERS').child(uid).child('LIBRARY');
                            tmp.onValue.listen((DatabaseEvent event){
                              List<dynamic> userLibrary =event.snapshot.value as List<dynamic>;
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => LibraryPage(userLibrary)));
                            });
                          },
                          icon: Icon(Icons.chevron_right)
                      )
                    ],
                  )
              ),
              //Expanded(child: LibraryList(userData as List)),
            ],
          ),
        ),
      ),
    );
  }
}