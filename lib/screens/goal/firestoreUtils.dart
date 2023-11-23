// firestore_utils.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirestoreUtils {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> fetchRecordData(DateTime selectedDate) async {
    String formattedDate = DateFormat("yyyy-MM-dd").format(selectedDate);

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection("records")
          .doc(formattedDate)
          .collection("list")
          .orderBy("date")
          .get();

      return querySnapshot.docs;
    } catch (e) {
      // Handle the error, you might want to log it or show an error message.
      print("Error fetching records: $e");
      return [];
    }
  }

  double calculateTotalDistance(List<DocumentSnapshot> records) {
    double totalDistance = 0.0;

    for (var document in records) {
      double distance = document['distance'] ?? 0.0;
      totalDistance += distance;
    }

    return totalDistance;
  }
}
