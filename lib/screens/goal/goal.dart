// 목표한 거리에 대한 실제 산책 거리를 나타내는 차트와 산책 목표 거리를 수정하는 파일
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:sangoproject/screens/goal/goalGraph.dart';
import 'package:sangoproject/screens/goal/realDistanceTotal.dart';

class Goal extends StatelessWidget{
  final TextEditingController txtGoal = TextEditingController(); // 목표거리를 사용자에게 입력받는 변수
  final String userId = FirebaseAuth.instance.currentUser?.email ?? '';
  final String realDistance = '';

  Goal({super.key}); // 실제 움직인 거리 변수

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
                  showPieDataDialog(context, userId);
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
        // Goal 클래스 내부의 StreamBuilder 부분
        StreamBuilder(
          // 목표값이 수정되었다면 수정된 값을 불러와서 UI를 수정해줌.
          stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
          builder: (context, snapshot) {
            // 값을 불러오지 못 한다면 CircularProgressIndicator를 띄움.
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            // 에러가 났다면 에러 메시지를 띄움.
            else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Error: ${snapshot.hasError}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            // 데이터를 정상적으로 불러왔을 경우
            else {
              final goalDistance = snapshot.data!['goal'];

              // 오늘 산책한 거리 합을 반환하여 차트에 적용하는 빌더
              return FutureBuilder(
                future: RealDistanceTotal().fetchAndCalculateTotalDistance(DateTime.now()),
                builder: (context, distanceSnapshot) {
                  if (distanceSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    double realDistance = distanceSnapshot.data ?? 0.0;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          // ChartPage를 띄움. (목표한 거리와 실제 움직인 거리의 비율 그래프)
                          ChartPage(goalDistance.toString(), realDistance.toString()),
                          Text(
                            '${realDistance.toStringAsFixed(2)} / $goalDistance km',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }

  // 연필 아이콘을 누르면 뜨는 팝업창
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
                onPressed: (){
                  if (txtGoal.text != '' && double.parse(txtGoal.text) >= 1 && double.parse(txtGoal.text) <= 100) {
                    FirebaseFirestore update = FirebaseFirestore.instance;
                    update.collection('users').doc(userId).update({
                      'goal' : double.parse(double.parse(txtGoal.text).toStringAsFixed(2))
                    }).then(
                        (value) => print("DocumentSnapshot successfully updated!"),
                      onError: (e) => print("Error updating document $e")
                    );
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

  // firestore에 저장된 오늘 날짜 산책기록 데이터를 가져오기
  Stream<QuerySnapshot> fetchRecordData(DateTime today) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.email;

    // today를 yyyy-MM-dd 형태의 문자열로 변환
    String formattedDate = DateFormat("yyyy-MM-dd").format(today);

    // records 컬렉션에서 해당 날짜의 문서 가져오기
    return _firestore
        .collection("users").doc(userId)
        .collection("records").doc(formattedDate)
        .collection("list")
        .orderBy("date")
        .snapshots();
  }
}