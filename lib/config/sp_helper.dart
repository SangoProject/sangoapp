// pie data의 shared preferences 사용을 위한 helper

import 'package:shared_preferences/shared_preferences.dart';
import '../screens/goal_data/pie_data.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writePieData(PieData pieData) async {
    prefs.setString(
      pieData.id.toString(), json.encode(pieData.toJson())
    );
  }
}