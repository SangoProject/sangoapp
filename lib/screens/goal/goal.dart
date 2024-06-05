// 목표한 거리에 대한 실제 산책 거리를 나타내는 차트와 산책 목표 거리를 수정하는 파일
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:sangoproject/screens/goal/goalGraph.dart';
import 'package:sangoproject/screens/settingSP.dart';

import '../../config/database.dart';

class Goal extends StatefulWidget {
  const Goal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Goal();
  }
}

class _Goal extends State<Goal> {
  final TextEditingController txtGoal = TextEditingController(); // 목표거리를 사용자에게 입력받는 변수
  double goalDistance = 1.0;
  double realDistance = 0.0;

  @override
  void initState() {
    super.initState();
    loadGoal().then((data) {
      setState(() {
        goalDistance = data;
      });
    });
    openRecordDatabase('recorded_data.db').then((db) {
      todayRecordSum(db).then((sum) {
        setState(() {
          realDistance = sum;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox( // 오늘의 목표를 중앙에 띄우기 위한 빈 공간
                height: 20,
                width: 20,
              ),
              Text(
                '오늘의 목표',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // 연필 아이콘 버튼. 누르면 산책목표를 수정하기 위한 팝업을 보여줌.
              IconButton(
                onPressed: () {
                  showPieDataDialog(context/*, userId*/);
                },
                icon: Image.asset(
                  'images/pencil.png',
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
        ),
        ChartPage(goalDistance, realDistance),
        Text(
          '${realDistance.toStringAsFixed(1)} / ${goalDistance.toStringAsFixed(1)} km',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // 연필 아이콘을 누르면 뜨는 팝업창
  Future<dynamic> showPieDataDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('목표 수정하기'),
            content: SingleChildScrollView(
              child: TextField(
                controller: txtGoal,
                decoration: InputDecoration(hintText: '값을 입력해주세요(1 ~ 100)'),
                // 숫자 키보드
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // 띄어쓰기를 하지 못하도록 제한
                inputFormatters: [
                  FilteringTextInputFormatter.deny(' '),
                ],
                onChanged: (value){
                  // 입력받은 값이 소수가 아니라면 입력되지 않음
                  if(double.tryParse(value) == null){
                    txtGoal.text = value.substring(0, value.length - 1);
                    txtGoal.selection = TextSelection.fromPosition(TextPosition(offset: txtGoal.text.length));
                  }
                },
              ),
            ),
            // 취소를 누르면 팝업창 사라지고 입력받은 값 초기화
            actions: [
              TextButton(
                child: Text('취소'),
                onPressed: () {
                  Navigator.pop(context);
                  txtGoal.text = '';
                },
              ),
              // 저장을 누르면 입력된 값이 1~100 사이인지 확인하고 맞으면 파이어베이스에 저장하고 아니면 저장하지 않고 팝업창 닫고 입력받은 값 초기화
              ElevatedButton(
                child: Text('저장'),
                onPressed: () async {
                  if (txtGoal.text != '' && double.parse(txtGoal.text) >= 1 && double.parse(txtGoal.text) <= 100) {
                    await saveGoal(double.parse(double.parse(txtGoal.text).toStringAsFixed(2)));
                    setState(() {
                      goalDistance = double.parse(double.parse(txtGoal.text).toStringAsFixed(2));
                    });
                  }

                  Navigator.pop(context);
                  txtGoal.text = '';
                },
              ),
            ],
          );
        }
    );
  }
}