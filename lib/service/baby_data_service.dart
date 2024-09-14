import 'package:firebase_database/firebase_database.dart';

import '../model/baby_model.dart'; // Import the BabyData model

class BabyDataService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('babyData');

  // Method to get the latest record as a stream
  Stream<BabyData?> getLastRecordStream() {
    return _dbRef.limitToLast(1).onValue.map((event) {
      if (event.snapshot.exists && event.snapshot.children.isNotEmpty) {
        final latestRecord = event.snapshot.children.first;
        return BabyData.fromJson(Map<String, dynamic>.from(
            latestRecord.value as Map<dynamic, dynamic>));
      }
      return null; // Return null if no data exists
    });
  }

  // 3. Get baby data by specific date
  Future<BabyData?> getBabyDataByDate(String date) async {
    // Query the database for records where save_date matches the provided date
    Query query = _dbRef.orderByChild("save_date").equalTo(date);
    DataSnapshot snapshot = await query.get();

    if (snapshot.exists) {
      // Since the query can return multiple results, we use first or iterate over the values
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

      // Get the first matching record (assuming only one record per date)
      var firstRecord = data.values.first;

      return BabyData.fromJson(Map<String, dynamic>.from(firstRecord));
    }
    return null; // Return null if no record found
  }
}
