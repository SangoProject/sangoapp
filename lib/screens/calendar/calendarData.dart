import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CalendarData extends StatelessWidget {
  final DateTime selectedDate;

  const CalendarData(this.selectedDate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerwidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: fetchRecordData(selectedDate),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          // Firestore에서 불러온 데이터를 리스트로 변환
          List<DocumentSnapshot> list = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            itemBuilder: (context, index) {
              // 각각의 레코드에서 필요한 데이터 추출
              String distance = list[index]['distance'];
              String time = list[index]['time'];

              return Container(
                width: bannerwidth,
                margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
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
                  child: Column(
                    children: [
                      Text(
                        '${index + 1}번째 기록',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '이동 거리: $distance, 산책 시간: $time',
                        style: TextStyle(
                          color: Colors.black,
                        ),
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

  Stream<QuerySnapshot> fetchRecordData(DateTime selectedDate) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // selectedDate를 yyyy-MM-dd 형태의 문자열로 변환
    String formattedDate = DateFormat("yyyy-MM-dd").format(selectedDate);

    // records 컬렉션에서 해당 날짜의 문서 가져오기
    return _firestore
        .collection("records")
        .doc(formattedDate)
        .collection("list")
        .orderBy("date")
        .snapshots();
  }
}