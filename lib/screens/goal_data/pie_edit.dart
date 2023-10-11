import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sangoproject/config/sp_helper.dart';
import 'pie_data.dart';
import 'package:firebase_database/firebase_database.dart';

class PieDataScreen extends StatefulWidget {
  @override
  _PieDataScreenState createState() => _PieDataScreenState();
}

class _PieDataScreenState extends State<PieDataScreen> {
  String uid = "kim";
  final TextEditingController txtGoal = TextEditingController();
  final SPHelper helper = SPHelper();

  @override
  void initState() {
    helper.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Image.asset('images/pencil.png'),
      onPressed: () {
        showPieDataDialog(context);
      },
    );
  }

  Future<dynamic> showPieDataDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('목표 수정하기'),
            content: SingleChildScrollView(
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: txtGoal,
                decoration: InputDecoration(hintText: '값을 입력해주세요(단위: km)'
                ),
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
                  }
              ),
              ElevatedButton(
                onPressed: (){
                  FirebaseDatabase _updateData = FirebaseDatabase.instance;
                  _updateData.ref("USERS").child(uid).update({"GOAL": txtGoal.text});
                  Navigator.pop(context);
                  txtGoal.text = '';
                },
                child: Text('저장'),
              )
            ],
          );
        }
    );
  }

  Future savePieData() async {
    PieData newPieData = PieData(1, txtGoal as double);
    helper.writePieData(newPieData);
    txtGoal.text = '';
    Navigator.pop(context);
  }
}