// 산책 달력 화면 구조에 대한 파일
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:sangoproject/screens/calendar/calendarData.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../config/palette.dart';
import 'calendarEvent.dart';

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
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
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
                  // Call `setState()` when updating calendar format
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
                  Stream<QuerySnapshot> eventsStream = fetchRecordData(day);

                  // 이벤트(산책기록 데이터)를 나타내는 스트림
                  return StreamBuilder<QuerySnapshot>(
                    stream: eventsStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      // 이벤트 목록을 가져오기
                      List<DocumentSnapshot> events = snapshot.data!.docs;

                      // 이벤트가 있는 경우 연두색 동그라미 표시
                      if (events.isNotEmpty) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            shape: BoxShape.circle,
                          ),
                          width: 5,
                          height: 5,
                        );
                      } else {
                        // 이벤트가 없는 경우 아무것도 표시하지 않습니다.
                        return Container();
                      }
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

  Stream<QuerySnapshot<Object?>> fetchRecordData(DateTime day) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // day를 yyyy-MM-dd 형태의 문자열로 변환
    String formattedDate = DateFormat("yyyy-MM-dd").format(day);

    // records 컬렉션에서 해당 날짜의 문서 가져오기
    return _firestore
        .collection("records")
        .doc(formattedDate)
        .collection("list")
        .orderBy("date")
        .snapshots();
  }
}