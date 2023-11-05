import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addRecord(double distanceTotal, String formattedTime) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timestamp now = Timestamp.fromDate(DateTime.now()); // 현재 날짜와 시간 가져오기
  await _firestore.collection("records").add({
    "date": now, // 현재의 날짜와 시간 데이터를 Timestamp로 저장
    "distance": "${(distanceTotal / 1000).toStringAsFixed(2)} km",
    "time": formattedTime,
  });
  print('Record added to Firestore');
}