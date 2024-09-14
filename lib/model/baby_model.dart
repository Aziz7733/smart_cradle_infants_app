class BabyData {
  int heartRate;
  int humidityLevel;
  double temperature;
  bool isCrying;
  String saveDate;

  BabyData({
    required this.heartRate,
    required this.humidityLevel,
    required this.temperature,
    required this.isCrying,
    required this.saveDate,
  });

  // Convert BabyData object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'heart_rate': heartRate,
      'humidity_level': humidityLevel,
      'temperature': temperature,
      'is_crying': isCrying,
      'save_date': saveDate,
    };
  }

  // Convert JSON to BabyData object
  factory BabyData.fromJson(Map<String, dynamic> json) {
    return BabyData(
      heartRate: json['heart_rate'],
      humidityLevel: json['humidity_level'],
      temperature: json['temperature'],
      isCrying: json['is_crying'],
      saveDate: json['save_date'],
    );
  }
}
