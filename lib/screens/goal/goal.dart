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
    String realDistance = '0.78';

    return Container(
      child: Column(
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
                IconButton(
                  onPressed: () {
                    showPieDataDialog(context, uid);
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                        spreadRadius: 2, // 그림자 확장 범위
                        blurRadius: 5, // 그림자 흐림 범위
                        offset: Offset(0, 3), // 그림자 위치 (x, y)
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '산책 통계',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => StatisticsPage()));
                          },
                          icon: Icon(Icons.chevron_right)
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StatisticsPage()),
                      );
                    },
                    splashColor: Colors.grey,
                    highlightColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
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