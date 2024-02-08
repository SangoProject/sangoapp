// 산책이 기록된 특정 날짜에 대한 데이터를 담은 위젯
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarData extends StatelessWidget {
  final DateTime selectedDate;

  const CalendarData(this.selectedDate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerwidth = MediaQuery
        .of(context)
        .size
        .width;
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: fetchRecordData(selectedDate),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          // Firestore에서 불러온 데이터를 리스트로 변환
          List<DocumentSnapshot> list = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            itemBuilder: (context, index) {
              // 각각의 산책 기록 records에서 불러온 데이터 가공
              String distance = list[index]['distance'];
              String time = list[index]['time'];
              DateTime recordDateTime = list[index]['date'].toDate();

              // 분류 기준에 따라 산책 시간대를 결정
              String walkTime;
              if (recordDateTime.hour >= 2 && recordDateTime.hour < 6) {
                walkTime = '새벽 산책';
              } else if (recordDateTime.hour >= 6 && recordDateTime.hour < 10) {
                walkTime = '아침 산책';
              } else if (recordDateTime.hour >= 10 && recordDateTime.hour < 17) {
                walkTime = '낮 산책';
              } else if (recordDateTime.hour >= 17 && recordDateTime.hour < 22) {
                walkTime = '저녁 산책';
              } else {
                walkTime = '밤 산책';
              }

              return Container(
                width: bannerwidth,
                margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
                decoration: BoxDecoration(
                  gradient: getGradientForWalkTime(walkTime),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 'date'를 기준으로 분류한 산책 시간대
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          walkTime,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // distance와 time column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.directions_walk,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  distance,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.timer_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  time,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // 산책 목록 UI 디자인 요소
  LinearGradient getGradientForWalkTime(String walkTime) {
    switch (walkTime) {
      case '새벽 산책':
        return LinearGradient(
          colors: [Color(0xFF5D4E83), Color(0xFFC18582)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case '아침 산책':
        return LinearGradient(
          colors: [Color(0xFF6092D6), Color(0xFFEDD685)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case '낮 산책':
        return LinearGradient(
          colors: [Color(0xFF4691E1), Color(0xFF7BBBE8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case '저녁 산책':
        return LinearGradient(
          colors: [Color(0xFF7D557D), Color(0xFFC5523D), Color(0xFFED9C33)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case '밤 산책':
        return LinearGradient(
          colors: [Color(0xFF0C1328), Color(0xFF153D73)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return LinearGradient(
          colors: [Colors.transparent, Colors.transparent],
        );
    }
  }

    Stream<QuerySnapshot> fetchRecordData(DateTime selectedDate) {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      User? user = FirebaseAuth.instance.currentUser;
      String? userId = user?.email;

      // selectedDate를 yyyy-MM-dd 형태의 문자열로 변환
      String formattedDate = DateFormat("yyyy-MM-dd").format(selectedDate);

      // records 컬렉션에서 해당 날짜의 문서 가져오기
      return _firestore
          .collection("users").doc(userId)
          .collection("records").doc(formattedDate)
          .collection("list")
          .orderBy("date")
          .snapshots();
    }
  }