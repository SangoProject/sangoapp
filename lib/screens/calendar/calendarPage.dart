// 산책 달력 화면 구조를 짜둔 페이지
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/database.dart';
import '../../config/palette.dart';
import 'package:sangoproject/screens/calendar/calendarData.dart';
import 'calendarSet.dart';

class Event {
  final DateTime date;
  Event({required this.date});
}

class CalendarPage extends StatefulWidget{
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>{
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now(); // 오늘 날짜를 포커싱하기 위한 변수
  DateTime _selectedDay = DateTime.now(); // 오늘 날짜를 디폴트로 선택하기 위한 변수
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context){
    String titleDate = DateFormat("MM월 dd일").format(_selectedDay);

    return WillPopScope(
      onWillPop: () async {

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '산책 달력',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                todayDecoration : const BoxDecoration(
                  color: Palette.green1,
                  shape: BoxShape.circle,
                ),
                selectedDecoration : const BoxDecoration(
                  color: Palette.green2,
                  shape: BoxShape.circle,
                ),
              ),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                // 사용자가 날짜를 선택했을 때
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  print('$_selectedDay');
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  return Center(child: Text(days[day.weekday],)
                  );
                },
                markerBuilder: (context, day, events) {
                  return FutureBuilder<List<Record>>(
                    future: fetchRecordData(day),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Positioned(
                          bottom: -2,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: Palette.logoColor, // 마커 색상
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Text(
                '$titleDate의 산책 기록',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CalendarData(_selectedDay),
          ],
        ),
      ),
    );
  }

  Future<List<Record>> fetchRecordData(DateTime selectedDate) async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'records.db');
    Database db = await openRecordDatabase(path);

    // 선택된 날짜의 시작과 끝 시간 계산
    DateTime startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 0);
    DateTime endOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);

    // 선택된 날짜의 데이터 가져오기
    var result = await db.query(
      'records',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
      orderBy: 'date DESC',
    );

    return result.map((map) => Record.fromMap(map)).toList();
  }
}