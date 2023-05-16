//이용하지 않는 파일임 참고만 하자

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            providers: providers,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/profile');
              }),
            ],
          );
        },
        // '/profile': (context) {
        //   return ProfileScreen(
        //     providers: providers,
        //     actions: [
        //       SignedOutAction((context) {
        //         Navigator.pushReplacementNamed(context, '/sign-in');
        //       }),
        //     ],
        //   );
        // },
      },
    );
  }
}