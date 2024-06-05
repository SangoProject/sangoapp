import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sangoproject/config/palette.dart';
import 'package:sangoproject/crud/crudSP.dart';
import 'package:sangoproject/mainPage.dart';

class InitGoal extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _InitGoal();
  }
}

class _InitGoal extends State<InitGoal> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드 오버플로우를 해결을 위해
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // 상단에 나타나는 뒤로가기 버튼 제거
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          '목표 설정',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(labelText: '  목표를 입력해 주세요.(1 ~ 100, 단위: km)'),
              // 숫자 키보드
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //textInputAction: TextInputAction.done,
              // 띄어쓰기를 하지 못하도록 제한
              inputFormatters: [
                FilteringTextInputFormatter.deny(' '),
              ],
              onChanged: (value){
                // 입력받은 값이 소수가 아니라면 입력되지 않음
                if (value.isNotEmpty) {
                  if(double.tryParse(value) == null){
                    _controller.text = value.substring(0, value.length - 1);
                    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
                  }
                }
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  // 입력값이 있을 경우에만 실행됨
                  if (_controller.text.isNotEmpty) {
                    double goal = double.parse(double.parse(_controller.text).toStringAsFixed(5));
                    // 1 ~ 100 사이의 값이면 저장
                    if (goal >= 1 && goal <= 100) {
                      // 목표 저장 후 mainPage로 이동
                      await updateGoal(goal);

                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    }
                    else {
                      final snackBar = SnackBar(
                        content: Text("1 ~ 100 사이의 값으로 입력해 주세요."),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      _controller.text = '';
                      setState(() {});
                    }
                  }
                  FocusScope.of(context).unfocus();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Palette.backgroundColor,
                  backgroundColor: _controller.text.isNotEmpty ? Palette.logoColor : Palette.iconColor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  '산책가자GO 시작하기',
                  style: TextStyle(fontSize: 18),
                )
            )
          ],
        ),
      )
    );
  }
    /*WillPopScope(
      onWillPop: () async {
        return false;
      },
      child:
    );
  }*/
}