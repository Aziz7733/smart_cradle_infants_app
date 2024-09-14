import 'package:flutter/material.dart';

import '../model/baby_model.dart';
import '../service/baby_data_service.dart';
import '../widgets/progress_indicator.dart';

class LastRecordPage extends StatefulWidget {
  const LastRecordPage({super.key});

  @override
  State<LastRecordPage> createState() => _LastRecordPageState();
}

class _LastRecordPageState extends State<LastRecordPage> {
  final BabyDataService babyDataService = BabyDataService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BabyData?>(
      stream: babyDataService.getLastRecordStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            strokeWidth: 7.0,
            color: Colors.teal,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('لا توجد بيانات متاحة.'));
        } else {
          final babyData = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " البيانات الحالية للطفل بتاريخ: ${babyData.saveDate}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Icon(
                      Icons.thermostat_outlined,
                      size: 28.0,
                      color: Colors.teal,
                    ),
                    ProgressIndicatorWidget(
                      currentValue: babyData.temperature,
                      textType: "درجة الحرارة: ${babyData.temperature}°C",
                      minValue: 36.5,
                      warningValue: 37.6,
                      dangerValue: 38.5,
                      maxValue: 40.0,
                    ),
                    SizedBox(height: 20),
                    Icon(
                      Icons.water_damage_outlined,
                      size: 28.0,
                      color: Colors.blue,
                    ),
                    ProgressIndicatorWidget(
                      currentValue: babyData.humidityLevel.toDouble(),
                      textType: "مستوى الرطوبة: ${babyData.humidityLevel}%",
                      minValue: 30.0,
                      warningValue: 61.0,
                      dangerValue: 70.0,
                      maxValue: 100.0,
                    ),
                    SizedBox(height: 20),
                    Icon(
                      Icons.favorite_border,
                      size: 28.0,
                      color: Colors.red,
                    ),
                    ProgressIndicatorWidget(
                      currentValue: babyData.heartRate.toDouble(),
                      textType: 'معدل نبضات القلب : ${babyData.heartRate} bpm',
                      minValue: 60.0,
                      warningValue: 100.0,
                      dangerValue: 120.0,
                      maxValue: 180.0,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          babyData.isCrying ? Icons.mood_bad : Icons.mood,
                          size: 28.0,
                          color: babyData.isCrying ? Colors.red : Colors.green,
                        ),
                        SizedBox(width: 10),
                        Text(
                          babyData.isCrying ? 'الطفل يبكي' : 'الطفل هادئ',
                          style: TextStyle(
                            fontSize: 16.0,
                            color:
                                babyData.isCrying ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            // Formatting the date as dd-MM-yyyy
                            Navigator.pushNamed(context, 'history');
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(fontSize: 16),
                            ),
                          ),
                          child: const Text(
                            'عرض سجل البيانات',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
