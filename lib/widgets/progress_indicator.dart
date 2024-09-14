import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double currentValue; // Current  value
  final String textType;
  final double minValue; // Minimum  range
  final double warningValue; // Value at which warning starts
  final double dangerValue; // Value at which danger starts
  final double maxValue; // Maximum Value range

  ProgressIndicatorWidget({
    required this.currentValue,
    required this.textType,
    required this.minValue,
    required this.warningValue,
    required this.dangerValue,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress as a percentage of the temperature range
    double progress = (currentValue - minValue) / (maxValue - minValue);

    // Define colors for each temperature range
    Color normalColor = Colors.green;
    Color warningColor = Colors.yellow;
    Color dangerColor = Colors.red;

    // Calculate the proportion of each temperature range
    double warningStart = (warningValue - minValue) / (maxValue - minValue);
    double dangerStart = (dangerValue - minValue) / (maxValue - minValue);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$textType',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Stack(
          children: [
            // Background with color bands
            Container(
              height: 8.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Background color
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: (warningStart * 100).toInt(),
                  child: Container(
                    color: normalColor,
                  ),
                ),
                Expanded(
                  flex: ((dangerStart - warningStart) * 100).toInt(),
                  child: Container(
                    color: warningColor,
                  ),
                ),
                Expanded(
                  flex: ((1 - dangerStart) * 100).toInt(),
                  child: Container(
                    color: dangerColor,
                  ),
                ),
              ],
            ),
            // Progress indicator overlay
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 8.0,
                width: MediaQuery.of(context).size.width * progress,
                decoration: BoxDecoration(
                  color: _getProgressColor(),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getProgressColor() {
    if (currentValue <= warningValue) {
      return Colors.green; // Normal color
    } else if (currentValue <= dangerValue) {
      return Colors.yellow; // Warning color
    } else {
      return Colors.red; // Danger color
    }
  }
}
