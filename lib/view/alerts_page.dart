import 'package:flutter/material.dart';
import 'package:smart_cradle_infants_app/helper.dart';

import '../model/alerts_model.dart';
import '../service/alert_service.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  final AlertService _alertService = AlertService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Alert>>(
      stream: _alertService.getAlertsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            strokeWidth: 7.0,
            color: Colors.teal,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'لا توجد تنبيهات حتى الان',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          );
        } else {
          final alerts = snapshot.data!;
          return ListView.builder(
            itemCount: alerts.length,
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: ListTile(
                  leading: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red[700],
                  ),
                  title: Text(
                    alert.title,
                    textAlign: TextAlign.right, // Align text to the right
                  ),
                  subtitle: Text(
                    alert.description,
                    textAlign: TextAlign.right, // Align text to the right
                  ),
                  trailing: Text(
                    Helper.formatDateTime(alert.timestamp),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.left, // Align text to the left
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
