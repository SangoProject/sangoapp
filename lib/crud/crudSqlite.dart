import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initDB() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'library.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE library('
            'id INTEGER PRIMARY KEY,'
            'course_level INTEGER,'
            'course_name TEXT,'
            'distance REAL,'
            'lead_time INTEGER)',
      );
    },
  );
}

Future<dynamic> loadData() async {
  final db = await initDB();
  final dataList = await db.query('library');
  return dataList;
}

Future<void> addData(int courseLevel, String courseName, double distance, int leadTime) async {
  final db = await initDB();
  await db.insert(
    'library',
    {
      'course_level': courseLevel,
      'course_name': courseName,
      'distance': distance,
      'lead_time': leadTime,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  loadData();
}

/*Future<void> updateData(int id, int courseLevel, String courseName, double distance, int leadTime) async {
  final db = await initDB();
  await db.update(
    'library',
    {
      'course_level': courseLevel,
      'course_name': courseName,
      'distance': distance,
      'lead_time': leadTime,
    },
    where: 'id = ?',
    whereArgs: [id],
  );
  loadData();
}*/

Future<void> deleteData(String courseName) async {
  final db = await initDB();
  await db.delete(
    'library',
    where: 'course_name = ?',
    whereArgs: [courseName],
  );
  loadData();
}