import 'package:firebase_database/firebase_database.dart';

import '../model/alerts_model.dart';

class AlertService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('alerts');

  // Save an alert to Firebase Realtime Database
  void saveAlert(Alert alert) {
    _dbRef.push().set(alert.toJson()).then((_) {
      print('Alert saved successfully');
    }).catchError((error) {
      print('Failed to save alert: $error');
    });
  }

// Method to get a stream of alerts from Firebase
  Stream<List<Alert>> getAlertsStream() {
    return _dbRef.onValue.map((event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        List<Alert> alertList = [];
        data.forEach((key, value) {
          alertList.add(Alert.fromJson(Map<String, dynamic>.from(value)));
        });
        return alertList;
      }
      return []; // Return empty list if no data exists
    });
  }
}
