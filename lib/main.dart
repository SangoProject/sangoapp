// 앱의 기본적인 정보를 세팅해둔 파일
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:sangoproject/screens/googleLogin.dart';
import 'package:sangoproject/main_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // 화면 세로로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
      // 상단에 debug가 뜨지 않도록 함.
      debugShowCheckedModeBanner: false,
      title: 'SanGo app', // 산책하자고로 이름을 바꿈
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primarySwatch: Colors.lime,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      // 루트 설정 정보
      initialRoute: '/main',
      routes: {
        '/' : (context) => GoogleLogin(),
        '/main': (context) => MainPage(),
      },
    );
  }
}