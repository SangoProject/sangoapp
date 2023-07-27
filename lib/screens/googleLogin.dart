import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sangoproject/screens/homePage.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final _googleSignIn = GoogleSignIn();
                final googleAccount = await _googleSignIn.signIn();

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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      print('an error occured $e');
                    } catch (e) {
                      print('an error occured $e');
                    }
                  } else
                    print('an error occured');
                } else
                  print('an error occured');
              }, child: Text('+ Google'),
            )
          ],
        ),
      ),
    );
  }
}
