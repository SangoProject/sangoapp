import 'package:flutter/material.dart'; //기본 패키지
import 'package:sangoproject/screens/main_screen.dart'; // 메인(로그인, 회원가입) 화면 패키지
import 'screens/mainPage.dart';
import 'screens/recordPage.dart';
import 'screens/calendarPage.dart';
import 'screens/myPage.dart'; // tap bar 4개 dart 파일 import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // flutter 비동기 method 사용위해 초기화 -> flutter에서 firebase 사용을 위해
  Firebase.initializeApp();
  runApp(MyApp()); // 기존에 MyApp 앞에 const 있었는데 뺌
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // main 화면의 로그인 기능
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SanGo app', // 산책하자고로 이름을 바꿈
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primarySwatch: Colors.lime,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginSignupScreen(),
      // title: '로그인 / 회원가입' 어떻게 넣지
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('TabBar Example'),
//         ),
//         body: TabBarView(
//           children: <Widget>[MainPage(), RecordPage(), CalendarPage(), MyPage()],
//           controller: controller,
//         ),
//         bottomNavigationBar: TabBar(tabs: <Tab>[
//           Tab(icon: Icon(Icons.home, color: Color(0xFFB7B8AD)),),
//           Tab(icon: Icon(Icons.location_on, color: Color(0xFFB7B8AD)),),
//           Tab(icon: Icon(Icons.calendar_month, color: Color(0xFFB7B8AD)),),
//           Tab(icon: Icon(Icons.account_circle, color: Color(0xFFB7B8AD)),)
//         ], controller: controller,
//         )
//     );
//   }
//
//   TabController? controller;
//
//   @override
//   void initState(){
//     super.initState();
//     controller = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void dispose(){
//     controller?.dispose();
//     super.dispose();
//   }
// }