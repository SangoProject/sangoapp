import 'package:flutter/material.dart'; //기본 패키지
import 'package:sangoproject/screens/loginsignupPage.dart'; // 메인(로그인, 회원가입) 화면 패키지
import 'mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // flutter 비동기 method 사용위해 초기화 -> flutter에서 firebase 사용을 위해
  await Firebase.initializeApp(); // firebase 이용 초기화 method
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
      initialRoute: '/',
      routes: {
        '/': (context) => LoginSignupScreen(),
        '/main': (context) => MainPage(),
      },

      ////////////////home: const LoginSignupScreen(),

      // StreamBuilder<User>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      // )
      // title: '로그인 / 회원가입' 어떻게 넣지
    );
  }
}