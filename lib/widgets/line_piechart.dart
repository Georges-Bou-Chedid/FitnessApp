import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinePieChart extends StatelessWidget {
  final double totalCalories;
  final double remainingCalories;

  LinePieChart({
    required this.totalCalories,
    required this.remainingCalories,
  });

  @override
  Widget build(BuildContext context) {
    double percent = (totalCalories - remainingCalories) / totalCalories;

    return LinearPercentIndicator(
      animation: true,
      animationDuration: 1000,
      lineHeight: 15.0,
      percent: percent,
      center: Text(
        '${(percent * 100).toInt()}%',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.green,
      backgroundColor: Colors.grey,
    );
  }
}
