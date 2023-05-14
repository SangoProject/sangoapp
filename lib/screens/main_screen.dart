import 'package:flutter/material.dart';
import 'package:sangoproject/config/palette.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background.jpg'),
                      fit: BoxFit.fill
                  )
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 80, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: const TextSpan(
                            text: 'Welcome',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 25,
                              color: Colors.lightGreen
                            ),
                            children: [
                              TextSpan(
                                text: ' to Sango App',
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize  : 25,
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold,
                                ),
                              )
                            ]
                          ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text('Signup to continue',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Palette.textColor1,
                      ))
                    ],
                  )
                ),
              )
          ),
          Positioned(
              top: 180,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                height: 280.0,
                width: MediaQuery.of(context).size.width-40, // device 마다 자동으로 적용
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isSignupScreen = false;
                            });
                        },
                          child: Column(
                            children: [
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: !isSignupScreen ? Palette.activeColor
                                    : Palette.textColor1 // 선택시 색상 변경
                                ),
                              ),
                              if(!isSignupScreen)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.black12,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isSignupScreen = true; // 사용자가 signup 선택함
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'SIGNUP',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen ? Palette.activeColor :
                                        Palette.textColor1
                                ),
                              ),
                              if(isSignupScreen)
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.black12,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Palette.iconColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Palette.textColor1
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Palette.textColor1
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35.0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}