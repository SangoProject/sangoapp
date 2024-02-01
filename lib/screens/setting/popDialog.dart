// settingPage의 로그아웃, 회원탈퇴 함수 및 Dialog
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../googleLogin.dart';

// 로그아웃 함수
void _logout(BuildContext context) async {
  final googleSignIn = GoogleSignIn();
  await FirebaseAuth.instance.signOut();
  await googleSignIn.signOut();
  // GoogleLogin 페이지로 이동
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => GoogleLogin()),
  );
}

// 회원탈퇴 함수
void deleteCurrentUser(BuildContext context) async {
  final googleSignIn = GoogleSignIn();
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // 사용자 삭제
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GoogleLogin()),
      );
      await user.delete();
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      print('User account deleted.');
    } else {
      print('No user signed in.');
    }
  } catch (e) {
    print('Error deleting user: $e');
  }
}

// 로그아웃 팝업 띄우기
Future<void> showLogoutDialog(BuildContext context, int i) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('로그아웃'),
        content: Text('로그아웃 하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 닫기
            },
            child: Text('아니오'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 닫기
              _logout(context); // 로그아웃 수행
            },
            child: Text('예'),
          ),
        ],
      );
    },
  );
}

// 회원탈퇴 팝업 띄우기
Future<void> showUserDeleteDialog(BuildContext context, int i) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('회원탈퇴'),
        content: Text('회원탈퇴 하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 닫기
            },
            child: Text('아니오'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 닫기
              deleteCurrentUser(context); // 회원탈퇴 수행
            },
            child: Text('예'),
          ),
        ],
      );
    },
  );
}