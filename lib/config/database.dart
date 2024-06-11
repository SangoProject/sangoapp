import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openRecordDatabase(String path) async {
  // 데이터베이스 경로 가져오기
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'recorded_data.db');

  // 데이터베이스가 있는지 확인
  var exists = await databaseExists(path);

  // 없으면 생성
  if (!exists) {
    // 데이터베이스 폴더 생성
    await Directory(dirname(path)).create(recursive: true);

    // 데이터베이스 파일 열기
    var db = await openDatabase(path);

    // 테이블 생성
    await db.execute('''
      CREATE TABLE records (
        date TEXT NOT NULL,
        distance DOUBLE NOT NULL,
        time TEXT NOT NULL
      )
    ''');
    return db;
  } else {
    // 있으면 연결
    return await openDatabase(path);
  }
}

Future<void> addRecord(Database db, DateTime date, double distance, String time) async {
  print('Adding record: Date: $date, Distance: ${(distance / 1000).toStringAsFixed(2)}, Time: $time');
  await db.insert('records', {
    'date': date.toIso8601String(),
    'distance': (distance / 1000).toStringAsFixed(2),
    'time': time,
  });
}

Future<List<Record>> getRecords(Database db, DateTime selectedDate) async {
  // 선택된 날짜의 시작 시간과 종료 시간 계산
  DateTime startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 0);
  DateTime endOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);

  // 해당 날짜의 기록만 가져오는 쿼리 실행
  var records = await db.query(
    'records',
    where: 'date BETWEEN ? AND ?',
    whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
    orderBy: 'date DESC',
  );

  return records.map((map) => Record.fromMap(map)).toList();
}

Future<double> todayRecordSum(Database db) async {
  // 현재 날짜의 시작 시간과 종료 시간 계산
  DateTime now = DateTime.now();
  DateTime todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0);
  DateTime todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

  // 오늘 날짜 범위에 해당하는 데이터 가져오기
  var result = await db.rawQuery('''
    SELECT distance FROM records 
    WHERE date BETWEEN ? AND ?
  ''', [todayStart.toIso8601String(), todayEnd.toIso8601String()]);

  // 거리 값들 합산
  double sum = result.fold(0, (previous, current) => previous + (current['distance'] as double));

  return sum;
}

class Record {
  // final int id;
  final DateTime date;
  final double distance;
  final String time;

  Record({
    // required this.id,
    required this.date,
    required this.distance,
    required this.time,
  });

  factory Record.fromMap(Map<String, dynamic> map) {
    return Record(
      // id: map['id'] as int,
      date: DateTime.parse(map['date'] as String),
      distance: map['distance'] as double,
      time: map['time'] as String,
    );
  }
}