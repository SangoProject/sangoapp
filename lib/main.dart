import 'package:flutter/material.dart'; //기본 패키지
import 'package:sangoproject/screens/main_screen.dart'; // 메인(로그인 기능) 화면 패키지
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp()); // 기존에 MyApp 앞에 const 있었는데 뺌
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // main 화면의 로그인 기능
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanGo app', // 산책하자고로 이름을 바꿈
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const LoginSignupScreen(), // title: '로그인 / 회원가입' 어떻게 넣지
    );
  }
}
