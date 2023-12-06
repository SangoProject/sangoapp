// 산책한 데이터를 firestore DB에 저장하는 파일
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addRecord(double distanceTotal, String formattedTime) async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 현재 날짜와 시간 가져오기
  DateTime now = DateTime.now();

  // 날짜를 Document ID로 사용하기 위한 포매팅
  String documentId = "${now.year}-${now.month}-${now.day}";

  // records 컬렉션에 해당 날짜의 문서가 있는지 확인
  DocumentSnapshot<Map<String, dynamic>> document = await _firestore
      .collection("records")
      .doc(documentId)
      .get();

  // 해당 날짜의 문서가 없으면 생성
  if (!document.exists) {
    await _firestore.collection("records").doc(documentId).set({});
  }

  // 데이터를 list 컬렉션에 추가
  await _firestore
      .collection("records")
      .doc(documentId)
      .collection("list")
      .add({
    "date": now, // 현재의 날짜와 시간 데이터를 저장
    "distance": "${(distanceTotal / 1000).toStringAsFixed(2)} km",
    "time": formattedTime,
  });

  print('Record added to Firestore with document ID: $documentId');
}
