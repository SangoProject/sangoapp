// // 산책한 데이터를 firestore DB에 저장하는 파일
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// Future<void> addRecord(double distanceTotal, String formattedTime) async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   User? user = FirebaseAuth.instance.currentUser;
//   DateTime now = DateTime.now();
//
//   String? userId = user?.email;
//   String documentId = "${now.year}"
//       "-${now.month < 10 ? '0${now.month}' : now.month}"
//       "-${now.day < 10 ? '0${now.day}' : now.day}";
//
//   DocumentSnapshot<Map<String, dynamic>> userDocument = await firestore
//       .collection("users").doc(userId)
//       .collection("records").doc(documentId)
//       .get();
//
//   // 해당 날짜의 문서가 없으면 생성
//   if (!userDocument.exists) {
//     await firestore
//         .collection("users").doc(userId)
//         .collection("records").doc(documentId)
//         .set({});
//   }
//
//   // 데이터를 list 컬렉션에 추가
//   await firestore
//       .collection("users").doc(userId)
//       .collection("records").doc(documentId)
//       .collection("list")
//       .add({
//     "date": now, // 현재의 날짜와 시간 데이터를 저장
//     "distance": "${(distanceTotal / 1000).toStringAsFixed(2)} km",
//     "time": formattedTime,
//   });
//
//   print('Record added to Firestore with document ID: $documentId');
// }
