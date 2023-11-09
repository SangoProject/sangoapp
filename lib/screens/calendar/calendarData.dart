import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarData extends StatelessWidget {
  const CalendarData(DateTime focusedDay, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerheight = MediaQuery
        .of(context)
        .size
        .height;
    final bannerwidth = MediaQuery
        .of(context)
        .size
        .width;

    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('records')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              // Firestore에서 불러온 데이터를 리스트로 변환
              List<DocumentSnapshot> records = snapshot.data!.docs;

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    // 각각의 레코드에서 필요한 데이터 추출
                    String distance = records[index]['distance'];
                    String time = records[index]['time'];

                    return Container(
                      width: bannerwidth,
                      margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                            spreadRadius: 2, // 그림자 확장 범위
                            blurRadius: 5, // 그림자 흐림 범위
                            offset: Offset(0, 3), // 그림자 위치 (x, y)
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              '${index+1}번째 기록',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
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
                  }
              );
            }
        )
    );
  }
}