import 'package:flutter/material.dart';
import 'package:smart_cradle_infants_app/helper.dart';

import '../service/baby_data_service.dart';
import '../widgets/input_widgets.dart';

class HistoryRecordPage extends StatefulWidget {
  const HistoryRecordPage({super.key});

  @override
  State<HistoryRecordPage> createState() => _HistoryRecordPageState();
}

class _HistoryRecordPageState extends State<HistoryRecordPage> {
  DateTime? selectedDate;
  String temperature = '';
  String heartRate = '';
  String humidity = '';

  final BabyDataService _babyDataService = BabyDataService();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        _fetchDataForDate(picked);
      });
    }
  }

  Future<void> _fetchDataForDate(DateTime date) async {
    final formattedDate =
        Helper.formatDate(date); // Format date as dd-MM-yyyy

    try {
      final babyData = await _babyDataService.getBabyDataByDate(formattedDate);
      if (babyData != null) {
        setState(() {
          temperature = babyData.temperature
              .toString(); // Assuming BabyData has these fields
          heartRate = babyData.heartRate
              .toString(); // Assuming BabyData has these fields
          humidity = babyData.humidityLevel
              .toString(); // Assuming BabyData has these fields
        });
      } else {
        setState(() {
          temperature = 'لا توجد بيانات في التاريخ المحدد';
          heartRate = 'لا توجد بيانات في التاريخ المحدد';
          humidity = 'لا توجد بيانات في التاريخ المحدد';
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        temperature = 'Error';
        heartRate = 'Error';
        humidity = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black12,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "سجل البيانات",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                  fontSize: 16),
            ),
            const ClipOval(
              child: Image(
                image: AssetImage('Assets/logo.jpeg'),
                // Ensure the path is correct
                height: 40,
                width: 40,
                // Width should match height for a perfect circle
                fit: BoxFit.cover, // Use cover to ensure the image fits well
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'درجة الحرارة',
                      prefixIcon: Icons.thermostat_outlined,
                      controller: TextEditingController(text: temperature),
                      editable: false,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      hintText: 'معدل نبضات القلب',
                      prefixIcon: Icons.favorite_border,
                      controller: TextEditingController(text: heartRate),
                      editable: false,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      hintText: 'مستوى الرطوبة',
                      prefixIcon: Icons.water_damage_outlined,
                      controller: TextEditingController(text: humidity),
                      editable: false,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today),
                      label: Text(selectedDate == null
                          ? 'حدد تاريخ'
                          : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
