import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateTerms(bool b) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('terms', b);
}

Future<void> updateGoal(double b) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble('goal', b);
}

Future<dynamic> loadTerms() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('terms')) updateTerms(false);
  return prefs.get('terms');
}

Future<dynamic> loadGoal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('goal')) updateGoal(5.0);
  return prefs.get('goal');
}

/*
Future<void> deleteData(String s) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(s);
}*/
