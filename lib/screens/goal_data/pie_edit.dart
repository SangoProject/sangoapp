import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sangoproject/config/sp_helper.dart';
import 'pie_data.dart';

class PieDataScreen extends StatefulWidget {
  @override
  _PieDataScreenState createState() => _PieDataScreenState();
}

class _PieDataScreenState extends State<PieDataScreen> {
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
              controller: txtGoal,
              decoration: InputDecoration(hintText: '값을 입력해주세요(단위: km)'
              ),
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
                onPressed: savePieData,
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