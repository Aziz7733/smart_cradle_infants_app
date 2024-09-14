class Alert {
  String title;
  String description;
  DateTime timestamp;

  Alert({
    required this.title,
    required this.description,
    required this.timestamp,
  });

  // Convert an Alert object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      // Store timestamp in ISO 8601 format
    };
  }

  // Create an Alert object from a JSON map
  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      title: json['title'],
      description: json['description'],
      timestamp:
          DateTime.parse(json['timestamp']), // Convert string to DateTime
    );
  }
}
