import 'package:flutter/material.dart'; //기본 패키지
import 'package:sangoproject/screens/main_screen.dart'; // 메인(로그인, 회원가입) 화면 패키지
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // flutter 비동기 method 사용위해 초기화 -> flutter에서 firebase 사용을 위해
  Firebase.initializeApp(); // firebase 이용 필수 속성
  runApp(MyApp());
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