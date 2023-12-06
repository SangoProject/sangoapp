// 하루에 실제 산책한 거리에 데한 데이터를 합산하는 함수 및 클래스
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RealDistanceTotal {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<List<DocumentSnapshot>> fetchRecordData(DateTime today) async {
    String formattedDate = DateFormat("yyyy-MM-dd").format(today);

    try {
      QuerySnapshot querySnapshot = await _firestore
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

  double calculateTotalDistance(List<DocumentSnapshot> list) {
    double totalDistance = 0.0;

    for (var document in list) {
      String distanceString = document['distance'] ?? '0.0 km';
      double distance = extractNumberFromDistanceString(distanceString);
      totalDistance += distance;
    }

    return totalDistance;
  }

  double extractNumberFromDistanceString(String distanceString) {
    RegExp regex = RegExp(r'(\d+(\.\d+)?)');
    Match? match = regex.firstMatch(distanceString);
    return double.parse(match?.group(1) ?? '0.0');
  }
}