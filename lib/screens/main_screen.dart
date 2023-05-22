import 'package:flutter/material.dart';
import 'package:sangoproject/config/palette.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation(){
    final isValid = _formKey.currentState!.validate(); // !는 not null(null test)
    // validate가 적용된 textformfield 모두 적용
    if(isValid){
      _formKey.currentState!.save();
    }
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus(); // 아무곳이나 클릭하면 키보드 없어짐
        },
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 800,
                  decoration: BoxDecoration(
                    color: Colors.lime.withOpacity(0.1)
                    // gradient: LinearGradient(
                    //     colors: const [
                    //       Colors.green,
                    //       Colors.white
                    //     ],
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter
                    // )
                    // image: DecorationImage(
                    //     image: AssetImage('images/background.jpg'),
                    //     fit: BoxFit.fill
                    // )
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 80, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                              // text: '산책하자Go',
                              // style: TextStyle(
                              //   letterSpacing: 1.0,
                              //   fontSize: 24,
                              //   color: Colors.black54,
                              //   fontWeight: FontWeight.bold,
                              // ),
                              children: [
                                TextSpan(
                                  text: isSignupScreen ? ' 회원가입하기' : ' 로그인하기',
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize  : 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]
                            ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        // Text(
                        //   isSignupScreen ? 'Signup to continue' : 'Signin to continue',
                        //   style: TextStyle(
                        //   letterSpacing: 1.0,
                        //   color: Palette.textColor1,
                        // ))
                      ],
                    )
                  ),
                )
            ),
            // 배경
            AnimatedPositioned( // 위치 변화를 위해
                top: 180,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: AnimatedContainer( // container의 크기도 변하므로
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: const EdgeInsets.all(20.0),
                  height: isSignupScreen ? 280.0 : 250.0,
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
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
                                    'Login',
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
                                    '회원가입',
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
                        if(isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          // textformfield를 container 안에 배치시켜 이러한 조정을 가능하게 한다.
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: ValueKey(1),
                                  validator: (value){
                                    if(value!.isEmpty || value.length < 4){
                                      return '아이디는 최소 5글자 이상이어야합니다.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userName = value!;
                                  },
                                  onChanged: (value){
                                    userName = value;
                                  },
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
                                    hintText: '아이디',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Palette.textColor1
                                    ),
                                    contentPadding: EdgeInsets.all(10)
                                    //글씨 크기에 맞추어 애워싸는 도형 크기 조정
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  key: ValueKey(2),
                                  validator: (value){
                                    if(value!.isEmpty || !value.contains('@')){
                                      return '유효한 이메일을 입력하세요.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userEmail = value!;
                                  },
                                  onChanged: (value){
                                    userEmail = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
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
                                      hintText: '이메일',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                    //글씨 크기에 맞추어 애워싸는 도형 크기 조정
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  key: ValueKey(3),
                                  validator: (value){
                                    if(value!.isEmpty || value.length <6){
                                      return '비밀번호는 최소 7개 이상의 문자를 포함해야합니다.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userPassword = value!;
                                  },
                                  onChanged: (value){
                                    userPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
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
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                    //글씨 크기에 맞추어 애워싸는 도형 크기 조정
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                        if(!isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  key: ValueKey(4),
                                  validator: (value){
                                    if(value!.isEmpty || !value.contains('@')){
                                      return '유효한 이메일을 입력하세요.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userName = value!;
                                  },
                                  onChanged: (value){
                                    userName = value;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email,
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
                                      hintText: '이메일',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                    //글씨 크기에 맞추어 애워싸는 도형 크기 조정
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                TextFormField(
                                  key: ValueKey(5),
                                  validator: (value){
                                    if(value!.isEmpty || value.length <6){
                                      return '비밀번호는 최소 7개 이상의 문자를 포함해야합니다.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value){
                                    userPassword = value!;
                                  },
                                  onChanged: (value){
                                    userPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock,
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
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Palette.textColor1
                                      ),
                                      contentPadding: EdgeInsets.all(10)
                                    //글씨 크기에 맞추어 애워싸는 도형 크기 조정
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
            // 텍스트 폼 필드 -> code refactoring 필요.
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: isSignupScreen ? 430 : 390,
              right: 0,
              left: 0,
              child: Center(
                // positioned의 좌우 값이 가장자리까지 사용하도록하여 중앙에 위치하도록
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      _tryValidation();
                      debugPrint(userName);
                      debugPrint(userEmail);
                      debugPrint(userPassword);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [
                            Colors.lime,
                            Colors.greenAccent
                          ], // gradient는 여러 색상을 포함하므로 list 형태임
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 1,
                              spreadRadius: 1,
                            offset: Offset(0,1)
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              )
            ),
            // 하단 전송 버튼
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve:Curves.easeIn,
              top: isSignupScreen ? MediaQuery.of(context).size.height-125
              : MediaQuery.of(context).size.height-165,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  // Text(isSignupScreen ? 'or Signup with' : 'or Signin with'),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  TextButton.icon(
                      onPressed: (){},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        minimumSize: Size(155, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        backgroundColor: Palette.googleColor
                      ),
                      icon: Icon(Icons.add),
                      label: Text('Google'),
                  )
                ],
              )
            ),
            // 최하단 구글 회원가입 버튼
          ],
        ),
      ),
    );
  }
}