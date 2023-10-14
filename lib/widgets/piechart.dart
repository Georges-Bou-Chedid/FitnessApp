import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CaloriePieChart extends StatelessWidget {
  final double totalCalories;
  final double consumedCalories;

  const CaloriePieChart({Key? key, required this.totalCalories, required this.consumedCalories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: consumedCalories,
              title: "${consumedCalories.toStringAsFixed(0)} Cal\nConsumed",
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),
              titlePositionPercentageOffset: 3.5,// Display consumed calories
              radius: 15,
            ),
            PieChartSectionData(
              color: Colors.grey[400],
              value: (totalCalories - consumedCalories),
              title: "${(totalCalories - consumedCalories).toStringAsFixed(0)} Cal\nRemaining",
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black45),
              titlePositionPercentageOffset: 3.5,
              radius: 15,
            ),
          ],
          centerSpaceRadius: 60,
          sectionsSpace: 3,
          borderData: FlBorderData(
            show: true, // Set to true to show the border
            border: Border.all(color: Colors.green, width: 2), // Customize the border color and width
          ),
        ),
      swapAnimationCurve: Curves.bounceIn,
      swapAnimationDuration: const Duration(milliseconds: 2000),
    );
  }
}
