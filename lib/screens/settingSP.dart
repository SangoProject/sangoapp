import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTerms(bool b) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('terms', b);
}

Future<void> saveGoal(double b) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble('goal', b);
}

Future<dynamic> loadTerms() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('terms')) saveTerms(false);
  return prefs.get('terms');
}

Future<dynamic> loadGoal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(!prefs.containsKey('goal')) saveGoal(5.0);
  return prefs.get('goal');
}

/*
Future<void> removeData(String s) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(s);
}*/
