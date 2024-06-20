import 'package:fl_chart/fl_chart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../config/database.dart';

Future<List<FlSpot>> fetchWeeklyData(DateTime now) async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'records.db');
  Database db = await openRecordDatabase(path);

  // 현재 요일을 기준으로 시작 요일 계산
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

  List<FlSpot> spots = [];

  // startOfWeek부터 오늘까지의 데이터를 가져오기
  for (int i = - 1; i < now.weekday; i++) {
    DateTime date = startOfWeek.add(Duration(days: i));
    double totalDistance = await getDayDistanceSum(db, date);
    spots.add(FlSpot(i + 1, totalDistance));
  }

  // 남은 요일에 대한 데이터 0으로 채우기
  for (int i = now.weekday; i < 7; i++) {
    spots.add(FlSpot(i + 1, 0));
  }

  return spots;
}

Future<double> calculateWeeklyAverage(DateTime now) async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'records.db');
  Database db = await openRecordDatabase(path);

  // 현재 요일을 기준으로 시작 요일 계산 (일요일 기준)
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

  double totalSum = 0.0;
  int totalDays = now.weekday;

  // startOfWeek부터 오늘까지의 데이터를 가져와서 총 합을 계산
  for (int i = 0; i < totalDays; i++) {
    DateTime date = startOfWeek.add(Duration(days: i));
    double daySum = await getDayDistanceSum(db, date);
    totalSum += daySum;
  }

  // 평균 계산
  double average = totalSum / totalDays;

  return average;
}

Future<double> getDayDistanceSum(Database db, DateTime date) async {
  DateTime startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
  DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

  var result = await db.rawQuery('''
    SELECT SUM(distance) as total_distance FROM records 
    WHERE date BETWEEN ? AND ?
  ''', [startOfDay.toIso8601String(), endOfDay.toIso8601String()]);

  return (result.first['total_distance'] as double?) ?? 0.0;
}