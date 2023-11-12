import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

import 'package:sangoproject/screens/goal/goalGraph.dart';
import 'package:sangoproject/screens/goal/statisticsPage.dart';

class Goal extends StatelessWidget{
  TextEditingController txtGoal = TextEditingController();
  final String uid = 'kim';

  @override
  Widget build(BuildContext context) {
    String realDistance = '0';

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '오늘의 목표',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    showPieDataDialog(context, uid);
                  },
                  icon: Image.asset('images/pencil.png'),
                ),
              ],
            ),
          ),
          // 수정 필요, 실제 움직인 거리 가져와야 됨
          StreamBuilder(
            stream: FirebaseDatabase.instance.ref("USERS").child(uid).child("GOAL").onValue,
            builder: (context, snapshot){
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              }
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Error: ${snapshot.hasError}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      ChartPage(snapshot.data?.snapshot.value.toString(), realDistance),
                      Text(
                        '$realDistance / ${snapshot.data?.snapshot.value.toString()} km',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => StatisticsPage()));
            },
            child: Text("이번 주 통계 보기"),
          )
        ],
      ),
    );
  }

  Future<dynamic> showPieDataDialog(BuildContext context, String uid) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('목표 수정하기'),
            content: SingleChildScrollView(
              child: TextField(
                controller: txtGoal,
                decoration: InputDecoration(hintText: '값을 입력해주세요(1 ~ 100)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(' '),
                ],
                onChanged: (value){
                  if(double.tryParse(value) == null){
                    txtGoal.text = value.substring(0, value.length - 1);
                    txtGoal.selection = TextSelection.fromPosition(TextPosition(offset: txtGoal.text.length));
                  }
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text('취소'),
                onPressed: () {
                  Navigator.pop(context);
                  txtGoal.text = '';
                },
              ),
              ElevatedButton(
                child: Text('저장'),
                onPressed: (){
                  if (txtGoal.text != '' && double.parse(txtGoal.text) >= 1 && double.parse(txtGoal.text) <= 100) {
                    FirebaseDatabase updateData = FirebaseDatabase.instance;
                    updateData.ref("USERS").child(uid).update({"GOAL": txtGoal.text});
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