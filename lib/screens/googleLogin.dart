// 구글 로그인 기능에 대한 파일
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sangoproject/config/palette.dart';
import 'package:sangoproject/mainPage.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.logoColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/logo.png'),
              width: MediaQuery.of(context).size.height * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.cover,
            ),
            ElevatedButton(
              onPressed: () async {
                final googleSignIn = GoogleSignIn();
                final googleAccount = await googleSignIn.signIn();

                if (googleAccount != null) {
                  final googleAuth = await googleAccount.authentication;

                  if(googleAuth.accessToken != null &&
                     googleAuth.idToken != null) {
                    try{
                      await FirebaseAuth.instance
                          .signInWithCredential(GoogleAuthProvider.credential(
                        idToken: googleAuth.idToken,
                        accessToken: googleAuth.accessToken,
                      ));
                      print('success registered');

                      await setTermsAndGoal();

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      print('an error occured $e');
                    } catch (e) {
                      print('an error occured $e');
                    }
                  } else {
                    print('an error occured');
                  }
                } else {
                  print('an error occured');
                }
              }, child: Text('+ Google'),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> setTermsAndGoal() async {
  // Firestore 인스턴스 생성
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.email!;

  DocumentSnapshot<Map<String, dynamic>> userDocument =
  await firestore.collection('users').doc(userId).get();

  if (!userDocument.exists || userDocument.data() == null) {
    // 사용자 문서가 없거나 데이터가 null인 경우
    await firestore.collection('users').doc(userId).set({
      'terms': false,
      'goal': 5,
    });
  } else if (!userDocument.data()!.containsKey('terms') || !userDocument.data()!.containsKey('goal')) {
    // terms 또는 goal 필드가 없는 경우
    await firestore.collection('users').doc(userId).update({
      'terms': false,
      'goal': 5,
    });
  }
}
