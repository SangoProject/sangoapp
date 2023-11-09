import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:sangoproject/screens/calendar/calendarData.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../config/utils.dart';

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
  DateTime? _selectedDay;
  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context){
    String formattedDate = DateFormat.MMMMd('en_US').format(_focusedDay);

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
            ),
          ),
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                // 사용자가 날짜를 선택했을 때
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
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
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  return Center(child: Text(days[day.weekday],)
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Text(
                '$formattedDate일 산책 기록',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CalendarData(_focusedDay),
          ],
        ),
      ),
    );
  }
}