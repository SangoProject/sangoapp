// 하루에 실제 산책한 거리에 데한 데이터를 합산하는 함수 및 클래스
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class RealDistanceTotal {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // DB에 저장되어 있는 총 산책 거리의 fetch
  Future<double> fetchAndCalculateTotalDistance(DateTime today) async {
    try {
      List<DocumentSnapshot> list = await fetchRecordData(today);
      double totalDistance = calculateTotalDistance(list);
      return totalDistance;
    } catch (e) {
      print("Error fetching and calculating total distance: $e");
      return 0.0;
    }
  }

  // DB에서 산책 데이터 불러옴
  Future<List<DocumentSnapshot>> fetchRecordData(DateTime today) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.email;
    String formattedDate = DateFormat("yyyy-MM-dd").format(today);

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("records")
          .doc(formattedDate)
          .collection("list")
          .orderBy("date")
          .get();

      return querySnapshot.docs;
    } catch (e) {
      print("Error fetching records: $e");
      return [];
    }
  }

  // 산책거리 총 합 계산
  double calculateTotalDistance(List<DocumentSnapshot> list) {
    double totalDistance = 0.0;

    for (var document in list) {
      String distanceString = document['distance'] ?? '0.0 km';
      double distance = extractNumberFromDistanceString(distanceString);
      totalDistance += distance;
    }

    return totalDistance;
  }

  // 산책 거리 타입변환 (String->double)
  double extractNumberFromDistanceString(String distanceString) {
    RegExp regex = RegExp(r'(\d+(\.\d+)?)');
    Match? match = regex.firstMatch(distanceString);
    return double.parse(match?.group(1) ?? '0.0');
  }
}